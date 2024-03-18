#!/usr/bin/env bash

DB=${DB:-"data.db"}

declare -A SYNCTYPES
SYNCTYPES=( ["pull"]=1 ["push"]=2 ["sync"]=3 )
declare -A SYNCTYPEKEYS
SYNCTYPEKEYS=( [1]="pull" [2]="push" [3]="sync" )

function usage {
    echo "Unoffical Tool by https://github.com/alworx for managing syncfolders"
    echo "in pCloud console clients database."
    echo 
    echo "Official pCloud console client: https://github.com/pcloudcom/console-client"
    echo
    echo "Usage: syncfolder [list|add|remove] args"
    echo 
    echo "syncfolder list"
    echo "Lists all syncfolders from the database."
    echo
    echo "syncfolder add PCLOUD_PATH LOCAL_PATH [push|pull|sync]"
    echo "Add a new syncfolder to the database."
    echo
    echo "Arguments:"
    echo "  REMOTE_PATH      path to pcloud folder separated by /"
    echo "  LOCAL_PATH       path to local folder (must be empty)"
    echo "  push|pull|sync   optional sync type [default: sync]"
    echo
    echo "Example:"
    echo "  syncfolder add My/Remote/Folder /My/Local/Folder sync"
    echo
    echo "syncfolder remove ID"
    echo "Removes a syncfolder from the database."
    echo
    echo "Arguments:"
    echo "  ID               syncfolder id to remove (browse with 'syncfolder list')"
    echo
    echo "Path to sqlite database can be overriden by setting an environment variable"
    echo "\"DB\" containing the path to the database file. Default: DB=\"data.db\"."
    echo 
    echo "CAUTION: make sure the console client is not running when modifying the database!"
    echo
}

function quit {
    if [ -n "$2" ]; then
        echo $2
    fi
    exit $1
}

function get_pcloud_path {
    sqlite3 "$DB" "
    with recursive folderpath(id, name, path) as (
        select parentfolderid, name, name
        from folder where id=$1
        
        union all
        
        select folder.parentfolderid, folder.name, folder.name || '/' || path
        from folderpath join folder
        on folderpath.id = folder.id
    )
    select path from folderpath where id is null;
    "
}

# TODO get syncfolders including full pcloud paths in a single SQL statement
# function list_syncfolders2 {
#     sqlite3 "$DB" -table "
#     WITH RECURSIVE folderpath(id, name, path) AS (
#         select parentfolderid, name, name
#         from folder join syncfolder where folder.id=syncfolder.folderid
        
#         union all
        
#         select folder.parentfolderid, folder.name, folder.name || '/' || path
#         from folderpath join folder
#         on folderpath.id = folder.id
#     )
#     select id, (SELECT path FROM folderpath where name=''), localpath, synctype, flags from syncfolder;"
# }

function list_syncfolders {
    echo "id   pcloud-path   local-path   synctype   flags"
    for syncfolder in $(sqlite3 "$DB" "
    select id, folderid, localpath, synctype, flags from syncfolder;")
    do
        IFS='|' read -r id folderid localpath synctype flags <<< "$syncfolder"
        pcloudfolder=$(get_pcloud_path "$folderid")
        echo "$id   $pcloudfolder   $localpath   ${SYNCTYPEKEYS[$synctype]}   $flags"
    done
    
}

function get_pcloud_folderid_by_path {
    ID=0
    IFS='/' read -ra names <<< "$1"
    for name in "${names[@]}"; do
        ID=$(sqlite3 "$DB" "select id from folder where parentfolderid=$ID and name='$name';")
    done
    echo "$ID"
}

function add_syncfolder {
    folder_id=$(get_pcloud_folderid_by_path "$1")    
    if [ -z "$folder_id" ]; then
        quit 1 "Could not find pcloud folder \"$1\""
    fi
    localpath="$2"
    if [ ! -d "$localpath" ]; then
        quit 1 "Could not find local directory \"$localpath\""
    fi
    
    # if [ -n "$(ls -A "$localpath")" ]; then
    #     quit 1 "Local directory not empty"
    # fi

    read -r inode device <<<"$(stat -c "%i %d" "$localpath")"
    synctype="${3:-sync}"

    if [ "$synctype" != "push" ] && [ "$synctype" != "pull" ] && [ "$synctype" != "sync" ]; then
        quit EINVAL "Invalid sync type \"$synctype\" - allowed values: push, pull, sync"
    fi

    sqlite3 "$DB" "insert into syncfolder 
        (folderid, localpath, synctype, flags, inode, deviceid)
        values ($folder_id, '$localpath', ${SYNCTYPES["$synctype"]}, 0, $inode, $device);"
}

function remove_syncfolder {
    if ! [ "$1" -eq "$1" ]; then
        exit 1
    fi

    id=$(sqlite3 "$DB" "select id from syncfolder where id=$1;")    
    if [ "$id" -eq "$1" ]; then
        sqlite3 "$DB" "delete from syncfolder where id=$1;"
    else
        echo "could not find synfolder with id=$1"
        exit 1
    fi
}

key="$1"
shift
case $key in
    list)
    list_syncfolders
    ;;
    add)
    add_syncfolder "$1" "$2" "$3"
    ;;
    remove)
    remove_syncfolder "$1"
    ;;
    *)
    usage
    ;;
esac

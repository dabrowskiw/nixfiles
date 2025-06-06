{ pkgs, lib, config, ... }:

let
  vdirsyncerconfig = pkgs.writeTextFile {
    name = "vdirsyncerconfig";
    destination = "/share/vdirsyncer.config";
    text = ''
[general]
status_path = "~/.local/share/vdirsyncer/status/"

# CALDAV
[pair HTW_calendar]
a = "HTW_calendar_local"
b = "HTW_calendar_remote"
conflict_resolution = "b wins"
collections = ["Y2FsOi8vMC8yMDk1Mg", "Y2FsOi8vMC8yMDgwMg", "Y2FsOi8vMC8zMTg3MA"]

metadata = ["displayname", "color"]

[storage HTW_calendar_local]
type = "filesystem"
path = "~/data/calendars/HTW-calendar"
fileext = ".ics"

[storage HTW_calendar_remote]
start_date = "datetime.now() - timedelta(days=61)"
end_date = "datetime.now() + timedelta(days=365)"
type = "caldav"
auth = "basic"
url = "https://ox.htw-berlin.de/caldav/" 
username = "dabrows"
password.fetch = ["command", "pass", "Email/piotr.dabrowski@htw-berlin.de"]
useragent = "Thunderbird"
item_types = ["VEVENT", "VTODO"]

[pair Posteo_calendar]
a = "Posteo_calendar_local"
b = "Posteo_calendar_remote"
conflict_resolution = "b wins"
collections = ["aarvay", "default", "oqzfeh"]
 
# Calendars also have a color property
metadata = ["displayname", "color"]

[storage Posteo_calendar_local]
type = "filesystem"
path = "~/data/calendars/Posteo"
fileext = ".ics"

[storage Posteo_calendar_remote]
start_date = "datetime.now() - timedelta(days=1)"
end_date = "datetime.now() + timedelta(days=365)"
type = "caldav"
# Digest authentication as done by default by Baikal is broken in vdirsyncer.
auth = "basic"
url = "https://posteo.de:8443/calendars/piotr.dabrowski/" 
username = "Piotr.Dabrowski@posteo.de"
password.fetch = ["command", "pass", "Email/piotr.dabrowski@posteo.de"]
item_types = ["VEVENT", "VTODO"]

# CARDDAV
[pair Posteo_global]
a = "Posteo_collected_local"
b = "Posteo_collected_remote"
collections = ["from a", "from b"]
metadata = ["displayname"]

[storage Posteo_collected_local]
type = "filesystem"
path = "~/data/addresses/Posteo/"
fileext = ".vcf"

[storage Posteo_collected_remote]
type = "carddav"
# Digest authentication as done by default by Baikal is broken in vdirsyncer.
auth = "basic"
url = "https://posteo.de:8443/"
username = "Piotr.Dabrowski@posteo.net"
password.fetch = ["command", "pass", "Email/piotr.dabrowski@posteo.de"]
    '';
  };
in
{
  home.packages = [
    pkgs.vdirsyncer
    vdirsyncerconfig
  ];

  home.file.".config/vdirsyncer/config".source = "${vdirsyncerconfig}/share/vdirsyncer.config";

  home.activation = {
    vdirsyncerConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.local/share/vdirsyncer/status/
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/calendars/Posteo/
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/calendars/HTW-calendar/
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/addresses/Posteo/
    '';
  };
}

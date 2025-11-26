{ pkgs, lib, config, ... }:

let
  pimsyncconfig = pkgs.writeTextFile {
    name = "pimsyncconfig";
    destination = "/share/pimsync.config";
    text = ''
status_path ~/data/calendars/pimsync_status

pair HTW_calendar {
  storage_a HTW_calendar_local
  storage_b HTW_calendar_remote
  collection Y2FsOi8vMC8yMDk1Mg
  collection Y2FsOi8vMC8yMDgwMg
  collection Y2FsOi8vMC8zMTg3MA
  conflict_resolution cmd nvim -d
}

storage HTW_calendar_local {
  type vdir/icalendar
  path ~/data/calendars/HTW-calendar
  fileext ics
}

storage HTW_calendar_remote {
  type caldav
  url https://ox.htw-berlin.de/caldav/
  username dabrows
  user_agent Thunderbird
  password {
    shell pass show Email/piotr.dabrowski@htw-berlin.de | head -1
  }
}
    '';
  };
in
{
  home.packages = [
    pkgs.pimsync
    pimsyncconfig
  ];

  home.file.".config/pimsync/pimsync.conf".source = "${pimsyncconfig}/share/pimsync.config";

}


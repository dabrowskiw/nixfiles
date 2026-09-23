{ pkgs, ... }:

let
  teamsAnna = pkgs.writeTextFile {
    name = "teamsAnna";
    destination = "/bin/teamsAnna";
    executable = true;
    text = ''
#!/usr/bin/env bash

teams-for-linux --class=teams-anna --user-data-dir=/home/wojtek/.config/teams-profile-anna/
    '';
  };
  teamsSophia = pkgs.writeTextFile {
    name = "teamsSophia";
    destination = "/bin/teamsSophia";
    executable = true;
    text = ''
#!/usr/bin/env bash

teams-for-linux --class=teams-sophia --user-data-dir=/home/wojtek/.config/teams-profile-sophia/
    '';
  };
in
{ 
  home.packages = [
    teamsAnna
    teamsSophia
    pkgs.teams-for-linux
  ];
}



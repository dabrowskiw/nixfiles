{ pkgs, ... }:

{
  home.packages = [
    pkgs.espanso
  ];

  home.file.".config/espanso" = {
    source = ./dotfiles/espanso;
    recursive = true;
  };

  systemd.user.services.espanso-unmanaged = {
    Unit = {
      Description = "Start espanso for the user session";
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "espanso-unmanaged" ''
      #!/usr/bin/env bash
      ${pkgs.espanso}/bin/espanso service start --unmanaged
    ''}";
    };
    Install = {
      WantedBy = [ "default.target" "graphical.target" "multi-user.target" ];
    };
  };
}

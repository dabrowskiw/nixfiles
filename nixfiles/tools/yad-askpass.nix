{ pkgs, lib, ... }:

{
  home.packages = [
    pkgs.yad
  ];

  home.file.".config/scripts/yad-askpass".source = pkgs.writeShellScript "yad-askpass" ''
  yad --center --width=300 --entry --hide-text --no-buttons --title=Authentication --text=Password --on-top --fixed
  '';

  home.sessionVariables = {
    PATH = "$PATH:/home/wojtek/.config/scripts/";
    SSH_ASKPASS = lib.mkForce "yad-askpass";
  };
}


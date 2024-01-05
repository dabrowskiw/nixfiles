{ pkgs, ... }:
 
{
  home.packages = [
    pkgs.bash
    pkgs.dante
    pkgs.fish
    pkgs.fishPlugins.bobthefish
    pkgs.gnupg
    pkgs.keepassxc
    pkgs.libsForQt5.konsole
    pkgs.ncdu
    pkgs.notmuch
    pkgs.nvimpager
    pkgs.powerline-fonts
    pkgs.pinentry-gtk2
    pkgs.tmux
    pkgs.ueberzugpp
    pkgs.wget
    (import ./pcloud.nix)
    (import ./bumblebee-status.nix)
  ];
}

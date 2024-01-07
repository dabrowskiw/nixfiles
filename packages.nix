{ pkgs, ... }:
 
{
  home.packages = [
    pkgs.bash
    pkgs.bc
    pkgs.black
    pkgs.dante
    pkgs.fishPlugins.bobthefish
    pkgs.gnupg
    pkgs.keepassxc
    pkgs.ncdu
    pkgs.notmuch
    pkgs.nvimpager
    pkgs.openjdk
    pkgs.powerline-fonts
    pkgs.pinentry-gtk2
    pkgs.tmux
    pkgs.ueberzugpp
    pkgs.wget
    pkgs.xournalpp
    (import ./pcloud.nix)
    (import ./bumblebee-status.nix)
    (import ./pcloud.nix)
  ];
}

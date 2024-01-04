{ pkgs, ... }:

{
  home.packages = [
    pkgs.dante
    pkgs.fish
    pkgs.fishPlugins.bobthefish
    pkgs.gnupg
    pkgs.keepassxc
    pkgs.libsForQt5.konsole
    pkgs.notmuch
    pkgs.nvimpager
    pkgs.powerline-fonts
    pkgs.tmux
    pkgs.ueberzugpp
  ];
}

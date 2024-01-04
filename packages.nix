{ pkgs, ... }:

{
  home.packages = [
    pkgs.dante
    pkgs.fish
    pkgs.fishPlugins.bobthefish
    pkgs.gnupg
    pkgs.keepassxc
    pkgs.libsForQt5.konsole
    pkgs.powerline-fonts
    pkgs.tmux
  ];
}

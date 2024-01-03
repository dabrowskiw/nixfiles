{ pkgs, ... }:

{
  home.packages = [
    pkgs.powerline-fonts
    pkgs.libsForQt5.konsole
    pkgs.fish
    pkgs.fishPlugins.bobthefish
  ];
}

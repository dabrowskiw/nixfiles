{ pkgs, ... }:
 
{
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.lutris
    pkgs.jetbrains.idea-ultimate
    pkgs.zoom-us
  ];
}


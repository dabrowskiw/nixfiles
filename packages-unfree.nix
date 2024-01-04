{ pkgs, ... }:
 
{
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.lutris
    pkgs.zoom-us
  ];
}


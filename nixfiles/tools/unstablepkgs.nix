{ config, pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    chroncal
    pcloud
    typst
    opencode
  ];
}


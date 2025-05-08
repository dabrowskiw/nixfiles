{ config, pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    typst
    pcloud
#    (pkgs-unstable.callPackage ./pcloud.nix { inherit pkgs-unstable; })
  ];
}


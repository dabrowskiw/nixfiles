{ config, pkgs, ... }:
let
  unstable = import
    (builtins.fetchTarball https://github.com/nixos/nixpkgs/archive/a76c4553d7e741e17f289224eda135423de0491d.tar.gz )
    { config = config.nixpkgs.config; };
in
{
  home.packages = with unstable; [
    typst
  ];
}


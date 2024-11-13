{ config, pkgs, ... }:
let
  unstable = import
    (builtins.fetchTarball{
      url="https://github.com/nixos/nixpkgs/archive/a76c4553d7e741e17f289224eda135423de0491d.tar.gz";
      sha256="0rwdzp942b8ay625lqgra83qrp64b3wqm6w9a0i4z593df8x822v";
    })
    { config = config.nixpkgs.config; };
in
{
  home.packages = with unstable; [
    typst
  ];
}


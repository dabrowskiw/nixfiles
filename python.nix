{ pkgs, ... }:

{
 home.packages = [
  (pkgs.python3.withPackages (ps: with ps; [
    click
    debugpy
    flake8
    psutil
    pytest
    (import ./piecash.nix)
  ]))
 ];
}

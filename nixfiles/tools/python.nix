{ pkgs, mypythonPackages, ... }:

{
 home.packages = [
  (pkgs.python3.withPackages (ps: with ps; [
    click
    debugpy
    flake8
    psutil
    pytest
    pypdf2
    reportlab
    setuptools
    debugpy # for vimspector
    (callPackage ./piecash.nix { inherit mypythonPackages; })
  ]))
 ];
}

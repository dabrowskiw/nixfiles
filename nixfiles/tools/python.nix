{ pkgs, mypythonPackages, ... }:

{
 home.packages = [
  (pkgs.python3.withPackages (ps: with ps; [
    click
    debugpy
    flake8
    inquirerpy
    lz4
    psutil
    pytest
    pypdf2
    pypng
    reportlab
    requests
    setuptools
    tqdm
    unidecode
    debugpy # for vimspector
#    (callPackage ./piecash.nix { inherit mypythonPackages; })
  ]))
 ];
}

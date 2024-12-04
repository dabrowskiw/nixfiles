{ pkgs, python3Packages, ... }:

python3Packages.buildPythonPackage rec {
  pname = "khal-autocomplete";
  version = "0.11.2";

  src = pkgs.fetchgit {
    url = "https://github.com/AFoeee/additional-urwid-widgets";
    rev = "681f6d59e18d22291826d7642a5912e7b7f26089";
    sha256 = "sha256-sdW43ce9/LoxyS1Nfb8GamAqfODJGHealkg45HaC87k=";
  };

  nativeBuildInputs = with pkgs.python311Packages; [
    setuptools
    urwid
  ];
}


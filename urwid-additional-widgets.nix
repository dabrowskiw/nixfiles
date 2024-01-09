with import <nixpkgs> {}; # bring all of Nixpkgs into scope

with python311Packages;

python3.pkgs.buildPythonPackage rec {
  pname = "khal-autocomplete";
  version = "0.11.2";

  src = fetchgit {
    url = "https://github.com/AFoeee/additional-urwid-widgets";
    rev = "681f6d59e18d22291826d7642a5912e7b7f26089";
    sha256 = "sha256-sdW43ce9/LoxyS1Nfb8GamAqfODJGHealkg45HaC87k=";
  };

  nativeBuildInputs = [
    setuptools
    urwid
  ];
}


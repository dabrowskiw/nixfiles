with import <nixpkgs> {}; # bring all of Nixpkgs into scope

stdenv.mkDerivation rec {
  pname = "bumblebee-status";
  version = "2.2.0";

  buildInputs = [
    pkgs.python3
  ];

  src = fetchFromGitHub {
    owner = "tobi-wan-kenobi";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-+RCg2XZv0AJnexi7vnQhEXB1qSoKBN1yKWm3etdys1s=";
  };

  installPhase = ''
  mkdir -p $out/bumblebee-status
  mv ./* $out/bumblebee-status/
  '';
}



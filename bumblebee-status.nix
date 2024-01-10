#with import <nixpkgs> {}; # bring all of Nixpkgs into scope
#with pkgs.python3Packages;

let
nixpkgs = import <nixpkgs> {};
inherit (nixpkgs) stdenv pkgs;
xkbgroup = pkgs.python3Packages.python.pkgs.buildPythonPackage rec {
  pname = "xkbgroup";
  version = "0.2.0";

  src = nixpkgs.fetchFromGitHub {
    owner = "hcpl";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-9MZGqR8Xmdh0mN32G8qB6J4YsLnH0BATSOyxjDubKsk=";
  };

  buildInputs = [
    nixpkgs.xorg.libX11
  ];
};



bumblebee-status = pkgs.python3Packages.python.pkgs.buildPythonPackage rec {
  pname = "bumblebee-status";
  version = "2.2.0";

  src = nixpkgs.fetchFromGitHub {
    owner = "tobi-wan-kenobi";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-+RCg2XZv0AJnexi7vnQhEXB1qSoKBN1yKWm3etdys1s=";
  };

  nativeBuildInputs = [
    nixpkgs.iw
    nixpkgs.python311Packages.netifaces
    nixpkgs.python311Packages.psutil
    nixpkgs.python311Packages.pytest
    nixpkgs.python311Packages.speedtest-cli
    xkbgroup
  ];

};

in bumblebee-status

# stdenv.mkDerivation rec {
#   pname = "bumblebee-status";
#   version = "2.2.0";

#   buildInputs = [
#     pkgs.python3
#   ];

#   src = fetchFromGitHub {
#     owner = "tobi-wan-kenobi";
#     repo = pname;
#     rev = "v${version}";
#     sha256 = "sha256-+RCg2XZv0AJnexi7vnQhEXB1qSoKBN1yKWm3etdys1s=";
#   };

#   installPhase = ''
#   mkdir -p $out/bumblebee-status
#   mv ./* $out/bumblebee-status/
#   '';
# }



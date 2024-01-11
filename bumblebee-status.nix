with import <nixpkgs> {};

python3.pkgs.buildPythonApplication rec {
  pname = "bumblebee-status";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "tobi-wan-kenobi";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-+RCg2XZv0AJnexi7vnQhEXB1qSoKBN1yKWm3etdys1s=";
  };

  nativeBuildInputs = [
    iw
    python311Packages.netifaces
    python311Packages.psutil
    python311Packages.pytest
    python311Packages.speedtest-cli
  ];

  doCheck = false;
}


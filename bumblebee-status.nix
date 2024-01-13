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

  postInstall = ''
  cp -r ./themes $out/${python3.sitePackages}
  echo "#!/usr/bin/env bash" > $out/bin/bumblebee-status-new
  echo "python3 $out/bin/.bumblebee-status-wrapped \"\$@\"" >> $out/bin/bumblebee-status-new
  chmod ugo+x $out/bin/bumblebee-status-new
  '';

  doCheck = false;
}


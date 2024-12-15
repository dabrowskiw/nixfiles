{ pkgs, mypythonPackages, ... }:

mypythonPackages.buildPythonApplication rec {
  pname = "bumblebee-status";
  version = "2.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "tobi-wan-kenobi";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-+RCg2XZv0AJnexi7vnQhEXB1qSoKBN1yKWm3etdys1s=";
  };

  nativeBuildInputs = with mypythonPackages; [
    pkgs.iw
    netifaces
    psutil
    pytest
    speedtest-cli
  ];

  postInstall = ''
  cp -r ./themes $out/${pkgs.python3.sitePackages}
  echo "#!/usr/bin/env bash" > $out/bin/bumblebee-status-new
  echo "python3 $out/bin/.bumblebee-status-wrapped \"\$@\"" >> $out/bin/bumblebee-status-new
  chmod ugo+x $out/bin/bumblebee-status-new
  '';

  doCheck = false;
}


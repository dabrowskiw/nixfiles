with import <nixpkgs> {}; # bring all of Nixpkgs into scope
with python311Packages;

python3.pkgs.buildPythonPackage rec {
  pname = "piecash";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "sdementen";
    repo = "piecash";
    rev = "refs/tags/${version}";
    hash = "sha256-b8Hewc8HsaDWs+44Cp2F5w/WGLIUFyCX6pusH2quXog=";
  };

  format = "setuptools";

  propagatedBuildInputs = [
    (import ./sqlalchemy-1.4.nix)
    (import ./sqlalchemy-utils-0.37.9.nix)
    pytz
    tzlocal
    click
    pymysql
    python-dateutil
  ];
  
  buildInputs = [
    setuptools
  ];

  doCheck = false;

#  postInstall = ''
#  $DRY_RUN_CMD cp *.bash $out/bin/
#  '';
}

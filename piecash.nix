{ pkgs, python3Packages, ...}:

python3Packages.buildPythonPackage rec {
  pname = "piecash";
  version = "1.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "sdementen";
    repo = "piecash";
    rev = "refs/tags/${version}";
    hash = "sha256-b8Hewc8HsaDWs+44Cp2F5w/WGLIUFyCX6pusH2quXog=";
  };

  format = "setuptools";

  propagatedBuildInputs = with pkgs.python311Packages; [
    (pkgs.callPackage ./sqlalchemy-1.4.nix {})
    (pkgs.callPackage ./sqlalchemy-utils-0.37.9.nix {})
    pytz
    tzlocal
    click
    pymysql
    python-dateutil
  ];
  
  buildInputs = with pkgs.python311Packages; [
    setuptools
  ];

  doCheck = false;

#  postInstall = ''
#  $DRY_RUN_CMD cp *.bash $out/bin/
#  '';
}

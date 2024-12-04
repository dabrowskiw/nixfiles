{ pkgs, python3Packages, ... }:

python3Packages.buildPythonPackage rec {
  pname = "sqlalchemy";
  version = "1.4.51";

  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/c5/ab/81bef2f960abf3cdaf32fbf1994f0c6f5e6a5f1667b5713ed6ebf162b6a2/SQLAlchemy-1.3.24.tar.gz";
    hash = "sha256-67t3fL+TEjWbiXv4G6ANrg9ctp+6KhgmXcwYpvXvdRk=";
  };

  propagatedBuildInputs = with pkgs.python311Packages; [
    pymysql
    python-dateutil
  ];
  
  buildInputs = with pkgs.python311Packages; [
    setuptools
  ];

  doCheck = false;
}


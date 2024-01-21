with import <nixpkgs> {}; # bring all of Nixpkgs into scope
with python311Packages;

python3.pkgs.buildPythonPackage rec {
  pname = "sqlalchemy";
  version = "1.4.51";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/c5/ab/81bef2f960abf3cdaf32fbf1994f0c6f5e6a5f1667b5713ed6ebf162b6a2/SQLAlchemy-1.3.24.tar.gz";
    hash = "sha256-67t3fL+TEjWbiXv4G6ANrg9ctp+6KhgmXcwYpvXvdRk=";
  };

  propagatedBuildInputs = [
    pymysql
    python-dateutil
  ];
  
  buildInputs = [
    setuptools
  ];

  doCheck = false;
}


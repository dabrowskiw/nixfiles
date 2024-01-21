with import <nixpkgs> {}; # bring all of Nixpkgs into scope
with python311Packages;

python3.pkgs.buildPythonPackage rec {
  pname = "sqlalchemy-utils";
  version = "0.37.9";

  src = fetchurl {
    url = "https://files.pythonhosted.org/packages/6b/71/8da8a230490126ac94efdbab7d78a0248a9b5e51e0c1fda1f134b5ecb4c9/SQLAlchemy-Utils-0.37.9.tar.gz";
    hash = "sha256-RmftvcsezgEQdraXcu9SS/uxfMl+A/Ee5rhdmOd0HWE=";
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


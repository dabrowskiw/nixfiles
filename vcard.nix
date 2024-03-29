with import <nixpkgs> {}; # bring all of Nixpkgs into scope
with python311Packages;

python3.pkgs.buildPythonApplication rec {
  pname = "vcard";
  version = "0.15.4";

  src = fetchFromGitLab {
    owner = "engmark";
    repo = "vcard";
    rev = "refs/tags/v${version}";
    hash = "sha256-7GNq6PoWZgwhhpxhWOkUEpqckeSfzocex1ZGN9CTJyo=";
  };

  format = "setuptools";

  propagatedBuildInputs = [
    python-dateutil
  ];
  
  buildInputs = [
    setuptools
  ];

  postInstall = ''
  $DRY_RUN_CMD cp *.bash $out/bin/
  '';
}

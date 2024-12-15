{ pkgs, mypythonPackages, ...}:

mypythonPackages.buildPythonApplication rec {
  pname = "vcard";
  version = "0.15.4";

  src = pkgs.fetchFromGitLab {
    owner = "engmark";
    repo = "vcard";
    rev = "refs/tags/v${version}";
    hash = "sha256-7GNq6PoWZgwhhpxhWOkUEpqckeSfzocex1ZGN9CTJyo=";
  };

  format = "pyproject";

  propagatedBuildInputs = with mypythonPackages; [
    python-dateutil
  ];
  
  nativeBuildInputs = with mypythonPackages; [
    pip
  ];

  buildInputs = with mypythonPackages; [
    setuptools
  ];

  dontCheckRuntimeDeps = true;

  postInstall = ''
  $DRY_RUN_CMD cp *.bash $out/bin/
  '';
}

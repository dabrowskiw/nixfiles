{ pkgs, python3Packages, ...}:

python3Packages.buildPythonApplication rec {
  pname = "vcard";
  version = "0.15.4";

  src = pkgs.fetchFromGitLab {
    owner = "engmark";
    repo = "vcard";
    rev = "refs/tags/v${version}";
    hash = "sha256-7GNq6PoWZgwhhpxhWOkUEpqckeSfzocex1ZGN9CTJyo=";
  };

  format = "pyproject";

  propagatedBuildInputs = with pkgs.python311Packages; [
    python-dateutil
  ];
  
  nativeBuildInputs = with pkgs.python311Packages; [
    pip
  ];

  buildInputs = with pkgs.python311Packages; [
    setuptools
  ];

  dontCheckRuntimeDeps = true;

  postInstall = ''
  $DRY_RUN_CMD cp *.bash $out/bin/
  '';
}

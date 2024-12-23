{ pkgs, lib, mypythonPackages, ...}:


mypythonPackages.buildPythonApplication rec {
  pname = "khal-autocomplete";
  version = "0.11.3";

  src = pkgs.fetchgit {
    url = "https://github.com/dabrowskiw/khal.git";
    rev = "8d6e79271295f7a60625b18fd75be5c934d11298";
    sha256 = "sha256-N9JwpkjkbmS7b4PrkRYIsqv5IPEopuxExllZkXdqo+4";
  };

  SETUPTOOLS_SCM_PRETEND_VERSION = version;

  format = "pyproject";

  propagatedBuildInputs = with mypythonPackages; [
    pkgs.glibcLocales
    atomicwrites
    click
    click-log
    configobj
    freezegun
    icalendar
    lxml
    pkginfo
    psutil
    python-dateutil
    pytz
    pyxdg
    requests-toolbelt
    tzlocal
    urwid
    vdirsyncer
    (pkgs.callPackage ./urwid-additional-widgets.nix { inherit mypythonPackages; } )
  ];

  nativeBuildInputs = with mypythonPackages; [
    pkgs.glibcLocales
    pkgs.installShellFiles
    atomicwrites
    click
    click-log
    configobj
    debugpy
    flake8
    freezegun
    icalendar
    lxml
    pip
    pkginfo
    psutil
    pytest
    python-dateutil
    pytz
    pyxdg
    requests-toolbelt
    tzlocal
    urwid
    vdirsyncer
    setuptools
     setuptools_scm
    wheel
  ];


  nativeCheckInputs = with pkgs; [
    freezegun
    hypothesis
    packaging
    pytestCheckHook
    vdirsyncer
  ];

  postInstall = ''
    # shell completions
    installShellCompletion --cmd khal \
      --bash <(_KHAL_COMPLETE=bash_source $out/bin/khal) \
      --zsh <(_KHAL_COMPLETE=zsh_source $out/bin/khal) \
      --fish <(_KHAL_COMPLETE=fish_source $out/bin/khal)

    # man page
  '';

  doCheck = false;

  LC_ALL = "en_US.UTF-8";

  meta = with lib; {
    description = "CLI calendar application";
    homepage = "http://lostpackets.de/khal/";
    license = licenses.mit;
    maintainers = with maintainers; [ gebner ];
  };
}

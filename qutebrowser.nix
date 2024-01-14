{ lib, pkgs, config, ... }:

{ 
  home.packages = [
    pkgs.qutebrowser
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
    };
  };

  home.sessionVariables.DEFAULT_BROWSER = "${pkgs.qutebrowser}/bin/qutebrowser";

  home.activation = {
    qutebrowserConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.config/qutebrowser/
      $DRY_RUN_CMD cp -r ${builtins.toPath ./dotfiles/qutebrowser}/* ${config.home.homeDirectory}/.config/qutebrowser/
    '';
  };

}



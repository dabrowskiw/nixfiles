{ lib, pkgs, config, ... }:

{ 
  home.packages = [
    pkgs.qutebrowser
  ];

  home.activation = {
    qutebrowserConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.config/qutebrowser/
      $DRY_RUN_CMD cp -r ${builtins.toPath ./dotfiles/qutebrowser}/* ${config.home.homeDirectory}/.config/qutebrowser/
    '';
  };

}



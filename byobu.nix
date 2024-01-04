{ pkgs, config, lib, ... }:

{
  home.packages = [
    pkgs.byobu
  ];

  home.activation = {
    byobuConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD rm -rf ${config.home.homeDirectory}/.byobu
      $DRY_RUN_CMD cp -r ${builtins.toPath ./dotfiles/byobu} ${config.home.homeDirectory}/.byobu
    '';
  };
}

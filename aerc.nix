{ pkgs, lib, config, ... }:

{
  home.packages = [
    pkgs.aerc
  ];

  home.activation = {
    aercConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD  rm -rf ${config.home.homeDirectory}/.config/aerc/
      $DRY_RUN_CMD cp -r ${builtins.toPath ./dotfiles/aerc}/ ${config.home.homeDirectory}/.config/
      $DRY_RUN_CMD chmod 600 ${config.home.homeDirectory}/.config/aerc/accounts.conf
    '';
  };
}

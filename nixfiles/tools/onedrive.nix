{ pkgs, lib, config, ... }:

{
  home.packages = [
    pkgs.onedrive
  ];

  home.activation = {
    onedriveConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
#      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.config/onedrive/
#      $DRY_RUN_CMD cp -ru ${builtins.toPath ./secrets/onedrive}/* ${config.home.homeDirectory}/.config/onedrive/
    '';
 };
}

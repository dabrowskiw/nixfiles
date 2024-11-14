{ pkgs, pkgs-unstable, lib, config, ... }:

{

  home.packages = with pkgs-unstable; [ #with pkgs-unstable; [
    aerc
  ];

  home.file."runikhal".source = config.lib.file.mkOutOfStoreSymlink "/home/wojtek/home-manager/dotfiles/runikhal";

  home.activation = {
    aercConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD rm -rf ${config.home.homeDirectory}/.config/aerc/
      $DRY_RUN_CMD cp -r ${builtins.toPath ./dotfiles/aerc}/ ${config.home.homeDirectory}/.config/
      $DRY_RUN_CMD chmod -Rf u+w ${config.home.homeDirectory}/.config/aerc/ 
      $DRY_RUN_CMD chmod 600 ${config.home.homeDirectory}/.config/aerc/accounts.conf
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.config/aerc/filters
      $DRY_RUN_CMD ln -s ${pkgs.aerc}/libexec/aerc/filters/html ${config.home.homeDirectory}/.config/aerc/filters/html
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.config/scripts
      $DRY_RUN_CMD cp ${builtins.toPath ./dotfiles/runikhal} ${config.home.homeDirectory}/.config/scripts/
      $DRY_RUN_CMD chmod u+x ${config.home.homeDirectory}/.config/scripts/
      $DRY_RUN_CMD chmod u+x ${config.home.homeDirectory}/.config/scripts/
    '';
  };
}

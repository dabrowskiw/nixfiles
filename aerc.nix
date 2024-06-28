{ pkgs, lib, config, ... }:

{
  home.packages = [
    pkgs.aerc
  ];

  home.file.".config/scripts/exportics".source = ./dotfiles/exportics;
  home.file.".config/scripts/runikhal".source = ./dotfiles/runikhal;

  home.activation = {
    aercConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD rm -rf ${config.home.homeDirectory}/.config/aerc/
      $DRY_RUN_CMD cp -r ${builtins.toPath ./dotfiles/aerc}/ ${config.home.homeDirectory}/.config/
      $DRY_RUN_CMD chmod 600 ${config.home.homeDirectory}/.config/aerc/accounts.conf
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.config/aerc/filters
      $DRY_RUN_CMD ln -s ${pkgs.aerc}/libexec/aerc/filters/html ${config.home.homeDirectory}/.config/aerc/filters/html
    '';
  };
}

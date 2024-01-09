{ pkgs, lib, config, ... }:

{
  home.packages = [
    pkgs.vdirsyncer
  ];

  home.file.".config/vdirsyncer" = {
    source = ./dotfiles/vdirsyncer;
    recursive = true;
  }; 

  home.activation = {
    vdirsyncerConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.local/share/vdirsyncer/status/
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/calendars/Posteo/
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/calendars/HTW-calendar/
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/addresses/Posteo/
    '';
  };
}

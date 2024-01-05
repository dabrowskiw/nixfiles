{ lib, config, ... }:

{
  programs.mbsync = {
    enable = true;
  };

  home.file.".mbsyncrc".source = ./dotfiles/.mbsyncrc;

  home.activation = {
    mbsyncConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/mail
    '';
  };

  services.mbsync = {
    enable = true;
    frequency = "15 minutes";
  };
}

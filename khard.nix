{ pkgs, lib, config, ...}:

{
  home.packages = [
    pkgs.khard
  ];

  home.file.".config/khard/khard.conf".source = ./dotfiles/khard/khard.conf;
  home.file."data/addresses/add-uid.fish".source = ./dotfiles/khard/add-uid.fish;
  
  home.activation = {
    khardConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/addresses/Private
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/addresses/HTW-collected
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/addresses/HTW-global
    '';
  };
}

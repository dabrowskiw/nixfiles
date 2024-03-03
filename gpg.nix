{ config, lib, ...}:

{
  programs.gpg = {
    enable = true;
    settings = {
      default-key = "46107DC46CA695F7";
    };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 3456000;
    maxCacheTtl = 3456000;
    pinentryFlavor = "qt";
  };

#  home.activation = {
#    gpg = lib.hm.dag.entryAfter ["writeBoundary"] ''
#      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/.gnupg || true
#      $DRY_RUN_CMD cp -rn ${builtins.toPath ./secrets/.gnupg} ${config.home.homeDirectory}/ || true 
#      $DRY_RUN_CMD chmod -R 700 ${config.home.homeDirectory}/.gnupg || true
#      $DRY_RUN_CMD chmod 600 ${config.home.homeDirectory}/.gnupg/* || true
#    '';
#  };
}


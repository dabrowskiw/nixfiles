{ config, lib, ...}:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 3456000;
    maxCacheTtl = 3456000;
    pinentryFlavor = "qt";
  };

  home.activation = {
    gpg = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD rm -rf ${config.home.homeDirectory}/.gnupg
      $DRY_RUN_CMD cp -r ${builtins.toPath ./secrets/.gnupg} ${config.home.homeDirectory}/
      $DRY_RUN_CMD chmod -R 700 ${config.home.homeDirectory}/.gnupg
      $DRY_RUN_CMD chmod 600 ${config.home.homeDirectory}/.gnupg/*
    '';
  };
}


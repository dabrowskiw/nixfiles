{ config, lib, pkgs, ...}:

{
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      PASSWORD_STORE_CLIP_TIME = "60";
    };
  };

  home.activation = {
    pass = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD rm -rf ${config.programs.password-store.settings.PASSWORD_STORE_DIR}
      export GIT_ASKPASS=${builtins.toPath ./secrets/git_askpass.sh}
      chmod ugo+x $GIT_ASKPASS
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone https://github.com/dabrowskiw/password-store.git ${config.programs.password-store.settings.PASSWORD_STORE_DIR}
    '';
  };
}

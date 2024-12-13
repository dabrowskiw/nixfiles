{ pkgs, lib, config, ...}:

let
  khardconfig = pkgs.writeTextFile {
    name = "khardconfig";
    destination = "/share/khand.conf";
    text = ''
[addressbooks]
[[HTW]]
path = ~/data/addresses/HTW-global/
[[HTW-collected]]
path = ~/data/addresses/HTW-collected/
[[Posteo]]
path = ~/data/addresses/Posteo/default/

[contact tables]
group_by_addressbook = yes
    '';
  };
in
{
  home.packages = [
    pkgs.khard
    khardconfig
  ];

  home.file.".config/khard/khard.conf".source = "${khardconfig}/share/khard.conf";
  
  home.activation = {
    khardConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/addresses/Private
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/addresses/HTW-collected
      $DRY_RUN_CMD mkdir -p ${config.home.homeDirectory}/data/addresses/HTW-global
    '';
  };
}

{ pkgs, ... }:

{
  services.xremap = {
    enable = true;
    serviceMode = "user";
    userName = "wojtek";
    package = pkgs.xremap;
    username = "wojtek";
    config.keymap = [
      {
        name = "Roblox jump";
        remap = { "BACKSPACE" = "SPACE"; };
        application.only = [ "Sober" ];
      }
    ];
  };
}



{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.wojtek = { pkgs, ... }: {
    home.stateVersion = "23.11";
    imports = [
      /home/wojtek/home-manager/home.nix
    ];
    gtk = {
      enable = true;
      font.name = "Victor Mono SemiBold 12";
      theme = {
        name = "SolArc-Dark";
        package = pkgs.solarc-gtk-theme;
      };
    };
  };
}

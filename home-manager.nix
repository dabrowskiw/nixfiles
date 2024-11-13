{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball{
    url="https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
    sha256="00wp0s9b5nm5rsbwpc1wzfrkyxxmqjwsc1kcibjdbfkh69arcpsn";
  };
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

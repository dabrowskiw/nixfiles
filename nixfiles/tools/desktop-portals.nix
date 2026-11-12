{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal-termfilechooser
    ];

    config.common = {
      default = [ "gtk" ];

      "org.freedesktop.impl.portal.FileChooser" = [
        "termfilechooser"
      ];
    };
  };
}

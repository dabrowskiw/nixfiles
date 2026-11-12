{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];

    config.common = {
      # Use GTK for other portal interfaces.
      default = [ "gtk" ];

      # Use KDE specifically for file-open/save dialogs.
      "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
    };
  };
}

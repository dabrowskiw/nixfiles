{ pkgs, config, ... }:
 
{

  home.packages = [
    pkgs.bash
    pkgs.bc
    pkgs.black
    pkgs.dante
    pkgs.fishPlugins.bobthefish
    pkgs.gimp
    pkgs.gnome.gnome-system-monitor
    pkgs.gnupg
    pkgs.iw
    pkgs.keepassxc
    pkgs.ncdu
    pkgs.modemmanager
    pkgs.notmuch
    pkgs.nvimpager
    pkgs.openjdk
    pkgs.openssl
    pkgs.pavucontrol
    pkgs.pinentry-gtk2
    pkgs.powerline-fonts
    pkgs.pulseaudio-ctl
    pkgs.ranger
    pkgs.tmux
    pkgs.ueberzugpp
    pkgs.wget
    pkgs.wirelesstools
    pkgs.xournalpp
    (import ./khal.nix)
    (import ./pcloud.nix)
    (import ./vcard.nix)
  ];
}

{ pkgs, config, ... }:
 
{
  home.packages = [
    pkgs.bash
    pkgs.bc
    pkgs.black
    pkgs.dante
    pkgs.firefox
    pkgs.fishPlugins.bobthefish
    pkgs.gimp
    pkgs.gnome.gnome-system-monitor
    pkgs.gnumeric
    pkgs.gnupg
    pkgs.iw
    pkgs.keepassxc
    pkgs.marp-cli
    pkgs.modemmanager
    pkgs.ncdu
    pkgs.nvimpager
    pkgs.onedrive
    pkgs.openjdk
    pkgs.openssl
    pkgs.pavucontrol
    pkgs.pinentry-gtk2
    pkgs.powerline-fonts
    pkgs.pulseaudio-ctl
    pkgs.ranger
    pkgs.signal-desktop
    pkgs.threema-desktop
    pkgs.tmux
    pkgs.ueberzugpp
    pkgs.wget
    pkgs.wirelesstools
    pkgs.xournalpp
    pkgs.xsel
    pkgs.xss-lock
    (import ./khal.nix)
    (import ./bumblebee-status.nix)
    (import ./pcloud.nix)
    (import ./vcard.nix)
  ];
}

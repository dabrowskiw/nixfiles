{ pkgs, config, ... }:
 
{
  home.packages = [
    pkgs.abiword
    pkgs.bash
    pkgs.bc
    pkgs.black
    pkgs.catdoc
    pkgs.dante
    pkgs.firefox
    pkgs.fishPlugins.bobthefish
    pkgs.gimp
    pkgs.gnome.gnome-system-monitor
    pkgs.gnucash
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
    pkgs.openvpn
    pkgs.openconnect
    pkgs.pandoc
    pkgs.pavucontrol
    pkgs.pinentry-gtk2
    pkgs.powerline-fonts
    pkgs.pulseaudio-ctl
    pkgs.ranger
    pkgs.signal-desktop
    pkgs.texliveFull
    pkgs.threema-desktop
    pkgs.tmux
    pkgs.ueberzugpp
    pkgs.ungoogled-chromium
    pkgs.unzip
    pkgs.wget
    pkgs.wine-staging
    pkgs.wirelesstools
    pkgs.xsel
    pkgs.xss-lock
    (import ./bumblebee-status.nix)
    (import ./khal.nix)
    (import ./pcloud.nix)
    (import ./vcard.nix)
  ];
}

{ pkgs, config, ... }:
 
{
  home.packages = [
    pkgs.abiword
    pkgs.bash
    pkgs.bc
    pkgs.black
    pkgs.btop
    pkgs.catdoc
    pkgs.dante
    pkgs.dig 
    pkgs.file
    pkgs.fishPlugins.bobthefish
    pkgs.ghostscript
    pkgs.gimp
    pkgs.gnome.gnome-system-monitor
    pkgs.gnucash
    pkgs.gnumeric
    pkgs.gnupg
    pkgs.thc-hydra
    pkgs.iw
    pkgs.imagemagick
    pkgs.keepassxc
    pkgs.lilypond-with-fonts
    pkgs.marp-cli
    pkgs.modemmanager
    pkgs.ncdu
    pkgs.nvimpager
    pkgs.openjdk
    pkgs.openssl
    pkgs.openvpn
    pkgs.openconnect
    pkgs.pandoc
    pkgs.pavucontrol
    pkgs.pdfpc
    pkgs.pinentry-gtk2
    pkgs.powerline-fonts
    pkgs.pulseaudio-ctl
    pkgs.qimgv
    pkgs.ranger
    pkgs.signal-desktop
    pkgs.texliveFull
    pkgs.threema-desktop
    pkgs.timidity
    pkgs.tmux
    pkgs.ueberzugpp
    pkgs.ungoogled-chromium
    pkgs.unzip
    pkgs.vlc
    pkgs.wget
    pkgs.wine-staging
    pkgs.wirelesstools
    pkgs.wireshark
    pkgs.xsel
    pkgs.xss-lock
    pkgs.zathura
    (import ./bumblebee-status.nix)
    (import ./khal.nix)
    (import ./pcloud.nix)
    (import ./vcard.nix)
  ];
}

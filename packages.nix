{ pkgs, config, ... }:
 
{
  home.packages = [
    pkgs.abiword
    pkgs.arandr
    pkgs.bash
    pkgs.bc
    pkgs.black
    pkgs.btop
    pkgs.brillo # backlight control
    pkgs.bless # Hex editor
    pkgs.catdoc
    pkgs.dante
    pkgs.dig 
    pkgs.file
    pkgs.fishPlugins.bobthefish
    pkgs.fluidsynth
    pkgs.fzf
    pkgs.ghostscript
    pkgs.gimp
    pkgs.gnome.gnome-system-monitor
    pkgs.gnucash
    pkgs.gnumeric
    pkgs.gnupg
    pkgs.godot_4
    pkgs.gradle
    pkgs.thc-hydra
    pkgs.tree
    pkgs.iw
    pkgs.imagemagick
    pkgs.keepassxc
    pkgs.krita
    pkgs.libreoffice
    pkgs.libwacom
    pkgs.lilypond-with-fonts
    pkgs.marp-cli
    pkgs.modemmanager
    pkgs.nextflow
    pkgs.ncdu
    pkgs.nvimpager
    pkgs.openjdk
    pkgs.openssl
    pkgs.openvpn
    pkgs.openconnect
    pkgs.pandoc
    pkgs.pavucontrol
    pkgs.pdfpc
    pkgs.pigz
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
    pkgs.unixtools.xxd
    pkgs.unzip
    pkgs.vlc
    pkgs.vimiv-qt
    pkgs.virtualbox
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

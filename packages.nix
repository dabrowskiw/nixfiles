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
    pkgs.contour
    pkgs.dante
    pkgs.dig 
    pkgs.expect
    pkgs.file
    pkgs.fishPlugins.bobthefish
    pkgs.fluidsynth
    pkgs.fzf
    pkgs.ghostscript
    pkgs.gh
    pkgs.gimp
    pkgs.gnome.gnome-system-monitor
    pkgs.gnucash
    pkgs.gnumeric
    pkgs.gnupg
    pkgs.godot_4
    pkgs.gradle
    pkgs.tree
    pkgs.iw
    pkgs.imagemagick
    pkgs.keepassxc
    pkgs.krita
    pkgs.libreoffice
    pkgs.libsixel
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
    pkgs.pinentry-gnome3
    pkgs.powerline-fonts
    pkgs.pulseaudio-ctl
    pkgs.qimgv
    pkgs.ranger
    pkgs.signal-desktop
    pkgs.singularity
    pkgs.steam
    pkgs.texliveFull
    pkgs.threema-desktop
    pkgs.timidity
    pkgs.tmux
    pkgs.ungoogled-chromium
    pkgs.unixtools.xxd
    pkgs.unzip
    pkgs.vlc
    pkgs.virtualbox
    pkgs.w3m
    pkgs.wget
    pkgs.wine-staging
    pkgs.wirelesstools
    pkgs.wireshark
    pkgs.xorg.xkill
    pkgs.xsel
    pkgs.xss-lock
    pkgs.zathura
    (pkgs.callPackage ./bumblebee-status.nix {})
    (pkgs.callPackage ./khal.nix {})
    (pkgs.callPackage ./pcloud.nix {})
    (pkgs.callPackage ./vcard.nix {})
  ];
}

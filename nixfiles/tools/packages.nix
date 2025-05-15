{ pkgs, config, mypythonPackages, ... }:

let
  connectO2 = pkgs.writeShellScriptBin "connectO2" 
  ''
if [ ! -e /dev/wwan0mbim0 ]; then 
  echo -n "Waiting for device to come up..."
  while [ ! -e /dev/wwan0mbim0 ]; do
    sleep 1
    echo -n "."
  done
  echo " Device is up."
fi

echo -n "Unlocking device..."
mbimcli -p -d /dev/wwan0mbim0 -v --quectel-query-radio-state 2>&1 >/dev/null
mbimcli -p -d /dev/wwan0mbim0 -v --quectel-set-radio-state=on 2>&1 >/dev/null
echo " Done."
echo "Connecting..."
sleep 1
nmcli conn up O2
  '';
  connectHTW = pkgs.writeShellScriptBin "connectHTW" 
  ''
openvpn --mktun --dev tun0 --dev-type tun
openvpn --config /var/lib/openvpn/htw-vpn.conf --dev tun0
  '';
in
{
  home.packages = [
    connectHTW
    connectO2
    pkgs.abiword
    pkgs.anki
    pkgs.arandr
    pkgs.bash
    pkgs.bc
    pkgs.black
    pkgs.btop
    pkgs.brillo # backlight control
    pkgs.bumblebee-status
    pkgs.catdoc
    pkgs.contour
    pkgs.dante
    pkgs.dig 
    pkgs.expect
    pkgs.file
    pkgs.fluidsynth
    pkgs.fzf
    pkgs.ghostscript
    pkgs.gh
    pkgs.gimp
    pkgs.gnome-system-monitor
    pkgs.gnucash
    pkgs.gnumeric
    pkgs.gnupg
    pkgs.godot_4
    pkgs.gradle
    pkgs.hextazy # Hex editor
    pkgs.tree
    pkgs.iw
    pkgs.jq
    pkgs.imagemagick
    pkgs.inkscape
    pkgs.jetbrains.pycharm-community
    pkgs.keepassxc
    pkgs.kdenlive
    pkgs.khal
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
    pkgs.sops
    pkgs.steamcmd
    pkgs.steam-tui
    pkgs.texliveFull
    pkgs.threema-desktop
    pkgs.timidity
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
    (pkgs.callPackage ./vcard.nix { inherit mypythonPackages; })
  ];
}

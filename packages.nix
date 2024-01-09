{ pkgs, config, ... }:
 
{
# Allow unstable packages.
#nixpkgs.config = {
#   allowUnfree = true;
#   packageOverrides = pkgs: {
#     unstable = import <nixpkgs-unstable> {
#       config = config.nixpkgs.config;
#     };
#   };
# };

  home.packages = [
    pkgs.bash
#    pkgs.unstable.bumblebee-status
    pkgs.bc
    pkgs.black
    pkgs.dante
    pkgs.fishPlugins.bobthefish
    pkgs.gnome.gnome-system-monitor
    pkgs.gnupg
    pkgs.iw
    pkgs.keepassxc
    pkgs.ncdu
    pkgs.modemmanager
    pkgs.notmuch
    pkgs.nvimpager
    pkgs.openjdk
    pkgs.powerline-fonts
    pkgs.pulseaudio-ctl
    pkgs.pavucontrol
    pkgs.pinentry-gtk2
    pkgs.tmux
    pkgs.ueberzugpp
    pkgs.vcard
    pkgs.vdirsyncer
    pkgs.wget
    pkgs.wirelesstools
    pkgs.xournalpp
#    (import ./bumblebee-status.nix)
    (import ./khal.nix)
    (import ./pcloud.nix)
  ];
}

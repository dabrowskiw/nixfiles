{ ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-89bf41f1-7c52-48a1-832d-7b13fe6b1fa4".device = "/dev/disk/by-uuid/89bf41f1-7c52-48a1-832d-7b13fe6b1fa4";
}

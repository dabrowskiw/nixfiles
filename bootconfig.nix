{ ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-a6034c29-32b7-4009-b8d6-ea470c6910cf".device = "/dev/disk/by-uuid/a6034c29-32b7-4009-b8d6-ea470c6910cf";
}

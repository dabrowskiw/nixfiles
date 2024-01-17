# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/bootconfig.nix
      <home-manager/nixos>
    ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  environment.etc = {
    "ModemManager/fcc-unlock.d/1eac:1001".source = /home/wojtek/home-manager/dotfiles/1eac_1001;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
    LC_TYPE = "de_DE.UTF-8";
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  security.rtkit.enable = true;

  # Configure console keymap
  console.keyMap = "de";

  programs.fish.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wojtek = {
    isNormalUser = true;
    description = "wojtek";
    extraGroups = [ "networkmanager" "wheel" "audio"];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  home-manager.users.wojtek = { pgks, ... }: {
    imports = [
      /home/wojtek/home-manager/home.nix
    ];
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Cousine" ]; })
  ];

  # Allow unfree packages
  nixpkgs.config = {
  allowUnfree = true;
  pulseaudio = true;
};

services = {
  xserver = {
    layout = "de";
    xkbModel = "pc105";
    enable = true;
    windowManager.i3 = {
      enable = true;
    };
  };
  pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
  printing.enable = true;
  avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
};

systemd.services = {
  modem-manager = {
    enable = true;
    wantedBy = [ "default.target" ];
  };
  modem-manager-ensurestart = {
    description = "Ensure that ModemManager is started";
    script = ''
      ${pkgs.dbus}/bin/dbus-send --system --dest=org.freedesktop.ModemManager1 --print-reply /org/freedesktop/ModemManager1 org.freedesktop.DBus.Introspectable.Introspect
    '';
    serviceConfig = {
      Type = "oneshot";
    };
    wantedBy = [ "multi-user.target" "graphical.target" ]; 
  };
};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    bash
    dmenu
    fish
    i3lock
    lemurs
    libmbim
    libqmi
    networkmanager
    pulseaudioFull
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

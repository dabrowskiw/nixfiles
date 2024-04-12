# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let 
  userdefaults = {
    isNormalUser = true;
    shell = pkgs.fish;
  };

in 
{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      /etc/nixos/bootconfig.nix
      /etc/nixos/home-manager.nix
      /etc/nixos/secrets.nix
    ];

  virtualisation.virtualbox.host.enable = true;
  virtualisation.vmware.host.enable = true;
  users.extraGroups.vboxusers.members = [ "wojtek" ];

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

  environment.variables = {
    SSH_ASKPASS=lib.mkForce "";
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
    description = "wojtek";
    extraGroups = [ "networkmanager" "wheel" "audio"];
    packages = with pkgs; [];
  } // userdefaults;


  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Cousine" ]; })
  ];

  # Allow unfree packages
  nixpkgs.config = {
  allowUnfree = true;
  pulseaudio = true;
};

services = {
  openvpn.servers = {
    cyberghostCZ = {
      config = '' config /home/wojtek/home-manager/secrets/cyberghost/CA_CZ.conf '';
    };
  };
  rpcbind.enable = true;
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
  printing.stateless = true;
  printing.drivers = [
    pkgs.foomatic-db-ppds
  ];
  avahi.openFirewall = true;
  avahi.publish.enable = true;
  avahi.publish.addresses = true;
  avahi.nssmdns = false;
};

hardware.printers = {
  ensurePrinters = [
    {
      name = "MC3326adwe";
      location = "Home";
      deviceUri = "socket://192.168.178.90:9100";
      # Grab toe model name from "lpinfo -m""
      model = "foomatic-db-ppds/Lexmark-MC3426adw-Postscript-Lexmark.ppd.gz";
      ppdOptions = {
        PageSize = "A4";
      };
    }
  ];
  ensureDefaultPrinter = "MC3326adwe";
};

system = {
  nssModules = with pkgs.lib; optional (!config.services.avahi.nssmdns) pkgs.nssmdns;
  nssDatabases.hosts = with pkgs.lib; optionals (!config.services.avahi.nssmdns) (mkMerge [
    (mkOrder 900 [ "mdns4_minimal [NOTFOUND=return]" ]) # must be before resolve
    (mkOrder 1501 [ "mdns4" ]) # 1501 to ensure it's after dns
  ]);
};

systemd = {
  services = {
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
};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    bash
    cifs-utils
    dmenu
    fish
    i3lock
    lemurs
    libmbim
    libqmi
    networkmanager
    nfs-utils
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

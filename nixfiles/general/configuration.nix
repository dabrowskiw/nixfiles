# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-unstable, lib, hostname, ... }:

let 
  userdefaults = {
    isNormalUser = true;
    shell = pkgs.fish;
  };
  unlockscript = pkgs.writeTextFile {
    name = "unlockscript";
    destination = "/share/unlockscript";
    executable = true;
    text = ''
#!/usr/bin/env sh

# SPDX-License-Identifier: CC0-1.0
# 2021 Aleksander Morgado <aleksander@aleksander.es>
#
# Quectel EM120 FCC unlock operation
#

# require program name and at least 2 arguments
[ $# -lt 2 ] && exit 1

# first argument is DBus path, not needed here
shift

# second and next arguments are control port names
for PORT in "$@"; do
  # match port type in Linux 5.14 and newer
  grep -q MBIM "/sys/class/wwan/$PORT/type" 2>/dev/null && {
    MBIM_PORT=$PORT
    break
  }
  # match port name in Linux 5.13
  echo "$PORT" | grep -q MBIM && {
    MBIM_PORT=$PORT
    break
  }
done

# fail if no MBIM port exposed
[ -n "$MBIM_PORT" ] || exit 2

# run mbimcli operation
mbimcli --device-open-proxy --device="/dev/$MBIM_PORT" --quectel-set-radio-state=on
exit $?
    '';
  };
in 
{
  imports = [
    ./boot.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "python3.13-pypdf2-3.0.1"
    "electron-40.10.5"
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.fuse.userAllowOther = true;

  documentation.man.cache.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.kernelParams = ["kvm.enable_virt_at_load=0"];



  virtualisation = {
    libvirtd = {
      enable = true;
      package = pkgs.libvirt;
      qemu = {
        package = pkgs.qemu;
        swtpm = {
          enable = false;
          package = pkgs.swtpm;
        };
      };
    };
    spiceUSBRedirection.enable = true;
    virtualbox = {
      host = {
        enable = true;
        enableHardening = false;
        enableExtensionPack = true;
      };
    };
    waydroid.enable = true;
    docker.enable = true;
  };
  users.extraGroups.vboxusers.members = [ "wojtek" ];
  services.spice-vdagentd.enable = true;
  programs.virt-manager.enable = true;

  services.xremap = {
    enable = true;
    withX11 = true;
    serviceMode = "user";
    userName = "wojtek";
    package = pkgs.xremap;
    config.keymap = [
      {
        name = "Roblox jump";
        remap = { "KEY_BACKSPACE" = "KEY_SPACE"; };
        application.only = [ "/.*Sober/" ];
      }
    ];
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gnome pkgs.xdg-desktop-portal ];
  services.gnome.gnome-keyring.enable = lib.mkForce false;
  xdg.portal.config.common.default = "*";
  networking = {
    hostName = hostname; # Define your hostname.
  #  wireless.enable = true;  # Enables wireless support via wpa_supplicant.
 #   wireless.enable = false;
    networkmanager.enable = true;
    enableIPv6 = true;
  };
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  environment.etc = {
    "ModemManager/fcc-unlock.d/1eac:1001".source = "${unlockscript}/share/unlockscript";
  };

  environment.variables = {
    SSH_ASKPASS=lib.mkForce "";
    GIT_ASKPASS="";
  };

  environment.interactiveShellInit = ''
    unset SSH_ASKPASS GIT_ASKPASS
    export SSH_ASKPASS=
    export GIT_ASKPASS=
  '';

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
  hardware.opentabletdriver.enable = true;
  security.rtkit.enable = true;

  # Configure console keymap
  console.keyMap = "de";

  programs.fish.enable = true;
  programs.ssh.askPassword = "";
  programs.ssh.enableAskPassword = false;
  programs.dconf.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.users.wojtek = {
    description = "wojtek";
    extraGroups = [ "networkmanager" "wheel" "audio" "adbusers" "libvirtd" "docker" "fuse"];
    packages = with pkgs; [];
  } // userdefaults;


  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.cousine
  ];

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };

  services = {
    displayManager.sddm.wayland.compositor = "weston";
    openvpn.servers = {
      HTW = {
        config = "/var/lib/openvpn/htw-vpn.conf";
      };
    };
    dbus.packages = [ pkgs.gcr ];
    fwupd.enable = true;
    rpcbind.enable = true;
    xserver = {
      xkb.layout = "de";
      xkb.model = "pc105";
      enable = true;
      wacom.enable = true;
      windowManager.i3 = {
        enable = true;
      };
    };
    flatpak.enable = true;
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
    avahi.nssmdns4 = false;
    udev.packages = [ 
      pkgs.libwacom 
    ];
  };

  hardware.printers = {
    ensurePrinters = [
      {
        name = "MC3326adwe";
        location = "Home";
        deviceUri = "socket://192.168.178.99:9100";
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
    nssModules = pkgs.lib.optional true pkgs.nssmdns;
    nssDatabases.hosts = pkgs.lib.optionals true (pkgs.lib.mkMerge [
      (pkgs.lib.mkBefore [ "mdns4_minimal [NOTFOUND=return]" ]) # must be before resolve
      (pkgs.lib.mkAfter [ "mdns4" ]) # 1501 to ensure it's after dns
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
  environment.systemPackages = with pkgs; lib.remove
    [ 
      pkgs.x11-ssh-askpass 
      pkgs.gnome.gnome-keyring 
    ] (with pkgs; [
      android-tools
      bash
      cifs-utils
      dmenu
      fish
      lemurs
      libmbim
      libqmi
      networkmanager
      nfs-utils
      pulseaudioFull
      python3Packages.pyclip
      jmtpfs
      hack-font
      nixos-icons
      weston
      wl-clipboard
      xremap
  ]);

  programs.i3lock.enable = true;
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
  networking.firewall.allowedTCPPorts = [ 24800 ];
  networking.firewall.allowedUDPPorts = [ 24800 ];
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

{
  description = "Base system configuration";

  inputs = {
    # NixOS official package source, using the nixos-24.05 branch here
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mysecrets-git = {
      url = "git+ssh://git@github.com/dabrowskiw/nixsecrets.git?shallow=1";
      flake = false;
    };
  };

  outputs = inputs@{ 
    self, 
    nixpkgs, 
    nixpkgs-unstable,
    firefox-addons,
    home-manager,
    sops-nix,
    mysecrets-git,
    ... 
    }: {
      nixosConfigurations = {
        work-laptop = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = rec {
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          firefox-add = import firefox-addons {
            inherit (pkgs-unstable) fetchurl lib stdenv;
          };
          mysecrets = mysecrets-git;
          hostname = "nixos-worklaptop";
        };
        modules = [
          ./hardware-configuration.nix
          ./bootconfig.nix
          ./diskstation.nix
          ./configuration.nix
          ./secrets.nix
#          ./barriers.nix
          inputs.home-manager.nixosModules.default {
            home-manager.extraSpecialArgs = specialArgs;
          }
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.wojtek = import ./home.nix;
          }
          sops-nix.nixosModules.sops
        ];

      };
      gpu-laptop = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
            hostname = "nixos-gpulaptop";
          };
        };
        modules = [
          ./systems/gpulaptop/hardware-configuration.nix
          ./systems/gpulaptop/bootconfig.nix
          ./systems/gpulaptop/gputools.nix
          ./configuration.nix
          inputs.home-manager.nixosModules.default {
            home-manager.extraSpecialArgs = specialArgs;
          }
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.wojtek = import ./home.nix;
          }
        ];

      };
    };
  };
}

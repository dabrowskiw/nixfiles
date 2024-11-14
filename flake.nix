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
  };

  outputs = inputs@{ 
    self, 
    nixpkgs, 
    nixpkgs-unstable,
    home-manager,
    ... 
    }: {
    # Please replace my-nixos with your hostname
      nixosConfigurations = {
        work-laptop = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          pkgs-unstable = import nixpkgs-unstable {
              # Refer to the `system` parameter from
              # the outer scope recursively
              inherit system;
              # To use Chrome, we need to allow the
              # installation of non-free software.
              config.allowUnfree = true;
            };
        };
        modules = [
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./hardware-configuration.nix
          ./bootconfig.nix
          /home/wojtek/home-manager/secrets/secrets.nix
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

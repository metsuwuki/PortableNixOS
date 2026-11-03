{
  description = "Portable NixOS 26.05 workstation (Hyprland, Home Manager)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      portableModule = { ... }: {
        imports = [
          home-manager.nixosModules.home-manager
          ./modules/system/base.nix
          ./modules/system/first-boot.nix
          ./modules/system/hardware.nix
          ./modules/system/portable-safety.nix
          ./modules/system/desktop.nix
        ];
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-backup";
          users.portable = import ./home;
          extraSpecialArgs = { inherit inputs; };
        };
        environment.etc."portable-nixos/source".source = self;
      };
    in {
      nixosModules.default = portableModule;

      nixosConfigurations.portable = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs self; };
        modules = [ portableModule ];
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;

      checks.${system}.nixos-evaluation =
        self.nixosConfigurations.portable.config.system.build.toplevel;
    };
}

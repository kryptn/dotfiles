{

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.1.tar.gz"; # uncomment line for solaar version 1.1.13
      #url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland"; # Prevents version mismatch.
    # };
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      solaar,
      nix-flatpak,
      rust-overlay,
      home-manager,
      claude-code,
      anyrun,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit inputs;
        }; # this is the important part
        modules = [
          {
            environment.systemPackages = [
              anyrun.packages.${system}.anyrun
            ];
          }

          solaar.nixosModules.default

          nix-flatpak.nixosModules.nix-flatpak

          ./configuration.nix

          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                rust-overlay.overlays.default
                claude-code.overlays.default
              ];
              environment.systemPackages = [
                pkgs.rust-bin.stable.latest.default
                pkgs.claude-code
              ];
            }
          )

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.david = import ./home.nix;

          }
        ];
      };
    };
}

{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.gerrit-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        inputs.xremap-flake.nixosModules.default
        {
          services.xremap.config.keymap = [
            {
              name = "close window with ctrl_l-q";
              remap = { "Ctrl_L-q" = "Ctrl_L-w"; };
            }
            {
              name = "Delete word with Ctrl_L-w";
              remap = { "Ctrl_L-w" = "Ctrl_L-backspace"; };
            }
          ];
        }
      ];
    };
  };
}


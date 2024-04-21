{
  description = "systia's NixOS and Home-Manager flake";

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [ ./pre-commit-hooks.nix ];

      perSystem =
        { config, pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            name = "dotfiles";
            packages = with pkgs; [
              nixfmt-rfc-style
              git
            ];
            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };

          formatter = pkgs.nixfmt-rfc-style;
        };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

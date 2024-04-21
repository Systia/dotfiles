{ inputs, ... }:
let
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
in
{
  imports = [ inputs.pre-commit-hooks.flakeModule ];

  perSystem.pre-commit = {
    settings = {
      excludes = [ "flake.lock" ];
      hooks = {
        nil.enable = true;
        statix.enable = true;
        nixfmt = {
          enable = true;
          package = pkgs.nixfmt-rfc-style;
        };
      };
    };
  };
}

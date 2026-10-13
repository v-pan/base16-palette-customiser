# SPDX-License-Identifier: Unlicense
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      eachSystem =
        f:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system: f system nixpkgs.legacyPackages.${system}
        );
    in
    {
      devShells = eachSystem (
        _system: pkgs: {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nodejs

              # Use corepack to install npm/pnpm/yarn as specified in package.json
              corepack

              typescript
              typescript-language-server
              svelte-language-server
              tailwindcss-language-server
            ];
          };
        }
      );
    };
}

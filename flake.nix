{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in rec {
      # `nix develop`
      devShells.default = pkgs.mkShell {
        buildInputs = [
          # Elm
          pkgs.elmPackages.elm
          pkgs.elmPackages.elm-format
          pkgs.elmPackages.elm-json
          pkgs.elmPackages.elm-test
          pkgs.elmPackages.elm-review
          pkgs.elmPackages.elm-language-server
          pkgs.elm2nix

          # JS
          pkgs.nodejs_20
          pkgs.nodePackages.prettier
          pkgs.typescript
          pkgs.node2nix

          # Nix
          pkgs.alejandra

          # Scripts
          pkgs.just

          # Tailwind
          pkgs.rustywind
        ];
      };
    });
}

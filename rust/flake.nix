{
  inputs = {
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { flake-parts, ... } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem = { self', inputs', system, pkgs, ... }:
      let
        fenix = inputs'.fenix.packages.complete.withComponents [
          "rustc"
          "cargo"
          "rustfmt"
          "rust-analyzer"
          "clippy"
          "rust-src"
        ];

        rust-doc = pkgs.writeShellApplication {
          name = "rust-doc";
          text = ''
            xdg-open "${inputs'.fenix.packages.complete.rust-docs}/share/doc/rust/html/index.html"
          '';
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            fenix rust-doc
          ];
        };
      };
    };
}
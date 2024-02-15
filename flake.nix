{
  description = "A simple nix flake for templates, with whatever conveniences that helps.";

  outputs = { ... }:
  {
    templates."rust" = {
      path = ./rust;
      description = "For rust projects. Also includes a local rust documentation.";
      welcomeText = ''
        # Extra tools
        - rust-doc
        - Basically `rustup doc` but without rustup and with whatever version of rust is used
        '';
    };
  };
}

{
  description = "Helix editor config of Chadwick Dahlquist";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    flake-utils.url = "github:numtide/flake-utils";
    helix.url = "github:helix-editor/helix";
    colors = {
      url = ./colors.json;
      flake = false;
    };
  };

  outputs =
    {
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            inputs.helix.overlays.default
          ];
        };
      in
      rec {
        packages = {
          # Trying to read the theme toml from the nix store at runtime wasn't working,
          # so here we clobber the source, which it turn embeds my theme as the default theme.
          helix-patched = pkgs.helix.overrideAttrs (oldAttrs: {
            postPatch = (oldAttrs.postPatch or "") + ''
              echo "Replacing theme.toml with custom theme..."
              cp ${packages.theme} theme.toml
            '';
          });

          # Default is a version of `hx` that has been extended with custom config and theme.
          default = pkgs.symlinkJoin {
            name = "bugeats-helix";
            paths = [ packages.helix-patched ];
            buildInputs = [
              pkgs.makeWrapper
              pkgs.git
            ];
            postBuild = ''
              wrapProgram $out/bin/hx \
                --add-flags "--config ${packages.config}/config.toml" \
                --set COLORTERM truecolor
            '';
          };

          # Generate config.toml with languages.toml next to it, the way helix expects.
          config =
            let
              settings = (import ./settings.nix { });
              language-server = import ./language-servers.nix { inherit pkgs; };
              language = import ./languages.nix { };
            in
            (pkgs.runCommand "bugeats-helix-config" { nativeBuildInputs = [ pkgs.yj ]; } ''
              mkdir -p $out/themes

              # Generate config.toml
              echo '${builtins.toJSON settings}' | yj -jt > $out/config.toml

              # Generate languages.toml
              echo '${builtins.toJSON { inherit language-server language; }}' | yj -jt > $out/languages.toml
            '');

          # Generate the theme.toml content
          theme =
            let
              theme = import ./theme.nix {
                colors = (builtins.fromJSON (builtins.readFile inputs.colors.outPath)).colors.hex;
              };
            in
            pkgs.runCommand "theme-toml" { nativeBuildInputs = [ pkgs.yj ]; } ''
              echo '${builtins.toJSON theme}' | yj -jt > $out
            '';

        };

        devShells.default = pkgs.mkShell {
          packages = [
            packages.default
            pkgs.git # helix fetches tree-sitter stuff this way
          ];
          shellHook = ''
            echo "Helix configured. Run 'hx' to start."
          '';
        };

        # `nix run` to launch directly
        apps.default = {
          type = "app";
          program = "${packages.default}/bin/hx";
        };
      }
    );
}

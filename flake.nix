{
  description = "Helix editor config of Chadwick Dahlquist";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    nixpkgs-unstable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    flake-utils.url = "github:numtide/flake-utils";
    helix.url = "github:helix-editor/helix";
    colors.url = "github:bugeats/colors";
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
            # Stable lags too far behind for these.
            (_: _: { inherit (inputs.nixpkgs-unstable.legacyPackages.${system}) harper; })
          ];
        };

        toml = pkgs.formats.toml { };
      in
      rec {
        packages = {
          # Trying to read the theme toml from the nix store at runtime wasn't working,
          # so here we clobber the source, which in turn embeds my theme as the default theme.
          helix-patched =
            (pkgs.helix.override {
              # Exclude grammars whose upstream repos have been deleted.
              includeGrammarIf =
                grammar:
                !builtins.elem grammar.name [
                  "bovex"
                  "cairo"
                ];
            }).overrideAttrs
              (oldAttrs: {
                postPatch = (oldAttrs.postPatch or "") + ''
                  echo "Replacing theme.toml with custom theme..."
                  cp ${packages.theme} theme.toml
                '';
              });

          default = pkgs.symlinkJoin {
            name = "bugeats-helix";
            paths = [ packages.helix-patched ];
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/hx \
                --set XDG_CONFIG_HOME ${packages.config} \
                --set COLORTERM truecolor
            '';
          };

          config = pkgs.linkFarm "bugeats-helix-config" {
            "helix/config.toml" = toml.generate "config.toml" (import ./settings.nix { });
            "helix/languages.toml" = toml.generate "languages.toml" {
              language-server = import ./language-servers.nix { inherit pkgs; };
              language = import ./languages.nix { };
            };
          };

          theme = toml.generate "theme.toml" (
            import ./theme.nix {
              colors =
                (builtins.fromJSON (builtins.readFile "${inputs.colors.packages.${system}.json}/colors.json"))
                .colors.hex;
            }
          );

        };

        devShells.default = pkgs.mkShell {
          packages = [
            packages.default
            pkgs.git # helix fetches tree-sitter stuff this way
          ];
          shellHook = ''
            echo "Helix wrapped and configured with:"
            echo ""
            echo "    ${packages.config}"
            echo ""
            echo "Run 'hx' to start."
            echo ""
          '';
        };

        apps.default = {
          type = "app";
          program = "${packages.default}/bin/hx";
        };
      }
    );
}

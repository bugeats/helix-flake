# hx

Nix flake wrapping [helix](https://github.com/helix-editor/helix) with custom config, theme, and language servers. `nix run github:bugeats/hx` launches helix anywhere with full customization.

## Architecture

`flake.nix` is the single source of truth. It consumes the upstream helix flake's overlay, then layers:

- **`helix-patched`** — `.override` for grammar filtering + `.overrideAttrs` to embed custom theme into source
- **`default`** — `symlinkJoin` + `wrapProgram` pointing `XDG_CONFIG_HOME` at `packages.config` so helix loads both `config.toml` and `languages.toml` from the nix store
- **`config`** — generates `helix/config.toml` and `helix/languages.toml` from Nix expressions (`settings.nix`, `language-servers.nix`, `languages.nix`); the `helix/` subdir matches helix's expected XDG layout
- **`theme`** — generates `theme.toml` from `theme.nix` + [`bugeats/colors`](https://github.com/bugeats/colors) flake (IFD)

## Known Issues

Helix's `grammars.nix` uses `builtins.fetchTree` at eval time for every tree-sitter grammar in `languages.toml`. If any upstream repo is deleted, the entire flake fails to evaluate — not just build. The `includeGrammarIf` override on `helix-patched` is the workaround: add grammar names to the exclude list as repos vanish.

Helix's `-c/--config` CLI flag only redirects `config.toml`; `languages.toml` is always read from `$XDG_CONFIG_HOME/helix/`. The wrapper sets `XDG_CONFIG_HOME` for this reason — `--config` alone silently drops the per-language config.

## Current Focus

Build is green. Language servers use `pkgs.<name>` store paths where a
nixpkgs package exists (see `openscad-lsp`, `vtsls`); helix's built-in
language entries are inherited on merge, so `languages.nix` only overrides
languages needing custom behavior. No active task.

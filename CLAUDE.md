# hx

Nix flake wrapping [helix](https://github.com/helix-editor/helix) with custom config, theme, and language servers. `nix run github:bugeats/hx` launches helix anywhere with full customization.

## Architecture

`flake.nix` is the single source of truth. It consumes the upstream helix flake's overlay, then layers:

- **`helix-patched`** — `.override` for grammar filtering + `.overrideAttrs` to embed custom theme into source
- **`default`** — `symlinkJoin` + `wrapProgram` pointing `XDG_CONFIG_HOME` at `packages.config` so helix loads both `config.toml` and `languages.toml` from the nix store
- **`config`** — generates `helix/config.toml` and `helix/languages.toml` from Nix expressions (`settings.nix`, `language-servers.nix`, `languages.nix`); the `helix/` subdir matches helix's expected XDG layout
- **`theme`** — generates `theme.toml` from `theme.nix` + [`bugeats/colors`](https://github.com/bugeats/colors) flake (IFD)

All TOML is emitted via `pkgs.formats.toml`, which passes values as files — never inline JSON in shell strings, where quotes in config values break bash quoting.

Language servers with a nixpkgs package use `${pkgs.<name>}/bin/…` store paths (see `openscad-lsp`, `harper-ls`); the rest resolve from `PATH` at launch. Packages that must come from `nixpkgs-unstable` are overlaid onto `pkgs` in `flake.nix`, so consumers only ever see `pkgs.<name>`.

Helix merges `languages.toml` over its built-in defaults, so `languages.nix` lists only languages needing custom behavior. A language's `language-servers` array replaces the default rather than appending, so a customized language restates the defaults it keeps.

FlakeHub's `NixOS/nixpkgs/<range>` suffix is a semver range over versions FlakeHub mints: `0.1.<n>` tracks `nixpkgs-unstable`, `0.<yymm>.<n>` tracks each `nixos-<yy.mm>` release. `/0` therefore resolves to the newest *stable* release (highest `0.x`); `/0.1` is unstable.

## Known Issues

Helix's `grammars.nix` uses `builtins.fetchTree` at eval time for every tree-sitter grammar in `languages.toml`. If any upstream repo is deleted, the entire flake fails to evaluate — not just build. The `includeGrammarIf` override on `helix-patched` is the workaround: add grammar names to the exclude list as repos vanish.

Helix's `-c/--config` CLI flag only redirects `config.toml`; `languages.toml` is always read from `$XDG_CONFIG_HOME/helix/`. The wrapper sets `XDG_CONFIG_HOME` for this reason — `--config` alone silently drops the per-language config.

## Current Focus

Build is green. Trialing `harper-ls` (grammar + spelling) in place of
`typos-lsp` for `text` and `markdown`. Harper's own flake exports only a
contributor `devShell`, no package, so `pkgs.harper` (overlaid from unstable)
is the source. Harper also lints comments in code (rust, nix, ts, …) if the
trial goes well.

# hx

Nix flake wrapping [helix](https://github.com/helix-editor/helix) with custom config, theme, and language servers. `nix run github:bugeats/hx` launches helix anywhere with full customization.

## Architecture

`flake.nix` is the single source of truth. It consumes the upstream helix flake's overlay, then layers:

- **`helix-patched`** — `.override` for grammar filtering + `.overrideAttrs` to embed custom theme into source
- **`default`** — `symlinkJoin` + `wrapProgram` to inject config flags
- **`config`** — generates `config.toml` and `languages.toml` from Nix expressions (`settings.nix`, `language-servers.nix`, `languages.nix`)
- **`theme`** — generates `theme.toml` from `theme.nix` + [`bugeats/colors`](https://github.com/bugeats/colors) flake (IFD)

## Known Issues

Helix's `grammars.nix` uses `builtins.fetchTree` at eval time for every tree-sitter grammar in `languages.toml`. If any upstream repo is deleted, the entire flake fails to evaluate — not just build. The `includeGrammarIf` override on `helix-patched` is the workaround: add grammar names to the exclude list as repos vanish.

## Current Focus

Build is green. No active task.

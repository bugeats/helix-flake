# hx

A Nix flake that wraps [Helix](https://github.com/helix-editor/helix) with a custom theme, editor config, and language server wiring. Run it anywhere with full personalization — no dotfiles to symlink, no manual setup.

```
nix run github:bugeats/hx --refresh
```


## What this does

Everything Helix needs — config, theme, and language servers — is declared in Nix and baked into a single derivation. The flake consumes the upstream Helix overlay, patches the default theme into the source tree, and wraps the binary with generated `config.toml` and `languages.toml`.

The result is a portable, reproducible editor that behaves identically on any machine with [Nix installed](https://github.com/DeterminateSystems/nix-installer).


## Color system

The theme is driven by `colors.json`, a semantic palette of named color tokens (foreground, background, UI levels, diagnostics, ANSI colors). `theme.nix` maps these tokens to Helix theme scopes. Changing a color in one place propagates everywhere.


## Language support

Preconfigured language servers for Rust, TypeScript/JavaScript, CSS, YAML, Deno, and Markdown, with formatting via prettier and efm-langserver. Language server binaries are resolved from the flake's nixpkgs, so they're pinned and reproducible.

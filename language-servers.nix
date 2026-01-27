{ pkgs, ... }:
{

  rust-analyzer = {
    command = "rust-analyzer";
    config = {
      inlayHints.bindingModeHints.enable = false;
      inlayHints.closingBraceHints.minLines = 10;
      inlayHints.closureReturnTypeHints.enable = "with_block";
      inlayHints.discriminantHints.enable = "fieldless";
      inlayHints.lifetimeElisionHints.enable = "skip_trivial";
      inlayHints.typeHints.hideClosureInitialization = false;
      check.command = "clippy";
      diagnostics.disabled = [ "inactive-code" ];
      completion.privateEditable.enable = true;
      interpret.tests = true;
      cargo.allTargets = true;
      cargo.features = "all";
    };
  };

  yaml-language-server = {
    command = "yaml-language-server";
    args = [ "--stdio" ];
    config.yaml.format = true;
  };

  prettier = {
    command = "efm-langserver";
    config = {
      documentFormatting = true;
      languages =
        pkgs.lib.genAttrs [ "typescript" "javascript" "typescriptreact" "javascriptreact" "vue" ]
          (_: [
            {
              formatCommand = "prettier --stdin-filepath \${INPUT}";
              formatStdin = true;
            }
          ]);
    };
  };

  prettier-css = {
    command = "efm-langserver";
    config = {
      documentFormatting = true;
      languages = pkgs.lib.genAttrs [ "css" ] (_: [
        {
          formatCommand = "prettier --stdin-filepath \${INPUT}";
          formatStdin = true;
        }
      ]);
    };
  };

  typescript-language-server = {
    command = "typescript-language-server";
    args = [ "--stdio" ];
    config = {
      hostInfo = "helix";
      typescript.inlayHints = {
        includeInlayEnumMemberValueHints = true;
        includeInlayFunctionLikeReturnTypeHints = true;
        includeInlayFunctionParameterTypeHints = true;
        includeInlayParameterNameHints = "all";
        includeInlayParameterNameHintsWhenArgumentMatchesName = true;
        includeInlayPropertyDeclarationTypeHints = true;
        includeInlayVariableTypeHints = true;
      };
      javascript.inlayHints = {
        includeInlayEnumMemberValueHints = true;
        includeInlayFunctionLikeReturnTypeHints = true;
        includeInlayFunctionParameterTypeHints = true;
        includeInlayParameterNameHints = "all";
        includeInlayParameterNameHintsWhenArgumentMatchesName = true;
        includeInlayPropertyDeclarationTypeHints = true;
        includeInlayVariableTypeHints = true;
      };
    };
  };

  vtsls = {
    command = "${pkgs.vtsls}/bin/vtsls";
    args = [ "--stdio" ];
    config = {
      hostInfo = "helix";
      typescript = {
        updateImportsOnFileMove.enabled = "always";
        suggest.completeFunctionCalls = true;
      };
    };
  };

  vscode-css-language-server = {
    command = "vscode-css-language-server";
    args = [ "--stdio" ];
    config = {
      provideFormatter = false;
      css.validate.enable = true;
    };
  };

  eslint = {
    command = "vscode-eslint-language-server";
    args = [ "--stdio" ];
    config = {
      experimental = { };
      format = true;
      nodePath = "";
      onIgnoredFiles = "off";
      packageManager = "yarn";
      problems.shortenToSingleLine = false;
      quiet = false;
      rulesCustomizations = [ ];
      run = "onType";
      useESLintClass = false;
      validate = "on";
      workingDirectory.mode = "auto";
      codeAction = {
        disableRuleComment = {
          enable = true;
          location = "separateLine";
        };
        showDocumentation.enable = true;
      };
      codeActionsOnSave = {
        enable = true;
        mode = "all";
      };
    };
  };

  typos.command = "typos-lsp";

  deno = {
    command = "deno";
    args = [ "lsp" ];
    required-root-patterns = [
      "deno.json"
      "deno.jsonc"
    ];
    config.editor.formatOnSave = true;
  };
}

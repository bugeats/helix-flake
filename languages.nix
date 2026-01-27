{ ... }:
let
  indent = {
    tab-width = 2;
    unit = "  ";
  };
  textCommon = {
    soft-wrap = {
      enable = true;
      wrap-at-text-width = true;
    };
    text-width = 80;
  };
  jsCommon =
    extension: extraProps:
    {
      auto-format = true;
      comment-token = "//";
      language-servers = [ "vtsls" ];
      roots = [ ];
      scope = "source.${extension}";
      shebangs = [ ];
      inherit indent;
    }
    // extraProps;
in
[
  (
    {
      name = "text";
      file-types = [
        "txt"
        "text"
      ];
      roots = [ ];
      scope = "source.text";
      language-servers = [ "typos" ];
      inherit indent;
    }
    // textCommon
  )
  (
    {
      name = "markdown";
      scope = "source.md";
      injection-regex = "md|markdown";
      file-types = [
        "md"
        "markdown"
        "mkd"
        "mkdn"
        "mdwn"
        "mdown"
        "markdn"
        "mdtxt"
        "mdtext"
        "workbook"
      ];
      roots = [ ".marksman.toml" ];
      language-servers = [
        "marksman"
        "typos"
      ];
      indent = {
        tab-width = 2;
        unit = "  ";
      };
      block-comment-tokens = {
        start = "<!--";
        end = "-->";
      };
    }
    // textCommon
  )
  {
    name = "conf";
    scope = "source.conf";
    file-types = [ "conf" ];
    roots = [ ];
    comment-token = "#";
    inherit indent;
  }
  (jsCommon "js" {
    name = "javascript";
    file-types = [
      "js"
      "mjs"
      "cjs"
    ];
    injection-regex = "(js|javascript)";
    language-id = "javascript";
    shebangs = [ "node" ];
  })
  (jsCommon "jsx" {
    name = "jsx";
    file-types = [ "jsx" ];
    grammar = "javascript";
    injection-regex = "(jsx)";
    language-id = "javascriptreact";
  })
  (jsCommon "ts" {
    name = "typescript";
    file-types = [
      "ts"
      "mts"
      "cts"
    ];
    injection-regex = "(ts|typescript)";
    language-id = "typescript";
    roots = [
      "tsconfig.json"
      ".eslintrc"
    ];
  })
  (jsCommon "tsx" {
    name = "tsx";
    file-types = [ "tsx" ];
    injection-regex = "(tsx)";
    language-id = "typescriptreact";
    roots = [ "tsconfig.json" ];
  })
  {
    name = "css";
    scope = "source.css";
    injection-regex = "css";
    file-types = [
      "css"
      "scss"
    ];
    language-servers = [
      "vscode-css-language-server"
      "prettier-css"
    ];
    auto-format = true;
    comment-token = "/**/";
    inherit indent;
  }
]

{ ... }:
let
  indent = {
    tab-width = 2;
    unit = "  ";
  };

  text = (
    name: attrs:
    (
      {
        inherit name indent;
        soft-wrap.enable = true;
        soft-wrap.wrap-at-text-width = true;
        text-width = 80;
      }
      // attrs
    )
  );

  js = (
    name: extension: attrs:
    {
      inherit name indent;
      auto-format = true;
      comment-token = "//";
      language-servers = [ "vtsls" ];
      roots = [ ];
      scope = "source.${extension}";
      shebangs = [ ];
    }
    // attrs
  );
in
[
  (text "text" {
    file-types = [
      "txt"
      "text"
    ];
    roots = [ ];
    scope = "source.text";
    language-servers = [ "typos" ];
  })

  (text "markdown" {
    scope = "source.md";
    injection-regex = "md|markdown";
    file-types = [
      "markdn"
      "markdown"
      "md"
      "mdown"
      "mdtext"
      "mdtxt"
      "mdwn"
      "mkd"
      "mkdn"
      "workbook"
    ];
    roots = [ ".marksman.toml" ];
    language-servers = [
      "marksman"
      "typos"
    ];
    block-comment-tokens.start = "<!--";
    block-comment-tokens.end = "-->";
  })

  {
    name = "conf";
    scope = "source.conf";
    file-types = [ "conf" ];
    roots = [ ];
    comment-token = "#";
    inherit indent;
  }

  (js "javascript" "js" {
    file-types = [
      "js"
      "mjs"
      "cjs"
    ];
    injection-regex = "(js|javascript)";
    language-id = "javascript";
    shebangs = [ "node" ];
  })

  (js "jsx" "jsx" {
    file-types = [ "jsx" ];
    grammar = "javascript";
    injection-regex = "(jsx)";
    language-id = "javascriptreact";
  })

  (js "typescript" "ts" {
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

  (js "tsx" "tsx" {
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

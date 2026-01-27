{ ... }:
{
  editor = {
    bufferline = "always";
    default-yank-register = "+";
    color-modes = true;
    completion-trigger-len = 1;
    completion-timeout = 5;
    cursorline = true;
    cursor-shape.insert = "underline";
    cursor-shape.normal = "block";
    cursor-shape.select = "bar";
    file-picker.hidden = false;
    idle-timeout = 10;
    indent-guides.character = "⸽";
    indent-guides.render = true;
    indent-guides.skip-levels = 4;
    lsp.display-inlay-hints = false;
    lsp.display-messages = true;
    mouse = true;
    smart-tab.enable = true;
    soft-wrap.enable = false;
    soft-wrap.wrap-indicator = "";
    statusline.left = [
      "spacer"
      "version-control"
      "spacer"
      "separator"
      "file-name"
      "file-modification-indicator"
      "separator"
      "position"
      "separator"
      "total-line-numbers"
      "separator"
      "file-encoding"
    ];
    statusline.center = [
      "separator"
      "diagnostics"
      "spacer"
      "workspace-diagnostics"
      "separator"
      "spinner"
    ];
    statusline.right = [
      "separator"
      "file-type"
      "separator"
      "mode"
    ];
    whitespace.characters.newline = "¬";
    whitespace.characters.tab = "▸";
    whitespace.render = "all";
    end-of-line-diagnostics = "disable";
    inline-diagnostics = {
      cursor-line = "info";
      other-lines = "disable";
    };
  };

  keys = {
    normal = {
      "D" = "delete_selection_noyank";
    };
  };
}

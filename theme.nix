{ colors, ... }:

with colors;
let
  uiLevel1 = {
    fg = COLOR_UI_LEVEL_1_FG;
    bg = COLOR_UI_LEVEL_1_BG;
  };

  uiLevel2 = {
    fg = COLOR_UI_LEVEL_2_FG;
    bg = COLOR_UI_LEVEL_2_BG;
  };

  uiLevel3 = {
    fg = COLOR_UI_LEVEL_3_FG;
    bg = COLOR_UI_LEVEL_3_BG;
  };

  normal = {
    modifiers = [ ];
  };
  bold = {
    modifiers = [ "bold" ];
  };
  italic = {
    modifiers = [ "italic" ];
  };
  underlined = {
    modifiers = [ "underlined" ];
  };
  crossed_out = {
    modifiers = [ "crossed_out" ];
  };

  bgErr = {
    bg = BG_ERR;
  };
  bgHint = {
    bg = BG_HINT;
  };
  bgInfo = {
    bg = BG_INFO;
  };
  bgWarn = {
    bg = BG_WARN;
  };

  fgErr = {
    fg = FG_ERR;
  };
  fgHint = {
    fg = FG_HINT;
  };
  fgInfo = {
    fg = FG_INFO;
  };
  fgWarn = {
    fg = FG_WARN;
  };

in
with colors;
{

  "info" = fgInfo;
  "hint" = fgHint;
  "warning" = fgWarn;
  "error" = fgErr;

  "attribute" = COLOR_KEYWORD_FG;
  "comment" = {
    fg = COLOR_COMMENT_FG;
  };
  # "constant.builtin" = COLOR_KEYWORD_FG;
  "constant.builtin" = COLOR_NORMAL_FG;
  "constant.character.escape" = COLOR_NORMAL_FG_ALT;
  "constant" = COLOR_KEYWORD_FG;
  "constant.numeric" = COLOR_NORMAL_FG;
  "constructor" = {
    fg = COLOR_TYPE_FG;
  };
  "debug" = COLOR_ANSI_MAGENTA_DIM;

  "diagnostic" = bgErr;
  "diagnostic.hint" = bgHint;
  "diagnostic.info" = bgInfo;
  "diagnostic.warning" = bgWarn;
  "diagnostic.error" = bgErr;
  "diagnostic.unnecessary" = bgWarn // {
    modifiers = [ "dim" ];
  };
  "diagnostic.deprecated" = bgErr // {
    modifiers = [ "crossed_out" ];
  };

  "diff.delta" = {
    fg = COLOR_ANSI_YELLOW;
  };
  "diff.minus" = {
    fg = COLOR_ANSI_RED;
  };
  "diff.plus" = {
    fg = COLOR_ANSI_GREEN;
  };
  "function.builtin" = {
    fg = COLOR_NORMAL_FG;
  };
  "function" = {
    fg = COLOR_NORMAL_FG;
  };
  "function.macro" = {
    fg = COLOR_NORMAL_FG_ALT;
  };
  "keyword" = COLOR_KEYWORD_FG;
  "keyword.directive" = COLOR_KEYWORD_FG;
  "keyword.storage" = COLOR_KEYWORD_FG;
  "label" = COLOR_KEYWORD_FG_ALT;
  "markup.bold" = bold;
  "markup.heading.1" = uiLevel1;
  "markup.heading.2" = uiLevel2;
  "markup.heading.3" = uiLevel3;
  "markup.heading.4" = uiLevel3;
  "markup.heading.5" = uiLevel3;
  "markup.heading.6" = uiLevel3;
  "markup.heading" = bold;
  "markup.heading.completion" = uiLevel2; # for completion doc popup UI
  "markup.heading.hover" = uiLevel2; # for hover popup UI
  "markup.heading.marker" = {
    fg = COLOR_PUNCTUATION_FG;
  }
  // normal;
  "markup.italic" = italic;
  "markup.link.text" = COLOR_NORMAL_FG;
  "markup.link.url" = italic // underlined;
  "markup.list" = COLOR_NORMAL_FG;
  "markup.normal.completion" = uiLevel2; # for completion doc popup UI
  "markup.normal.hover" = uiLevel2; # for hover popup UI
  "markup.quote" = {
    fg = COLOR_STRING_FG;
  }
  // italic;
  "markup.raw.block" = {
    fg = COLOR_STRING_FG;
  };
  "markup.raw.inline.completion" = uiLevel2; # for completion doc popup UI
  "markup.raw.inline" = {
    fg = COLOR_STRING_FG;
  };
  "markup.raw.inline.hover" = uiLevel2; # for hover popup UI
  "markup.raw" = COLOR_NORMAL_FG_ALT;
  "markup.strikethrough" = crossed_out;
  "namespace" = COLOR_NORMAL_FG_ALT;
  "operator" = COLOR_PUNCTUATION_FG;
  "punctuation" = COLOR_PUNCTUATION_FG;
  "punctuation.delimiter" = COLOR_PUNCTUATION_FG;
  "special" = COLOR_KEYWORD_FG_ALT;
  "string" = COLOR_STRING_FG;
  "string.regexp" = COLOR_STRING_FG;
  "string.special" = COLOR_STRING_FG_ALT;
  "tag" = COLOR_KEYWORD_FG_ALT;
  "type.builtin" = COLOR_KEYWORD_FG;
  "type.enum.variant" = {
    fg = COLOR_TYPE_FG;
  }
  // bold;
  "type.enum" = {
    fg = COLOR_TYPE_FG;
  }
  // bold;
  "type" = {
    fg = COLOR_TYPE_FG;
  }
  // bold;
  "type.parameter" = bold;
  "ui.background" = {
    fg = COLOR_UI_LEVEL_2_FG;
    bg = COLOR_NORMAL_BG;
  }; # unfortunately, these are used for UI components and the plain unstyled code
  "ui.background.separator" = {
    fg = COLOR_UI_LEVEL_2_FG;
    bg = COLOR_UI_LEVEL_1_BG;
  }; # ???
  "ui.bufferline.active" = uiLevel1;
  "ui.bufferline" = uiLevel2;
  "ui.cursor" = {
    fg = COLOR_NORMAL_BG;
    bg = COLOR_CURSOR_BG;
  }
  // bold;
  "ui.cursor.insert" = {
    fg = COLOR_NORMAL_BG;
    bg = COLOR_ANSI_MAGENTA;
  }
  // bold;
  "ui.cursor.match" = {
    fg = COLOR_ANSI_BLUE;
  }
  // underlined;
  "ui.cursor.primary" = {
    fg = COLOR_NORMAL_BG;
    bg = COLOR_CURSOR_BG;
  }
  // bold;
  "ui.cursor.select" = {
    fg = COLOR_NORMAL_BG;
    bg = COLOR_ANSI_GREEN;
  }
  // bold;
  "ui.cursorline.primary" = {
    bg = COLOR_UI_LEVEL_1_BG;
  };
  "ui.cursorline.secondary" = {
    bg = COLOR_NORMAL_BG;
  };
  "ui.gutter" = {
    bg = COLOR_NORMAL_BG;
  };
  "ui.help" = COLOR_UI_LEVEL_1_FG;
  "ui.linenr" = COLOR_UI_LEVEL_1_FG;
  "ui.linenr.selected" = COLOR_UI_LEVEL_2_FG;
  "ui.menu.scroll" = {
    fg = COLOR_UI_LEVEL_3_FG;
    bg = COLOR_UI_LEVEL_1_BG;
  };
  "ui.menu.selected" = uiLevel3;
  "ui.menu" = uiLevel2;
  "ui.popup.info" = uiLevel2;
  "ui.popup" = uiLevel2;
  "ui.selection" = {
    bg = COLOR_SELECTION_BG_ALT;
  };
  "ui.selection.primary" = {
    bg = COLOR_SELECTION_BG;
  };
  "ui.statusline.inactive" = uiLevel1;
  "ui.statusline.insert" = {
    fg = COLOR_NORMAL_BG;
    bg = COLOR_ANSI_MAGENTA;
  };
  "ui.statusline.select" = uiLevel1;
  "ui.statusline.separator" = uiLevel1;
  "ui.statusline" = uiLevel2;
  "ui.text" = {
    fg = COLOR_NORMAL_FG;
  };
  "ui.text.focus" = {
    fg = COLOR_UI_LEVEL_3_FG;
  };
  "ui.text.inactive" = {
    fg = COLOR_UI_LEVEL_2_FG;
  };

  # "ui.virtual.indent-guide" = uiLevel2;
  "ui.virtual.inlay-hint" = italic;
  "ui.virtual.jump-label" = {
    bg = COLOR_SELECTION_BG_ALT;
    fg = COLOR_ANSI_CYAN_LIGHT;
  }
  // bold;
  # "ui.virtual.ruler" = uiLevel3;
  "ui.virtual.whitespace" = COLOR_VISIBLE_WHITESPACE_FG;

  "ui.window" = uiLevel2;
  "variable" = COLOR_NORMAL_FG;
  "variable.other.member" = COLOR_NORMAL_FG_ALT;
  "variable.parameter" = {
    fg = COLOR_NORMAL_FG_ALT;
  };
}

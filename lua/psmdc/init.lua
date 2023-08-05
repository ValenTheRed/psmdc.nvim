local M = {}
local utils = require("psmdc.utils")
local colors = require("psmdc.colors")

local function set_groups(c)
  local groups = {
    ColorColumn      = { bg=c.grp.surface },
    Cursor           = { reverse=true },
    CursorLine       = { bg=c.grp.cursor_line },
    CursorColumn     = { link="CursorLine" },
    CursorLineNr     = { bg=c.grp.cursor_line, underline=true },
    Directory        = { fg=c.clr.purple },
    DiffAdd          = { fg=c.clr.green2, bg=utils.blend(c.clr.green, c.grp.bg, 0.25) },
    DiffDelete       = { fg=c.clr.red, bg=utils.blend(c.clr.red, c.grp.bg, 0.1) },
    DiffChange       = { fg=c.clr.lightorange, bg=utils.blend(c.clr.lightorange, c.grp.bg, 0.2) },
    DiffText         = { fg=c.clr.lightorange, bg=utils.blend(c.clr.lightorange, c.grp.bg, 0.2) },
    ErrorMsg         = { fg=c.grp.bg, bg=c.clr.red, bold=true },
    Folded           = {
      fg=c.clr.lightorange, bg=utils.blend(c.clr.lightorange, c.grp.bg, 0.1), bold=true
    },
    LineNr           = { fg=c.grp.comments },
    FoldColumn       = { link="LineNr" },
    MatchParen       = { reverse=true },
    ModeMsg          = { fg=c.clr.purple, },
    MoreMsg          = { link="ModeMsg" },
    NonText          = { fg=c.grp.nontext },
    Whitespace       = { link="NonText" },
    Normal           = { fg=c.grp.fg, bg=c.grp.bg },
    Pmenu            = { fg=c.grp.surfacefg, bg=c.grp.surface },
    PmenuSel         = { fg=c.grp.bg, bg=c.clr.pink },
    PmenuSbar        = { bg=c.grp.surface },
    PmenuThumb       = { bg=c.grp.surfacefg },
    Question         = { fg=c.clr.purple },
    Search           = { fg=c.clr.white, bg=c.clr.gray },
    IncSearch        = { link="Search" },
    SignColumn       = { fg=c.grp.fg, bg=c.grp.bg },
    SpecialKey       = { fg=c.grp.comments },
    SpellCap         = { fg=c.clr.purple, undercurl=true },
    SpellBad         = { fg=c.clr.red, undercurl=true },
    StatusLine       = { fg=c.grp.surfacefg, bg=c.grp.surface },
    StatusLineNC     = { fg=c.grp.surfacefg_darker, bg=c.grp.surface_darker },
    TabLineFill      = { bg=c.grp.bg },
    TabLine      = { fg=c.grp.surfacefg, bg=c.grp.surface },
    TabLineSel       = { fg=c.grp.bg, bg=c.clr.lightpink },
    Title            = { fg=c.clr.green },
    VertSplit        = { fg=c.grp.nontext },
    Visual           = { fg=c.grp.fg, bg=c.grp.selection },
    WarningMsg       = { fg=c.clr.red },
    WildMenu         = { fg=c.grp.bg, bg=c.clr.cyan },

    -- Syntax
    Comment    = { fg=c.grp.comments },
    Conceal    = { fg=c.clr.brown, bg=c.grp.bg },
    Constant   = { fg=c.clr.orange },
    String     = { fg=c.clr.green },
    Character  = { link="String" },
    Identifier = { fg=c.clr.fg },
    Function   = { fg=c.clr.purple },

    Statement   = { fg=c.clr.blue },
    Conditional = { fg=c.clr.blue, italic=true },
    Repeat      = { fg=c.clr.blue, italic=true },
    Exception   = { fg=c.clr.blue, italic=true },
    Label       = { fg=c.clr.fg, italic=true },

    Operator     = { fg=c.clr.lightpink },
    PreProc      = { fg=c.clr.blue, italic=true },
    Include      = { fg=c.clr.blue, italic=true },
    PreCondit    = { link="Statement" },
    Define       = { fg=c.clr.pink },
    Macro        = { link="Define" },
    Type         = { fg=c.clr.yellow },
    StorageClass = { link="Statement" },
    Structure    = { link="Statement" },
    Typedef      = { link="Statement" },
    Special      = { fg=c.clr.violet },
    Underlined   = { underline=true },
    Error        = { fg=c.grp.bg, bg=c.clr.red },
    Todo         = { fg=c.clr.orange, italic=true, reverse=true },
    Delimiter    = { fg=c.clr.cyan },

    -- Treesitter
    TSComment         = { link="Comment" },

    TSConstant        = { link="Constant" },
    TSConstBuiltin    = { link="Constant" },

    TSString          = { link="String" },
    TSCharacter       = { link="Character" },

    TSVariable        = { link="Identifier" },
    TSVariableBuiltin = { fg=c.clr.lightpurple },

    TSFuncBuiltin     = { link="Function" },
    TSFuncMacro       = { link="Macro" },
    TSFunction        = { link="Function" },
    TSParameter       = { fg=c.grp.fg, bold=true },
    TSType            = { link="Type" },
    TSField           = { fg=c.grp.fg },
    TSProperty        = { fg=c.grp.fg },
    TSConstructor     = { link="Type" },
    TSMethod          = { link="Function" },
    TSAttribute       = { fg=c.clr.blue, italic=true },

    TSConditional     = { link="Conditional" },
    TSRepeat          = { link="Repeat" },
    TSOperator        = { link="Operator" },
    TSKeyword         = { link="Statement" },
    TSKeywordFunction = { link="Statement" },
    TSKeywordReturn   = { fg=c.clr.blue, italic=true },
    TSKeywordOperator = { fg=c.clr.blue, italic=true },
    TSException       = { link="Exception" },

    TSInclude   = { link="Include" },
    TSNamespace = { fg=c.grp.fg },

    TSPunctBracket   = { fg=c.clr.cyan },
    TSPunctDelimiter = { fg=c.clr.cyan },

    TSTodo = { link="Todo" },
    TSNote = { link="Todo" },
    TSWarning = { link="Todo" },
    TSDanger  = { link="Todo" },
    TSNone = { link="Normal" },

    TSTag             = { link="TSKeyword" },
    TSTagAttribute    = { link="TSParameter" },
    TSTagDelimiter    = { link="TSPunctBracket" },

    -- Diagnostics
    DiagnosticError = { fg=c.clr.red },
    DiagnosticWarn = { fg=c.clr.lightyellow },
    DiagnosticInfo = { fg=c.clr.gray },
    DiagnosticHint = { fg=c.clr.lightorange },

    DiagnosticVirtualTextError = {
      fg=c.clr.red, bg=utils.blend(c.clr.red, c.grp.bg, 0.1)
    },
    DiagnosticVirtualTextWarn = {
      fg=c.clr.lightyellow, bg=utils.blend(c.clr.lightyellow, c.grp.bg, 0.1)
    },
    DiagnosticVirtualTextInfo = {
      fg=c.clr.gray, bg=utils.blend(c.clr.gray, c.grp.bg, 0.2)
    },
    DiagnosticVirtualTextHint = {
      fg=c.clr.lightorange, bg=utils.blend(c.clr.lightorange, c.grp.bg, 0.1)
    },

    DiagnosticUnderLineError = { sp=c.clr.red, underline=true },
    DiagnosticUnderLineWarn = { sp=c.clr.lightyellow, underline=true },
    DiagnosticUnderLineInfo = { sp=c.clr.gray, underline=true },
    DiagnosticUnderLineHint = { sp=c.clr.lightorange, underline=true },

    LspReferenceText = { bg=c.grp.surface },
    LspReferenceRead = { bg=c.grp.surface },
    LspReferenceWrite = { bg=c.grp.surface },
    LspCodeLens       = { fg=c.grp.surfacefg },
    LspCodeLensSeparator = { fg=c.grp.nontext },
    LspSignatureActiveParameter = { italic=true },

    --- PLUGINS
    VCSAdd = { fg=c.clr.green },
    VCSChange = { fg=c.clr.yellow },
    VCSDelete = { fg=c.clr.red },

    -- Refer to telescope.vim for the groups. Dunno if they are complete.
    TelescopeMatching = { fg=c.clr.pink },
    TelescopePromptPrefix = { fg=c.clr.yellow },
    TelescopeSelectionCaret = {  fg=c.clr.yellow, bg=c.grp.selection },

    -- help syntax links it to an identifier for some godforsaken reason
    helpHyperTextJump = { link="Tag" },

    SpecialComment = { link="Todo" },
    Tag = { link="Underlined" },
    SpecialChar    = { link="Special" },

    gitcommitsummary = { link="Identifier" },
    gitcommitHeader = { link="Statement" },
    gitcommitSelectedFile = { link="VCSAdd" },
    gitcommitDiscardedFile = { link="VCSDelete" },
    gitcommitUnmergedFile = { link="VCSChange" },

    diffFile = { link="Statement" },
    diffSubname = { link="Function" },
    diffOldFile = { link="VCSDelete" },
    diffNewFile = { link="VCSAdd" },
    diffLine = { link="VCSChange" },
    diffAdded = { link="DiffAdd" },
    diffChanged = { link="DiffChange" },
    diffRemoved = { link="DiffDelete" },

    GitSignsAdd = { link="VCSAdd" },
    GitSignsChange = { link="VCSChange" },
    GitSignsDelete = { link="VCSDelete" },
  }

  for from, args in pairs(groups) do
    utils.highlight(from, args)
  end
end

function M.colorscheme(name)
  vim.api.nvim_command("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.api.nvim_command("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = "psmdc_" .. name
  set_groups(colors[name])
end

return M

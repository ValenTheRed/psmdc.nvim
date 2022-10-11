local M = {}
local utils = require("psmdc.utils")
local colors = require("psmdc.colors")

local function set_groups(c)
  local groups = {
    ColorColumn      = { bg=c.grp.surface },
    Cursor           = { attr="reverse" },
    CursorLine       = { bg=c.grp.cursor_line },
    CursorColumn     = { to="CursorLine" },
    CursorLineNr     = { bg=c.grp.cursor_line, attr="underline" },
    Directory        = { fg=c.clr.purple },
    DiffAdd          = { fg=c.clr.green2, bg=utils.blend(c.clr.green, c.grp.bg, 0.25) },
    DiffDelete       = { fg=c.clr.red, bg=utils.blend(c.clr.red, c.grp.bg, 0.1) },
    DiffChange       = { fg=c.clr.lightorange, bg=utils.blend(c.clr.lightorange, c.grp.bg, 0.2) },
    DiffText         = { fg=c.clr.lightorange, bg=utils.blend(c.clr.lightorange, c.grp.bg, 0.2) },
    ErrorMsg         = { fg=c.grp.bg, bg=c.clr.red, attr="bold" },
    Folded           = {
      fg=c.clr.lightorange, bg=utils.blend(c.clr.lightorange, c.grp.bg, 0.1), attr="bold"
    },
    LineNr           = { fg=c.grp.comments },
    FoldColumn       = { to="LineNr" },
    MatchParen       = { attr="reverse" },
    ModeMsg          = { fg=c.clr.purple, },
    MoreMsg          = { to="ModeMsg" },
    NonText          = { fg=c.grp.nontext },
    Whitespace       = { to="NonText" },
    Normal           = { fg=c.grp.fg, bg=c.grp.bg },
    Pmenu            = { fg=c.grp.surfacefg, bg=c.grp.surface },
    PmenuSel         = { fg=c.grp.bg, bg=c.clr.pink },
    PmenuSbar        = { bg=c.grp.surface },
    PmenuThumb       = { bg=c.grp.surfacefg },
    Question         = { fg=c.clr.purple },
    Search           = { fg=c.clr.white, bg=c.clr.gray },
    IncSearch        = { "Search" },
    SignColumn       = { fg=c.grp.fg, bg=c.grp.bg },
    SpecialKey       = { fg=c.grp.comments },
    SpellCap         = { fg=c.clr.purple, attr="undercurl" },
    SpellBad         = { fg=c.clr.red, attr="undercurl" },
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
    Character  = { to="String" },
    Identifier = { fg=c.clr.fg },
    Function   = { fg=c.clr.purple },

    Statement   = { fg=c.clr.blue },
    Conditional = { fg=c.clr.blue, attr="italic" },
    Repeat      = { fg=c.clr.blue, attr="italic" },
    Exception   = { fg=c.clr.blue, attr="italic" },
    Label       = { fg=c.clr.fg, attr="italic" },

    Operator     = { fg=c.clr.lightpink },
    PreProc      = { fg=c.clr.blue, attr   = "italic" },
    Include      = { fg=c.clr.blue, attr   = "italic" },
    PreCondit    = { to="Statement" },
    Define       = { fg=c.clr.pink },
    Macro        = { to="Define" },
    Type         = { fg=c.clr.yellow },
    StorageClass = { to="Statement" },
    Structure    = { to="Statement" },
    Typedef      = { to="Statement" },
    Special      = { fg=c.clr.violet },
    Underlined   = { attr="underline" },
    Error        = { fg=c.grp.bg, bg=c.clr.red },
    Todo         = { fg=c.clr.orange, attr="italic,reverse" },
    Delimiter    = { fg=c.clr.cyan },

    -- Treesitter
    TSComment         = { to="Comment" },

    TSConstant        = { to="Constant" },
    TSConstBuiltin    = { to="Constant" },

    TSString          = { to="String" },
    TSCharacter       = { to="Character" },

    TSVariable        = { to="Identifier" },
    TSVariableBuiltin = { fg=c.clr.lightpurple },

    TSFuncBuiltin     = { to="Function" },
    TSFuncMacro       = { to="Macro" },
    TSFunction        = { to="Function" },
    TSParameter       = { fg=c.grp.fg, attr="bold" },
    TSType            = { to="Type" },
    TSField           = { fg=c.grp.fg },
    TSProperty        = { fg=c.grp.fg },
    TSConstructor     = { to="Type" },
    TSMethod          = { to="Function" },
    TSAttribute       = { fg=c.clr.blue, attr="italic" },

    TSConditional     = { to="Conditional" },
    TSRepeat          = { to="Repeat" },
    TSOperator        = { to="Operator" },
    TSKeyword         = { to="Statement" },
    TSKeywordFunction = { to="Statement" },
    TSKeywordReturn   = { fg=c.clr.blue, attr="italic" },
    TSKeywordOperator = { fg=c.clr.blue, attr="italic" },
    TSException       = { to="Exception" },

    TSInclude   = { to="Include" },
    TSNamespace = { fg=c.grp.fg },

    TSPunctBracket   = { fg=c.clr.cyan },
    TSPunctDelimiter = { fg=c.clr.cyan },

    TSTodo = { to="Todo" },
    TSNote = { to="Todo" },
    TSWarning = { to="Todo" },
    TSDanger  = { to="Todo" },
    TSNone = { to="Normal" },

    TSTag             = { to="TSKeyword" },
    TSTagAttribute    = { to="TSParameter" },
    TSTagDelimiter    = { to="TSPunctBracket" },

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

    DiagnosticUnderLineError = { sp=c.clr.red, attr="underline" },
    DiagnosticUnderLineWarn = { sp=c.clr.lightyellow, attr="underline" },
    DiagnosticUnderLineInfo = { sp=c.clr.gray, attr="underline" },
    DiagnosticUnderLineHint = { sp=c.clr.lightorange, attr="underline" },

    LspReferenceText = { bg=c.grp.surface },
    LspReferenceRead = { bg=c.grp.surface },
    LspReferenceWrite = { bg=c.grp.surface },
    LspCodeLens       = { fg=c.grp.surfacefg },
    LspCodeLensSeparator = { fg=c.grp.nontext },
    LspSignatureActiveParameter = { attr="italic" },

    --- PLUGINS
    VCSAdd = { fg=c.clr.green },
    VCSChange = { fg=c.clr.yellow },
    VCSDelete = { fg=c.clr.red },

    -- Refer to telescope.vim for the groups. Dunno if they are complete.
    TelescopeMatching = { fg=c.clr.pink },
    TelescopePromptPrefix = { fg=c.clr.yellow },
    TelescopeSelectionCaret = {  fg=c.clr.yellow, bg=c.grp.selection },

    -- help syntax links it to an identifier for some godforsaken reason
    helpHyperTextJump = { to="Tag" },

    SpecialComment = { to="Todo" },
    Tag = { to="Underlined" },
    SpecialChar    = { to="Special" },

    gitcommitsummary = { to="Identifier" },
    gitcommitHeader = { to="Statement" },
    gitcommitSelectedFile = { to="VCSAdd" },
    gitcommitDiscardedFile = { to="VCSDelete" },
    gitcommitUnmergedFile = { to="VCSChange" },

    diffFile = { to="Statement" },
    diffSubname = { to="Function" },
    diffOldFile = { to="VCSDelete" },
    diffNewFile = { to="VCSAdd" },
    diffLine = { to="VCSChange" },
    diffAdded = { to="DiffAdd" },
    diffChanged = { to="DiffChange" },
    diffRemoved = { to="DiffDelete" },

    GitSignsAdd = { to="VCSAdd" },
    GitSignsChange = { to="VCSChange" },
    GitSignsDelete = { to="VCSDelete" },
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

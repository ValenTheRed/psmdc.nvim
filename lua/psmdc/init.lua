local M = {}
local utils = require("psmdc.utils")
local colors = require("psmdc.colors")

local function set_groups(c)
  local groups = {
    ColorColumn      = { bg=c.selection },
    Cursor           = { fg=c.bg, bg=c.caret },
    CursorColumn     = { bg=c.line_highlight },
    CursorLine       = { bg=c.line_highlight },
    CursorLineNr     = { fg=c.fg, bg=c.line_highlight },
    Directory        = { fg=c.purple },
    DiffAdd          = { fg=c.green2, bg=utils.blend(c.green, c.bg, 0.25) },
    DiffDelete       = { fg=c.red, bg=utils.blend(c.red, c.bg, 0.1) },
    DiffChange       = { fg=c.paleorange, bg=utils.blend(c.paleorange, c.bg, 0.2) },
    DiffText         = { fg=c.paleorange, bg=utils.blend(c.paleorange, c.bg, 0.2) },
    ErrorMsg         = { fg=c.bg, bg=c.red, attr="bold" },
    FoldColumn       = { fg=c.line_numbers, bg=c.bg },
    Folded           = {
      fg=c.brown, bg=utils.blend(c.brown, c.bg, 0.1), attr="bold"
    },
    LineNr           = { fg=c.line_numbers },
    MatchParen       = { fg=c.red, bg=c.bg, attr="bold" },
    ModeMsg          = { fg=c.purple, bg=c.inline_highlight },
    MoreMsg          = { fg=c.purple, bg=c.inline_highlight },
    NonText          = { fg=c.comments },
    Whitespace       = { fg=c.guides },
    Normal           = { fg=c.fg, bg=c.bg },
    Pmenu            = { fg=c.fg, bg=c.selection },
    PmenuSel         = { fg=c.bg, bg=c.pink },
    PmenuSbar        = { bg=c.selection },
    PmenuThumb       = { bg=c.comments },
    Question         = { fg=c.purple },
    IncSearch        = { fg=c.white, bg=c.comments },
    Search           = { fg=c.white, bg=c.comments },
    SignColumn       = { fg=c.fg, bg=c.bg },
    SpecialKey       = { fg=c.comments },
    SpellCap         = { fg=c.purple, attr="undercurl" },
    SpellBad         = { fg=c.red, attr="undercurl" },
    StatusLine       = { fg=c.gray, bg=c.selection },
    StatusLineNC     = { fg=c.comments, bg=c.selection2 },
    TabLine          = { fg=c.fg, bg=c.line_numbers },
    TabLineFill      = { fg=c.fg, bg=c.selection },
    TabLineSel       = { fg=c.bg, bg=c.palepink },
    Title            = { fg=c.green },
    VertSplit        = { fg=c.comments },
    Visual           = { fg=c.fg, bg=c.selection },
    WarningMsg       = { fg=c.red },
    WildMenu         = { fg=c.bg, bg=c.cyan },

    -- Syntax
    Comment    = { fg=c.comments },
    Conceal    = { fg=c.brown, bg=c.bg },
    Constant   = { fg=c.orange },
    String     = { fg=c.green },
    Character  = { fg=c.green },
    Identifier = { fg=c.fg },
    Function   = { fg=c.purple },
    Statement  = { fg=c.blue },
    Operator   = { fg=c.palepink },
    PreProc    = { fg=c.blue },
    Include    = { fg=c.blue },
    Define     = { fg=c.pink },
    Macro      = { fg=c.pink },
    Type       = { fg=c.yellow },
    Structure  = { fg=c.blue },
    Special    = { fg=c.violet },
    Underlined = { attr="underline" },
    Error      = { fg=c.bg, bg=c.red },
    Todo       = { fg=c.orange, bg=c.inline_highlight, attr="italic" },
    Delimiter = { fg=c.cyan },

    -- Treesitter
    TSFuncBuiltin     = { fg=c.purple },
    TSFuncMacro = { fg=c.pink },
    TSParameter       = { fg=c.fg, attr="bold" },
    TSMethod          = { fg=c.purple },
    TSField           = { fg=c.fg },
    TSProperty        = { fg=c.fg },
    TSConstructor     = { fg=c.yellow },
    TSAttribute       = { fg=c.blue, bg=c.inline_highlight, attr="italic" },
    TSNamespace = { fg=c.fg },

    TSConditional     = { fg=c.blue, attr="italic" },
    TSRepeat          = { fg=c.blue, attr="italic" },
    TSOperator        = { fg=c.palepink },
    TSKeyword         = { fg=c.blue },
    TSKeywordFunction = { fg=c.blue },
    TSKeywordReturn   = { fg=c.blue, attr="italic" },
    TSKeywordOperator = { fg=c.blue, attr="italic" },
    TSException       = { fg=c.blue, attr="italic" },

    TSInclude         = { fg=c.blue, attr="italic" },

    TSPunctBracket    = { fg=c.cyan },
    TSPunctDelimiter  = { fg=c.cyan },

    TSVariableBuiltin = { fg=c.palepurple },

    -- Diagnostics
    DiagnosticError = { fg=c.red },
    DiagnosticWarn = { fg=c.paleyellow },
    DiagnosticInfo = { fg=c.gray },
    DiagnosticHint = { fg=c.paleorange },

    DiagnosticVirtualTextError = {
      fg=c.red, bg=utils.blend(c.red, c.bg, 0.1)
    },
    DiagnosticVirtualTextWarn = {
      fg=c.paleyellow, bg=utils.blend(c.paleyellow, c.bg, 0.1)
    },
    DiagnosticVirtualTextInfo = {
      fg=c.gray, bg=utils.blend(c.gray, c.bg, 0.2)
    },
    DiagnosticVirtualTextHint = {
      fg=c.paleorange, bg=utils.blend(c.paleorange, c.bg, 0.1)
    },

    DiagnosticUnderLineError = { sp=c.red, attr="underline" },
    DiagnosticUnderLineWarn = { sp=c.paleyellow, attr="underline" },
    DiagnosticUnderLineInfo = { sp=c.gray, attr="underline" },
    DiagnosticUnderLineHint = { sp=c.paleorange, attr="underline" },

    LspReferenceText = { bg=c.selection },
    LspReferenceRead = { bg=c.selection },
    LspReferenceWrite = { bg=c.selection },
    LspCodeLens       = { fg=c.comments },
    LspCodeLensSeparator = { fg=c.guides },
    LspSignatureActiveParameter = { attr="italic" },

    --- PLUGINS
    VCSAdd = { fg=c.green },
    VCSChange = { fg=c.yellow },
    VCSDelete = { fg=c.red },

    -- Refer to telescope.vim for the groups. Dunno if they are complete.
    TelescopeMatching = { fg=c.pink },
    TelescopePromptPrefix = { fg=c.yellow },
  }

  for grp, args in pairs(groups) do
    utils.set_highlight(grp, args)
  end

  local links = {
    -- help syntax links it to an identifier for some godforsaken reason
    helpHyperTextJump = { to="Tag" },

    SpecialComment = { to="Todo" },
    Tag = { to="Underlined" },
    SpecialChar    = { to="Special" },

    TSConstant        = { to="Constant" },
    TSConstBuiltin    = { to="Constant" },
    TSCharacter       = { to="Character" },
    TSString          = { to="String" },

    TSFunction        = { to="Function" },

    TSType            = { to="Type" },

    TSComment         = { to="Comment" },

    TSTodo = { to="Todo" },
    TSNote = { to="Todo" },
    TSWarning = { to="Todo" },
    TSDanger  = { to="Todo" },
    TSNone = { to="Normal" },

    TSTag             = { to="TSKeyword" },
    TSTagAttribute    = { to="TSParameter" },
    TSTagDelimiter    = { to="TSPunctBracket" },

    TSVariable = { to="Identifier" },

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

    TelescopeSelectionCaret = { to="TelescopePromptPrefix" },
  }

  for from, args in pairs(links) do
    utils.set_link(from, args)
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

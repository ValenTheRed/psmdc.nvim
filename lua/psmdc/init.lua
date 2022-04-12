local M = {}
local utils = require("psmdc.utils")
local colors = require("psmdc.colors")

local function set_groups(c)
  local groups = {
    ColorColumn      = { bg=c.selection },
    Cursor           = { fg=c.bg, bg=c.caret },
    CursorColumn     = { bg=c.line_highlight },
    CursorLine       = { bg=c.line_highlight },
    CursorLineNr     = { fg=c.caret },
    Directory        = { fg=c.purple },
    DiffAdd          = { bg=utils.blend(c.fg, c.green, 0.15) },
    DiffDelete       = { bg=utils.blend(c.fg, c.red, 0.15) },
    DiffChange       = { bg=utils.blend(c.fg, c.yellow, 0.15) },
    DiffText         = { bg=utils.blend(c.fg, c.orange, 0.15) },
    ErrorMsg         = { fg=c.bg, bg=c.red, attr="bold" },
    FoldColumn       = { fg=c.line_numbers, bg=c.bg },
    Folded           = { fg=c.brown, bg=c.bg, attr="bold" },
    LineNr           = { fg=c.line_numbers },
    MatchParen       = { fg=c.red, bg=c.bg, attr="bold" },
    ModeMsg          = { fg=c.green },
    MoreMsg          = { fg=c.green },
    NonText          = { fg=c.comments },
    Normal           = { fg=c.fg, bg=c.bg },
    Pmenu            = { fg=c.fg, bg=c.selection },
    PmenuSel         = { fg=c.bg, bg=c.cyan },
    PmenuSbar        = { bg=c.selection },
    PmenuThumb       = { bg=c.comments },
    Question         = { fg=c.purple },
    IncSearch        = { fg=c.white, bg=c.comments },
    Search           = { fg=c.white, bg=c.comments },
    SignColumn       = { fg=c.fg, bg=c.bg },
    SpecialKey       = { fg=c.comments },
    SpellCap         = { fg=c.purple, attr="undercurl" },
    SpellBad         = { fg=c.red, attr="undercurl" },
    StatusLine       = { fg=c.fg, bg=c.selection },
    StatusLineNC     = { fg=c.comments, bg=c.selection },
    StatusLineTerm   = { fg=c.bg, bg=c.green },
    StatusLineTermNC = { fg=c.bg, bg=c.green },
    TabLine          = { fg=c.fg, bg=c.line_numbers },
    TabLineFill      = { fg=c.fg, bg=c.selection },
    TabLineSel       = { fg=c.bg, bg=c.cyan },
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
    DiagnosticVirtualTextError = { fg=c.red, bg=utils.blend(c.red, c.bg, 0.1) },
    DiagnosticVirtualTextWarn = { fg=c.paleyellow, bg=utils.blend(c.paleyellow, c.bg, 0.1) },
    DiagnosticVirtualTextInfo = { fg=c.gray, bg=utils.blend(c.gray, c.bg, 0.2) },
    DiagnosticVirtualTextHint = { fg=c.paleorange, bg=utils.blend(c.paleorange, c.bg, 0.1) },
    DiagnosticUnderLineError = { sp=c.red, attr="underline" },
    DiagnosticUnderLineWarn = { sp=c.paleyellow, attr="underline" },
    DiagnosticUnderLineInfo = { sp=c.gray, attr="underline" },
    DiagnosticUnderLineHint = { sp=c.paleorange, attr="underline" },
  }

  for grp, args in pairs(groups) do
    utils.set_highlight(grp, args)
  end

  local links = {
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

    TSVariable = { to="Identifier" }
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

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
    MatchParen       = { bold=true, italic=true, bg=utils.blend(c.clr.black_white, c.grp.bg, 0.4) }, -- reverse has the cursor turn invisible when on a bracket
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
    CurSearch        = { link="Search" },
    IncSearch        = { link="Search" },
    SignColumn       = { fg=c.grp.fg, bg=c.grp.bg },
    SpecialKey       = { fg=c.grp.comments },
    SpellCap         = { fg=c.clr.purple, undercurl=true },
    SpellBad         = { fg=c.clr.red, undercurl=true },
    StatusLine       = { fg=c.grp.surfacefg, bg=c.grp.surface },
    StatusLineNC     = { fg=c.grp.surfacefg_darker, bg=c.grp.surface_darker },
    TabLineFill      = { bg=c.grp.bg },
    TabLine          = { fg=c.grp.surfacefg, bg=c.grp.surface },
    TabLineSel       = { fg=c.grp.bg, bg=c.clr.lightpink },
    Title            = { fg=c.clr.green },
    VertSplit        = { fg=c.grp.nontext },
    Visual           = { fg=c.grp.fg, bg=c.grp.selection },
    WarningMsg       = { fg=c.clr.red },
    WildMenu         = { fg=c.grp.bg, bg=c.clr.cyan },

    -- Syntax :h group-name
    Comment    = { fg=c.grp.comments },
    Conceal    = { fg=c.clr.brown, bg=c.grp.bg },

    Constant   = { fg=c.clr.orange },
    Number   = { fg=c.clr.orange },
    Float   = { fg=c.clr.orange },
    Boolean   = { fg=c.clr.orange },
    String     = { fg=c.clr.green },
    Character  = { link="String" },

    Identifier = { fg=c.grp.fg },
    Function   = { fg=c.clr.purple },

    Statement   = { fg=c.clr.blue },
    Conditional = { fg=c.clr.blue, italic=true },
    Repeat      = { fg=c.clr.blue, italic=true },
    Label       = { fg=c.clr.fg, italic=true },
    Operator     = { fg=c.clr.lightpink },
    Keyword   = { fg=c.clr.blue },
    Exception   = { fg=c.clr.blue, italic=true },

    PreProc      = { fg=c.clr.blue, italic=true },
    Include      = { fg=c.clr.blue, italic=true },
    Define       = { fg=c.clr.pink },
    Macro        = { link="Define" },
    PreCondit    = { link="Statement" },

    Type         = { fg=c.clr.yellow },
    StorageClass = { link="Statement" },
    Structure    = { link="Statement" },
    Typedef      = { link="Statement" },

    Special      = { fg=c.clr.violet },
    SpecialChar      = { fg=c.clr.violet },
    Tag = { link="Underlined" },
    Delimiter    = { fg=c.clr.cyan },
    SpecialComment = { link="Todo" },
    Debug        = { link="Special" },

    Underlined   = { underline=true },
    Error        = { fg=c.grp.bg, bg=c.clr.red },
    Todo         = { fg=c.clr.orange, italic=true, reverse=true },

    -- Treesitter capture groups
    -- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
    --- Misc
    ["@comment"]               = { link="Comment" }, -- line and block comments
    ["@comment.documentation"] = { link="Comment" }, -- comments documenting code
    ["@error"]                 = { sp=c.clr.red, underdashed=true }, -- syntax/parser errors. will switch on even if you've not completed your code.
    ["@none"]                  = { }, -- completely disable the highlight
    ["@preproc"]               = { link="PreProc" },-- various preprocessor directives & shebangs
    ["@define"]                = { link="Define" }, -- preprocessor definition directives
    ["@operator"]              = { link="Operator" }, -- symbolic operators (e.g. `+` / `*`)

    --- Punctuation
    ["@punctuation.delimiter"] = { link="Delimiter" }, -- delimiters (e.g. `;` / `.` / `,`)
    ["@punctuation.bracket"]   = { link="Delimiter" }, -- brackets (e.g. `()` / `{}` / `[]`)
    ["@punctuation.special"]   = { link="Delimiter" }, -- special symbols (e.g. `{}` in string interpolation)

    --- Literals
    ["@string"]               = { link="String" }, -- string literals
    ["@string.documentation"] = { link="String" }, -- string documenting code (e.g. Python docstrings)
    ["@string.regex"]         = { link="String" }, -- regular expressions
    ["@string.escape"]        = { link="Special" }, -- escape sequences
    ["@string.special"]       = { link="String" }, -- other special strings (e.g. dates)

    ["@character"]            = { link="Character" }, -- character literals
    ["@character.special"]    = { link="Character" }, -- special characters (e.g. wildcards)

    ["@boolean"]              = { link="Boolean" },-- boolean literals
    ["@number"]               = { link="Number" }, -- numeric literals
    ["@float"]                = { link="Float" }, -- floating-point number literals

    --- Functions
    ["@function"]         = { link="Function" }, -- function definitions
    ["@function.builtin"] = { link="Function" }, -- built-in functions
    ["@function.call"]    = { link="Function" }, -- function calls
    ["@function.macro"]   = { link="Macro" }, -- preprocessor macros

    ["@method"]           = { link="Function" }, -- method definitions
    ["@method.call"]      = { link="Function" }, -- method calls

    ["@constructor"]      = { link="Type" }, -- constructor calls and definitions
    ["@parameter"]        = { fg=c.grp.fg, bold=true }, -- parameters of a function

    --- Keywords
    ["@keyword"]             = { link="Keyword" }, -- various keywords
    ["@keyword.coroutine"]   = { link="Keyword" }, -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
    ["@keyword.function"]    = { link="Keyword" }, -- keywords that define a function (e.g. `func` in Go, `def` in Python)
    ["@keyword.operator"]    = { fg=c.clr.lightpink, italic=true }, -- operators that are English words (e.g. `and` / `or`)
    ["@keyword.return"]      = { fg=c.clr.blue, italic=true }, -- keywords like `return` and `yield`

    ["@conditional"]         = { link="Conditional" }, -- keywords related to conditionals (e.g. `if` / `else`)
    ["@conditional.ternary"] = { link="Conditional" }, -- ternary operator (e.g. `?` / `:`)

    ["@repeat"]              = { link="Repeat" }, -- keywords related to loops (e.g. `for` / `while`)
    ["@debug"]               = { link="Debug" }, -- keywords related to debugging
    ["@label"]               = { link="Label" }, -- GOTO and other labels (e.g. `label:` in C)
    ["@include"]             = { link="Include" }, -- keywords for including modules (e.g. `import` / `from` in Python)
    ["@exception"]           = { link="Exception" }, -- keywords related to exceptions (e.g. `throw` / `catch`)

    --- Types
    ["@type"]            = { link="Type" }, -- type or class definitions and annotations
    ["@type.builtin"]    = { link="Type" }, -- built-in types
    ["@type.definition"] = { link="Type" }, -- type definitions (e.g. typedef struct{...} name; name gets highlighted)
    ["@type.qualifier"]  = { link="Keyword" }, -- type qualifiers (e.g. `const`)

    ["@storageclass"]    = { link="StorageClass" }, -- modifiers that affect storage in memory or life-time
    ["@attribute"]       =  { fg=c.clr.brown, bold=true }, -- attribute annotations (e.g. Python decorators, c++ [[deprecated("because")]])
    ["@field"]           = { fg=c.grp.fg }, -- object and struct fields
    ["@property"]        = { fg=c.grp.fg }, -- similar to `@field`

    --- Identifiers
    ["@variable"]         = { link="Variable" }, -- various variable names
    ["@variable.builtin"] = { fg=c.clr.lightpurple }, -- built-in variable names (e.g. `this`)

    ["@constant"]         = { link="Constant" }, -- constant identifiers
    ["@constant.builtin"] = { link="Constant" }, -- built-in constant values
    ["@constant.macro"]   = { link="Define" }, -- constants defined by the preprocessor

    ["@namespace"]        = { fg=c.grp.fg }, -- modules or namespaces
    ["@symbol"]           = { link="Identifier" }, -- symbols or atoms

    --- Text: manily for markup languages
    ["@text"]                  = { fg=c.grp.fg }, -- non-structured text
    ["@text.strong"]           = { bold=true }, -- bold text
    ["@text.emphasis"]         = { italic=true }, -- text with emphasis
    ["@text.underline"]        = { link="Underlined" }, -- underlined text
    ["@text.strike"]           = { strikethrough=true }, -- strikethrough text
    ["@text.title"]            = { link="Statement" }, -- text that is part of a title
    ["@text.quote"]            = { link="String" }, -- text quotations
    ["@text.uri"]              = { link="Underlined" }, -- URIs (e.g. hyperlinks)
    ["@text.math"]             = { link="Special" }, -- math environments (e.g. `$ ... $` in LaTeX)
    ["@text.environment"]      = { link="@text" }, -- text environments of markup languages
    ["@text.environment.name"] = { link="Type" }, -- text indicating the type of an environment
    ["@text.reference"]        = { sp=c.clr.brown, underline=true }, -- text references, footnotes, citations, etc.

    ["@text.literal"]          = { fg=c.clr.lightyellow }, -- literal or verbatim text (e.g., inline code)
    ["@text.literal.block"]    = { link="@text" }, -- literal or verbatim text as a stand-alone block (use priority 90 for blocks with injections)

    ["@text.todo"]             = { link="Todo" }, -- todo notes
    ["@text.note"]             = { fg=c.grp.fg, italic=true, reverse=true }, -- info notes
    ["@text.warning"]          = { fg=c.clr.yellow, italic=true, reverse=true }, -- warning notes
    ["@text.danger"]           = { fg=c.clr.red, italic=true, reverse=true }, -- danger/error notes

    ["@text.diff.add"]         = { link="diffRemoved" },-- added text (for diff files)
    ["@text.diff.delete"]      = { link="diffAdded" }, -- deleted text (for diff files)

    --- Tags: used for XML-like tags
    ["@tag"]           = { link="Keyword" }, -- XML tag names
    ["@tag.attribute"] = { link="@parameter" }, -- XML tag attributes
    ["@tag.delimiter"] = { link="@punctuation.delimiter" }, -- XML tag delimiters

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

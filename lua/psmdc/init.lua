local M = {}
local utils = require("psmdc.utils")
local colors = require("psmdc.colors")

local function set_groups(c)
	local groups = {
		ColorColumn = { bg = c.surface },
		Cursor = { reverse = true },
		CursorLine = { bg = c.cursor_line },
		CursorColumn = { link = "CursorLine" },
		CursorLineNr = { bg = c.cursor_line, underline = true },
		Directory = { fg = c.purple },
		DiffAdd = { fg = c.green2, bg = utils.blend(c.green, c.bg, 0.25) },
		DiffDelete = { fg = c.red, bg = utils.blend(c.red, c.bg, 0.1) },
		DiffChange = { fg = c.yellow, bg = utils.blend(c.yellow, c.bg, 0.2) },
		DiffText = { fg = c.yellow, bg = utils.blend(c.yellow, c.bg, 0.42) },
		ErrorMsg = { fg = c.bg, bg = c.red, bold = true },
		Folded = {
			fg = c.lightorange,
			bg = utils.blend(c.lightorange, c.bg, 0.1),
			bold = true,
		},
		LineNr = { fg = c.comments },
		FoldColumn = { link = "LineNr" },
		MatchParen = {
			bold = true,
			italic = true,
			bg = utils.blend(c.black_white, c.bg, 0.4),
		}, -- reverse has the cursor turn invisible when on a bracket
		ModeMsg = { fg = c.purple },
		MoreMsg = { link = "ModeMsg" },
		NonText = { fg = c.nontext },
		Whitespace = { link = "NonText" },
		Normal = { fg = c.fg, bg = c.bg },
		Pmenu = { fg = c.surfacefg, bg = c.surface },
		PmenuSel = { fg = c.bg, bg = c.pink },
		PmenuSbar = { bg = c.surface },
		PmenuThumb = { bg = c.surfacefg },
		Question = { fg = c.purple },
		Search = { fg = c.white, bg = c.gray },
		CurSearch = { link = "Search" },
		IncSearch = { link = "Search" },
		SignColumn = { fg = c.fg, bg = c.bg },
		SpecialKey = { fg = c.comments },
		SpellCap = { fg = c.purple, undercurl = true },
		SpellBad = { fg = c.red, undercurl = true },
		StatusLine = { fg = c.surfacefg, bg = c.surface },
		StatusLineNC = { fg = c.surfacefg_darker, bg = c.surface_darker },
		TabLineFill = { bg = c.bg },
		TabLine = { fg = c.surfacefg, bg = c.surface },
		TabLineSel = { fg = c.bg, bg = c.lightpink },
		Title = { fg = c.green },
		WinSeparator = { fg = c.border },
		Visual = { fg = c.fg, bg = c.selection },
		WarningMsg = { fg = c.red },
		WildMenu = { fg = c.bg, bg = c.cyan },

		-- Syntax :h group-name
		Comment = { fg = c.comments },
		Conceal = { fg = c.brown, bg = c.bg },

		Constant = { fg = c.orange },
		Number = { fg = c.orange },
		Float = { fg = c.orange },
		Boolean = { fg = c.orange },
		String = { fg = c.green },
		Character = { link = "String" },

		Identifier = { fg = c.fg },
		Function = { fg = c.purple },

		Statement = { fg = c.blue },
		Conditional = { fg = c.blue, italic = true },
		Repeat = { fg = c.blue, italic = true },
		Label = { fg = c.fg, italic = true },
		Operator = { fg = c.lightpink },
		Keyword = { fg = c.blue },
		Exception = { fg = c.blue, italic = true },

		PreProc = { fg = c.blue, italic = true },
		Include = { fg = c.blue, italic = true },
		Define = { fg = c.pink },
		Macro = { link = "Define" },
		PreCondit = { link = "Statement" },

		Type = { fg = c.yellow },
		StorageClass = { link = "Statement" },
		Structure = { link = "Statement" },
		Typedef = { link = "Statement" },

		Special = { fg = c.violet },
		SpecialChar = { fg = c.violet },
		Tag = { link = "Underlined" },
		Delimiter = { fg = c.cyan },
		SpecialComment = { link = "Todo" },
		Debug = { link = "Special" },

		Underlined = { underline = true },
		Error = { fg = c.bg, bg = c.red },
		Todo = { fg = c.orange, italic = true, reverse = true },

		-- Treesitter capture groups
		-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
		--- Misc
		["@comment"] = { link = "Comment" }, -- line and block comments
		["@comment.documentation"] = { link = "Comment" }, -- comments documenting code
		["@error"] = { sp = c.red, underdashed = true }, -- syntax/parser errors. will switch on even if you've not completed your code.
		["@none"] = {}, -- completely disable the highlight
		["@preproc"] = { link = "PreProc" }, -- various preprocessor directives & shebangs
		["@define"] = { link = "Define" }, -- preprocessor definition directives
		["@operator"] = { link = "Operator" }, -- symbolic operators (e.g. `+` / `*`)

		--- Punctuation
		["@punctuation.delimiter"] = { link = "Delimiter" }, -- delimiters (e.g. `;` / `.` / `,`)
		["@punctuation.bracket"] = { link = "Delimiter" }, -- brackets (e.g. `()` / `{}` / `[]`)
		["@punctuation.special"] = { link = "Delimiter" }, -- special symbols (e.g. `{}` in string interpolation)

		--- Literals
		["@string"] = { link = "String" }, -- string literals
		["@string.documentation"] = { link = "String" }, -- string documenting code (e.g. Python docstrings)
		["@string.regex"] = { link = "String" }, -- regular expressions
		["@string.escape"] = { link = "Special" }, -- escape sequences
		["@string.special"] = { link = "String" }, -- other special strings (e.g. dates)

		["@character"] = { link = "Character" }, -- character literals
		["@character.special"] = { link = "Character" }, -- special characters (e.g. wildcards)

		["@boolean"] = { link = "Boolean" }, -- boolean literals
		["@number"] = { link = "Number" }, -- numeric literals
		["@float"] = { link = "Float" }, -- floating-point number literals

		--- Functions
		["@function"] = { link = "Function" }, -- function definitions
		["@function.builtin"] = { link = "Function" }, -- built-in functions
		["@function.call"] = { link = "Function" }, -- function calls
		["@function.macro"] = { link = "Macro" }, -- preprocessor macros

		["@method"] = { link = "Function" }, -- method definitions
		["@method.call"] = { link = "Function" }, -- method calls

		["@constructor"] = { link = "Type" }, -- constructor calls and definitions
		["@parameter"] = { fg = c.fg, bold = true }, -- parameters of a function

		--- Keywords
		["@keyword"] = { link = "Keyword" }, -- various keywords
		["@keyword.coroutine"] = { link = "Keyword" }, -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
		["@keyword.function"] = { link = "Keyword" }, -- keywords that define a function (e.g. `func` in Go, `def` in Python)
		["@keyword.operator"] = { fg = c.lightpink, italic = true }, -- operators that are English words (e.g. `and` / `or`)
		["@keyword.return"] = { fg = c.blue, italic = true }, -- keywords like `return` and `yield`

		["@conditional"] = { link = "Conditional" }, -- keywords related to conditionals (e.g. `if` / `else`)
		["@conditional.ternary"] = { link = "Conditional" }, -- ternary operator (e.g. `?` / `:`)

		["@repeat"] = { link = "Repeat" }, -- keywords related to loops (e.g. `for` / `while`)
		["@debug"] = { link = "Debug" }, -- keywords related to debugging
		["@label"] = { link = "Label" }, -- GOTO and other labels (e.g. `label:` in C)
		["@include"] = { link = "Include" }, -- keywords for including modules (e.g. `import` / `from` in Python)
		["@exception"] = { link = "Exception" }, -- keywords related to exceptions (e.g. `throw` / `catch`)

		--- Types
		["@type"] = { link = "Type" }, -- type or class definitions and annotations
		["@type.builtin"] = { link = "Type" }, -- built-in types
		["@type.definition"] = { link = "Type" }, -- type definitions (e.g. typedef struct{...} name; name gets highlighted)
		["@type.qualifier"] = { link = "Keyword" }, -- type qualifiers (e.g. `const`)

		["@storageclass"] = { link = "StorageClass" }, -- modifiers that affect storage in memory or life-time
		["@attribute"] = { fg = c.brown, bold = true }, -- attribute annotations (e.g. Python decorators, c++ [[deprecated("because")]])
		["@field"] = { link = "Identifier" }, -- object and struct fields
		["@property"] = { link = "Identifier" }, -- similar to `@field`

		--- Identifiers
		["@variable"] = { link = "Identifier" }, -- various variable names
		["@variable.builtin"] = { fg = c.lightpurple }, -- built-in variable names (e.g. `this`)

		["@constant"] = { link = "Constant" }, -- constant identifiers
		["@constant.builtin"] = { link = "Constant" }, -- built-in constant values
		["@constant.macro"] = { link = "Define" }, -- constants defined by the preprocessor

		["@namespace"] = { link = "Identifier" }, -- modules or namespaces
		["@symbol"] = { link = "Identifier" }, -- symbols or atoms

		--- Text: manily for markup languages
		["@text"] = { fg = c.fg }, -- non-structured text
		["@text.strong"] = { bold = true }, -- bold text
		["@text.emphasis"] = { italic = true }, -- text with emphasis
		["@text.underline"] = { link = "Underlined" }, -- underlined text
		["@text.strike"] = { strikethrough = true }, -- strikethrough text
		["@text.title"] = { link = "Statement" }, -- text that is part of a title
		["@text.quote"] = { link = "String" }, -- text quotations
		["@text.uri"] = { link = "Underlined" }, -- URIs (e.g. hyperlinks)
		["@text.math"] = { link = "Special" }, -- math environments (e.g. `$ ... $` in LaTeX)
		["@text.environment"] = { link = "@text" }, -- text environments of markup languages
		["@text.environment.name"] = { link = "Type" }, -- text indicating the type of an environment
		["@text.reference"] = { sp = c.brown, underline = true }, -- text references, footnotes, citations, etc.

		["@text.literal"] = { fg = c.lightyellow }, -- literal or verbatim text (e.g., inline code)
		["@text.literal.block"] = { link = "@text" }, -- literal or verbatim text as a stand-alone block (use priority 90 for blocks with injections)

		["@text.todo"] = { link = "Todo" }, -- todo notes
		["@text.note"] = { fg = c.fg, italic = true, reverse = true }, -- info notes
		["@text.warning"] = { fg = c.yellow, italic = true, reverse = true }, -- warning notes
		["@text.danger"] = { fg = c.red, italic = true, reverse = true }, -- danger/error notes

		["@text.diff.add"] = { link = "diffRemoved" }, -- added text (for diff files)
		["@text.diff.delete"] = { link = "diffAdded" }, -- deleted text (for diff files)

		--- Tags: used for XML-like tags
		["@tag"] = { link = "Keyword" }, -- XML tag names
		["@tag.attribute"] = { link = "@parameter" }, -- XML tag attributes
		["@tag.delimiter"] = { link = "@punctuation.delimiter" }, -- XML tag delimiters

		-- LSP semantic tokens (type)
		-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_semanticTokens
		-- :h lsp-semantic-highlight
		["@lsp.type.class"] = { link = "Type" },
		["@lsp.type.decorator"] = { link = "@attribute" },
		["@lsp.type.enum"] = { link = "Type" },
		["@lsp.type.enumMember"] = { link = "Constant" },
		["@lsp.type.function"] = { link = "Function" },
		["@lsp.type.interface"] = { link = "Type" },
		["@lsp.type.macro"] = { link = "Macro" },
		["@lsp.type.method"] = { link = "Function" },
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.struct"] = { link = "Type" },
		["@lsp.type.type"] = { link = "Type" },
		["@lsp.type.typeParameter"] = { link = "Type" }, -- https://en.wikipedia.org/wiki/TypeParameter
		["@lsp.type.variable"] = { link = "Identifier" },

		["@lsp.type.comment"] = { link = "Comment" },
		["@lsp.type.event"] = {},
		["@lsp.type.modifier"] = {},
		["@lsp.type.keyword"] = { link = "Keyword" },
		["@lsp.type.number"] = { link = "Number" },
		["@lsp.type.operator"] = { link = "Operator" },
		["@lsp.type.regexp"] = { link = "String" },
		["@lsp.type.string"] = { link = "String" },

		-- Diagnostics
		DiagnosticError = { fg = c.red },
		DiagnosticWarn = { fg = c.lightyellow },
		DiagnosticInfo = { fg = c.gray },
		DiagnosticHint = { fg = c.lightorange },

		DiagnosticVirtualTextError = {
			fg = c.red,
			bg = utils.blend(c.red, c.bg, 0.1),
		},
		DiagnosticVirtualTextWarn = {
			fg = c.lightyellow,
			bg = utils.blend(c.lightyellow, c.bg, 0.1),
		},
		DiagnosticVirtualTextInfo = {
			fg = c.gray,
			bg = utils.blend(c.gray, c.bg, 0.2),
		},
		DiagnosticVirtualTextHint = {
			fg = c.lightorange,
			bg = utils.blend(c.lightorange, c.bg, 0.1),
		},

		DiagnosticUnderLineError = { sp = c.red, underline = true },
		DiagnosticUnderLineWarn = { sp = c.lightyellow, underline = true },
		DiagnosticUnderLineInfo = { sp = c.gray, underline = true },
		DiagnosticUnderLineHint = { sp = c.lightorange, underline = true },

		LspReferenceText = { bg = c.surface },
		LspReferenceRead = { bg = c.surface },
		LspReferenceWrite = { bg = c.surface },
		LspCodeLens = { fg = c.surfacefg },
		LspCodeLensSeparator = { fg = c.nontext },
		LspSignatureActiveParameter = { italic = true },

		--- PLUGINS
		VCSAdd = { fg = c.green },
		VCSChange = { fg = c.yellow },
		VCSDelete = { fg = c.red },

		-- Refer to telescope.vim for the groups. Dunno if they are complete.
		TelescopeMatching = { fg = c.pink },
		TelescopePromptPrefix = { fg = c.yellow },
		TelescopeSelectionCaret = { fg = c.yellow, bg = c.selection },

		-- help syntax links it to an identifier for some godforsaken reason
		helpHyperTextJump = { link = "Tag" },

		gitcommitsummary = { link = "Identifier" },
		gitcommitHeader = { link = "Statement" },
		gitcommitSelectedFile = { link = "VCSAdd" },
		gitcommitDiscardedFile = { link = "VCSDelete" },
		gitcommitUnmergedFile = { link = "VCSChange" },

		diffFile = { link = "Statement" },
		diffSubname = { link = "Function" },
		diffOldFile = { link = "VCSDelete" },
		diffNewFile = { link = "VCSAdd" },
		diffLine = { link = "VCSChange" },
		diffAdded = { link = "DiffAdd" },
		diffChanged = { link = "DiffChange" },
		diffRemoved = { link = "DiffDelete" },

		GitSignsAdd = { link = "VCSAdd" },
		GitSignsChange = { link = "VCSChange" },
		GitSignsDelete = { link = "VCSDelete" },
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

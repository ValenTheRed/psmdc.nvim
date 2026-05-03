local M = {}
local utils = require("psmdc.utils")
local colors = require("psmdc.colors")
local config = {
	transparent_bg = false
}

--- @param c psmdc.palette
local function set_groups(c)
	--- @type { [string]: vim.api.keyset.highlight }
	local treesitter = {
		--- Identifiers
		-- various variable names
		["@variable"] = { fg = "fg" },
		-- built-in variable names (e.g. `this`)
		["@variable.builtin"] = { fg = "fg" },
		-- parameters of a function
		["@variable.parameter"] = { fg = "fg", bold = true },
		-- special parameters (e.g. `_`, `it`)
		["@variable.parameter.builtin"] = { link = "@variable.parameter" },
		-- object and struct fields
		["@variable.member"] = { link = "@variable" },

		-- constant identifiers
		["@constant"] = { fg = c.constant },
		-- built-in constant values
		["@constant.builtin"] = { link = "@constant" },
		-- constants defined by the preprocessor
		["@constant.macro"] = { link = "@constant" },

		-- modules or namespaces
		["@module"] = { link = "@variable" },
		-- built-in modules or namespaces
		["@module.builtin"] = { link = "@variable" },
		-- GOTO and other labels (e.g. `label:` in C), including heredoc labels
		["@label"] = { fg = "fg", italic = true },

		--- Literals
		-- string literals
		["@string"] = { fg = c.str },
		-- string documenting code (e.g. Python docstrings)
		["@string.documentation"] = { link = "@string" },
		-- regular expressions
		["@string.regexp"] = { link = "@string" },
		-- escape sequences
		["@string.escape"] = { fg = c.str_esc },
		-- other special strings (e.g. dates)
		["@string.special"] = { link = "@string" },
		-- symbols or atoms
		["@string.special.symbol"] = { link = "@variable" },
		-- URIs (e.g. hyperlinks)
		["@string.special.url"] = { link = "@variable" },
		-- filenames
		["@string.special.path"] = { sp = c.attr, underline = true },

		-- character literals
		["@character"] = { link = "@string" },
		-- special characters (e.g. wildcards)
		["@character.special"] = { link = "@character" },

		-- boolean literals
		["@boolean"] = { link = "@constant" },
		-- numeric literals
		["@number"] = { link = "@constant" },
		-- floating-point number literals
		["@number.float"] = { link = "@constant" },

		--- Types
		-- type or class definitions and annotations
		["@type"] = { fg = c.type },
		-- built-in types
		["@type.builtin"] = { link = "@type" },
		-- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
		["@type.definition"] = { link = "@type" },

		-- attribute annotations (e.g. Python decorators, Rust lifetimes)
		["@attribute"] = { fg = c.attr, bold = true },
		-- builtin annotations (e.g. `@property` in Python)
		["@attribute.builtin"] = { link = "@attribute" },
		-- the key in key/value pairs
		["@property"] = { link = "@variable" },

		--- Functions
		-- function definitions
		["@function"] = { fg = c.func },
		-- built-in functions
		["@function.builtin"] = { link = "@function" },
		-- function calls
		["@function.call"] = { link = "@function" },
		-- preprocessor macros
		["@function.macro"] = { link = "@function" },

		-- method definitions
		["@function.method"] = { link = "@function" },
		-- method calls
		["@function.method.call"] = { link = "@function" },

		-- constructor calls and definitions
		["@constructor"] = { link = "@type" },
		-- symbolic operators (e.g. `+` / `*`)
		["@operator"] = { fg = c.operator },

		--- Keywords
		-- keywords not fitting into specific categories
		["@keyword"] = { fg = c.keyword },
		-- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
		["@keyword.coroutine"] = { link = "@keyword" },
		-- keywords that define a function (e.g. `func` in Go, `def` in Python)
		["@keyword.function"] = { link = "@keyword" },
		-- operators that are English words (e.g. `and` / `or`)
		["@keyword.operator"] = { fg = c.operator, italic = true },
		-- keywords for including or exporting modules (e.g. `import` / `from` in Python)
		["@keyword.import"] = { fg = c.keyword, italic = true },
		-- keywords describing namespaces and composite types (e.g. `struct`, `enum`)
		["@keyword.type"] = { link = "@keyword" },
		-- keywords modifying other constructs (e.g. `const`, `static`, `public`)
		["@keyword.modifier"] = { link = "@keyword" },
		-- keywords related to loops (e.g. `for` / `while`)
		["@keyword.repeat"] = { fg = c.keyword, italic = true },
		-- keywords like `return` and `yield`
		["@keyword.return"] = { link = "@keyword.repeat" },
		-- keywords related to debugging
		["@keyword.debug"] = { link = "Debug" },
		-- keywords related to exceptions (e.g. `throw` / `catch`)
		["@keyword.exception"] = { link = "@keyword.repeat" },

		-- keywords related to conditionals (e.g. `if` / `else`)
		["@keyword.conditional"] = { link = "@keyword.repeat" },
		-- ternary operator (e.g. `?` / `:`)
		["@keyword.conditional.ternary"] = { link = "@keyword.conditional" },

		-- various preprocessor directives & shebangs
		["@keyword.directive"] = { fg = c.keyword, italic = true },
		-- preprocessor definition directives
		["@keyword.directive.define"] = { link = "@constant.macro" },

		--- Punctuation
		-- delimiters (e.g. `;` / `.` / `,`)
		["@punctuation.delimiter"] = { fg = c.delimiter },
		-- brackets (e.g. `()` / `{}` / `[]`)
		["@punctuation.bracket"] = { link = "@punctuation.delimiter" },
		-- special symbols (e.g. `{}` in string interpolation)
		["@punctuation.special"] = { link = "@punctuation.delimiter" },

		--- Comments
		-- line and block comments
		["@comment"] = { fg = c.comments },
		-- comments documenting code
		["@comment.documentation"] = { link = "@comment" },

		-- error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
		["@comment.error"] = { fg = c.error, italic = true, reverse = true },
		-- warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
		["@comment.warning"] = { fg = c.type, italic = true, reverse = true },
		-- todo-type comments (e.g. `TODO`, `WIP`)
		["@comment.todo"] = { fg = c.constant, italic = true, reverse = true },
		-- note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
		["@comment.note"] = { fg = "fg", italic = true, reverse = true },

		--- Markup
		-- bold text
		["@markup.strong"] = { bold = true },
		-- italic text
		["@markup.italic"] = { italic = true },
		-- struck-through text
		["@markup.strikethrough"] = { strikethrough = true },
		-- underlined text (only for literal underline markup!)
		["@markup.underline"] = { underline = true },

		-- headings, titles (including markers)
		["@markup.heading"] = { link = "@string" },
		-- top-level heading
		["@markup.heading.1"] = { link = "@string" },
		-- section heading
		["@markup.heading.2"] = { link = "@string" },
		-- subsection heading
		["@markup.heading.3"] = { link = "@string" },
		-- and so on
		["@markup.heading.4"] = { link = "@string" },
		-- and so forth
		["@markup.heading.5"] = { link = "@string" },
		-- six levels ought to be enough for anybody
		["@markup.heading.6"] = { link = "@string" },

		-- block quotes
		["@markup.quote"] = { link = "@string" },
		-- math environments (e.g. `$ ... $` in LaTeX)
		["@markup.math"] = { link = "@string" },

		-- text references, footnotes, citations, etc.
		["@markup.link"] = { sp = c.attr, underline = true },
		-- link, reference descriptions
		["@markup.link.label"] = { link = "@markup.link" },
		-- URL-style links
		["@markup.link.url"] = { link = "@markup.link" },

		-- literal or verbatim text (e.g. inline code)
		["@markup.raw"] = { fg = c.raw_text },
		-- literal or verbatim text as a stand-alone block; (use priority 90 for blocks with injections)
		["@markup.raw.block"] = { link = "@variable" },

		-- list markers
		["@markup.list"] = { link = "@punctuation.delimiter" },
		-- checked todo-style list markers
		["@markup.list.checked"] = { link = "DiffAdd" },
		-- unchecked todo-style list markers
		["@markup.list.unchecked"] = { link = "@comment.todo" },

		-- added text (for diff files)
		["@diff.plus"] = { link = "DiffAdd" },
		-- deleted text (for diff files)
		["@diff.minus"] = { link = "DiffDelete" },
		-- changed text (for diff files)
		["@diff.delta"] = { link = "DiffChange" },

		-- XML-style tag names (and similar)
		["@tag"] = { link = "@keyword" },
		-- builtin tag names (e.g. HTML5 tags)
		["@tag.builtin"] = { link = "@keyword" },
		-- XML-style tag attributes
		["@tag.attribute"] = { link = "@parameter" },
		-- XML-style tag delimiters
		["@tag.delimiter"] = { link = "@punctuation.delimiter" },

		--- Non-highlighting captures
		-- completely disable the highlight
		["@none"] = {},
		-- captures that are only meant to be concealed
		["@conceal"] = {},

		-- for defining regions to be spellchecked
		["@spell"] = {},
		-- for defining regions that should NOT be spellchecked
		["@nospell"] = {},
	}

	--- `:h group-name`
	--- @type { [string]: vim.api.keyset.highlight }
	local group_name = {
		-- any comment
		Comment = { link = "@comment" },

		-- any constant
		Constant = { link = "@constant" },
		-- a string constant: "this is a string"
		String = { link = "@string" },
		-- a character constant: 'c', '\n'
		Character = { link = "@character" },
		-- a number constant: 234, 0xff
		Number = { link = "@number" },
		-- a boolean constant: TRUE, false
		Boolean = { link = "@boolean" },
		-- a floating point constant: 2.3e10
		Float = { link = "@float" },

		-- any variable name
		Identifier = { link = "@variable" },
		-- function name (also: methods for classes)
		Function = { link = "@function" },

		-- any statement
		Statement = { link = "@keyword" },
		-- if, then, else, endif, switch, etc.
		Conditional = { link = "@keyword.conditional" },
		-- for, do, while, etc.
		Repeat = { link = "@keyword.repeat" },
		-- case, default, etc.
		Label = { link = "@label" },
		-- "sizeof", "+", "*", etc.
		Operator = { link = "@operator" },
		-- any other keyword
		Keyword = { link = "@keyword" },
		-- try, catch, throw
		Exception = { link = "@keyword.exception" },

		-- generic Preprocessor
		PreProc = { link = "@keyword.directive" },
		-- preprocessor #include
		Include = { link = "@keyword.import" },
		-- preprocessor #define
		Define = { link = "@function.macro" },
		-- same as Define
		Macro = { link = "@function.macro" },
		-- preprocessor #if, #else, #endif, etc.
		PreCondit = { link = "@keyword" },

		-- int, long, char, etc.
		Type = { link = "@type" },
		-- static, register, volatile, etc.
		StorageClass = { link = "@keyword" },
		-- struct, union, enum, etc.
		Structure = { link = "@keyword" },
		-- a typedef
		Typedef = { link = "@keyword" },

		-- any special symbol
		Special = { link = "@string.escape" },
		-- special character in a constant
		SpecialChar = { link = "@string.escape" },
		-- you can use CTRL-] on this
		Tag = { link = "@markup.underline" },
		-- character that needs attention
		Delimiter = { link = "@punctuation.delimiter" },
		-- special things inside a comment
		SpecialComment = { link = "@comment.todo" },
		-- debugging statements
		Debug = { link = "@string.escape" },

		-- text that stands out, HTML links
		Underlined = { link = "@markup.underline" },

		-- left blank, hidden  |hl-Ignore|
		Ignore = {},

		-- any erroneous construct
		Error = {},

		-- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
		Todo = { link = "@comment.todo" },

		-- added line in a diff
		Added = {},
		-- changed line in a diff
		Changed = {},
		-- removed line in a diff
		Removed = {},
	}

	--- `:h hl-<grp name>`
	--- @type { [string]: vim.api.keyset.highlight }
	local hl_groups = {
		-- Used for the columns set with 'colorcolumn'.
		ColorColumn = { bg = c.surface },
		-- Placeholder characters substituted for concealed text (see 'conceallevel').
		Conceal = { fg = c.attr, bg = c.bg },
		-- Current match for the last search pattern (see 'hlsearch'). Note: This is correct after a search, but may get outdated if changes are made or the screen is redrawn.
		CurSearch = { link = "Search" },
		-- Character under the cursor.
		Cursor = { reverse = true },
		-- Character under the cursor when |language-mapping| is used (see 'guicursor').
		lCursor = {},
		-- Like Cursor, but used when in IME mode. *CursorIM*
		CursorIM = {},
		-- Screen-column at the cursor, when 'cursorcolumn' is set.
		CursorColumn = { link = "CursorLine" },
		-- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
		CursorLine = { bg = c.cursor_line },
		-- Directory names (and other special names in listings).
		Directory = { fg = c.func },
		-- Diff mode: Added line. |diff.txt|
		DiffAdd = { fg = c.diff_add, bg = utils.blend(c.str, c.bg, 0.25) },
		-- Diff mode: Changed line. |diff.txt|
		DiffChange = { bg = utils.blend(c.type, c.bg, 0.15) },
		-- Diff mode: Deleted line. |diff.txt|
		DiffDelete = { fg = c.error, bg = utils.blend(c.error, c.bg, 0.1) },
		-- Diff mode: Changed text within a changed line. |diff.txt|
		DiffText = { fg = c.type, bg = utils.blend(c.type, c.bg, 0.42) },
		-- Diff mode: Added text within a changed line.  Linked to |hl-DiffText| by default. |diff.txt|
		DiffTextAdd = {},
		-- Filler lines (~) after the last line in the buffer. By default, this is highlighted like |hl-NonText|.
		EndOfBuffer = {},
		-- Cursor in a focused terminal.
		TermCursor = {},
		-- Success messages.
		OkMsg = {},
		-- Warning messages.
		WarningMsg = { fg = c.error },
		-- Error messages.
		ErrorMsg = { fg = c.bg, bg = c.error, bold = true },
		-- Messages in stderr from shell commands.
		StderrMsg = {},
		-- Messages in stdout from shell commands.
		StdoutMsg = {},
		-- Separators between window splits.
		WinSeparator = {},
		-- Line used for closed folds.
		Folded = {
			bg = utils.blend(c.delimiter, c.bg, 0.2),
			bold = true,
		},
		-- 'foldcolumn'
		FoldColumn = { link = "LineNr" },
		-- Column where |signs| are displayed.
		SignColumn = { link = "Normal" },
		-- 'incsearch' highlighting; also used for the text replaced with ":s///c".
		IncSearch = { link = "Search" },
		-- |:substitute| replacement text highlighting.
		Substitute = {},
		-- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		LineNr = { fg = c.comments },
		-- Line number for when the 'relativenumber' option is set, above the cursor line.
		LineNrAbove = {},
		-- Line number for when the 'relativenumber' option is set, below the cursor line.
		LineNrBelow = {},
		-- Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
		CursorLineNr = { bg = c.cursor_line, underline = true },
		-- Like FoldColumn when 'cursorline' is set for the cursor line.
		CursorLineFold = {},
		-- Like SignColumn when 'cursorline' is set for the cursor line.
		CursorLineSign = {},
		-- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		MatchParen = {
			bold = true,
			italic = true,
			underdouble = true,
		},
		-- 'showmode' message (e.g., "-- INSERT --").
		ModeMsg = { fg = c.func },
		-- Area for messages and command-line, see also 'cmdheight'.
		MsgArea = {},
		-- Separator for scrolled messages |msgsep|.
		MsgSeparator = {},
		-- |more-prompt|
		MoreMsg = { link = "ModeMsg" },
		-- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		NonText = { fg = c.non_text },
		-- Normal text.
		Normal = { fg = c.fg, bg = config.transparent_bg and "NONE" or c.bg },
		-- Normal text in floating windows.
		NormalFloat = { link = "Pmenu" },
		-- Border of floating windows.
		FloatBorder = {},
		-- Blended areas when border is "shadow".
		FloatShadow = {},
		-- Shadow corners when border is "shadow".
		FloatShadowThrough = {},
		-- Title of floating windows.
		FloatTitle = { fg = c.str, bg = c.surface },
		-- Footer of floating windows.
		FloatFooter = {},
		-- Normal text in non-current windows.
		NormalNC = {},
		-- Popup menu: Normal item.
		Pmenu = { fg = c.surfacefg, bg = c.surface },
		-- Popup menu: Selected item. Combined with |hl-Pmenu|.
		PmenuSel = { fg = c.bg, bg = c.menu_sel },
		-- Popup menu: Normal item "kind".
		PmenuKind = {},
		-- Popup menu: Selected item "kind".
		PmenuKindSel = {},
		-- Popup menu: Normal item "extra text".
		PmenuExtra = {},
		-- Popup menu: Selected item "extra text".
		PmenuExtraSel = {},
		-- Popup menu: Scrollbar.
		PmenuSbar = { bg = c.surface },
		-- Popup menu: Thumb of the scrollbar.
		PmenuThumb = { bg = c.surfacefg },
		-- Popup menu: Matched text in normal item.  Combined with |hl-Pmenu|.
		PmenuMatch = {},
		-- Popup menu: Matched text in selected item.  Combined with |hl-PmenuMatch| and |hl-PmenuSel|.
		PmenuMatchSel = {},
		-- Popup menu: border of popup menu.
		PmenuBorder = {},
		-- Popup menu: blended areas when 'pumborder' is "shadow".
		PmenuShadow = {},
		-- Popup menu: shadow corners when 'pumborder' is "shadow".
		PmenuShadowThrough = {},
		-- Matched text of the currently inserted completion.
		ComplMatchIns = {},
		-- Text inserted when "preinsert" is in 'completeopt'.
		PreInsert = {},
		-- Virtual text of the currently selected completion.
		ComplHint = {},
		-- The additional information of the virtual text.
		ComplHintMore = {},
		-- |hit-enter| prompt and yes/no questions.
		Question = { fg = c.func },
		-- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		QuickFixLine = {},
		-- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
		Search = { fg = c.white, bg = c.search },
		-- Tabstops in snippets. |vim.snippet|
		SnippetTabstop = {},
		-- The currently active tabstop. |vim.snippet|
		SnippetTabstopActive = {},
		-- Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
		SpecialKey = { fg = c.comments },
		-- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		SpellBad = { fg = c.error, undercurl = true },
		-- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		SpellCap = { fg = c.func, undercurl = true },
		-- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		SpellLocal = {},
		-- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
		SpellRare = {},
		-- Status line of current window.
		StatusLine = { fg = c.surfacefg, bg = c.surface },
		-- Status lines of not-current windows.
		StatusLineNC = { fg = c.surfacefg_darker, bg = c.surface_darker },
		-- Status line of |terminal| window.
		StatusLineTerm = {},
		-- Status line of non-current |terminal| windows.
		StatusLineTermNC = {},
		-- Tab pages line, not active tab page label.
		TabLine = { fg = c.surfacefg, bg = c.surface },
		-- Tab pages line, where there are no labels.
		TabLineFill = { bg = c.bg },
		-- Tab pages line, active tab page label.
		TabLineSel = { fg = c.bg, bg = c.operator },
		-- Titles for output from ":set all", ":autocmd" etc.
		Title = { fg = c.str },
		-- Visual mode selection.
		Visual = { fg = c.selectionfg, bg = c.selection },
		-- Visual mode selection when vim is "Not Owning the Selection".
		VisualNOS = {},
		-- "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
		Whitespace = { link = "NonText" },
		-- Current match in 'wildmenu' completion.
		WildMenu = { fg = c.bg, bg = c.delimiter },
		-- Window bar of current window.
		WinBar = {},
		-- Window bar of not-current windows.
		WinBarNC = {},
	}

	--- LSP semantic tokens (type)
	--- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_semanticTokens
	--- :h lsp-semantic-highlight
	--- @type { [string]: vim.api.keyset.highlight }
	local lsp = {
		-- Identifiers that declare or reference a class type
		["@lsp.type.class"] = { link = "@type" },
		-- Tokens that represent a comment
		["@lsp.type.comment"] = { link = "@comment" },
		-- Identifiers that declare or reference decorators and annotations
		["@lsp.type.decorator"] = { link = "@tag.attribute" },
		-- Identifiers that declare or reference an enumeration type
		["@lsp.type.enum"] = { link = "@type" },
		-- Identifiers that declare or reference an enumeration property, constant, or member
		["@lsp.type.enumMember"] = { link = "@constant" },
		-- Identifiers that declare an event property
		["@lsp.type.event"] = {},
		-- Identifiers that declare a function
		["@lsp.type.function"] = { link = "@function" },
		-- Identifiers that declare or reference an interface type
		["@lsp.type.interface"] = { link = "@type" },
		-- Tokens that represent a language keyword
		["@lsp.type.keyword"] = { link = "@keyword" },
		-- Identifiers that declare a macro
		["@lsp.type.macro"] = { link = "@function.macro" },
		-- Identifiers that declare a member function or method
		["@lsp.type.method"] = { link = "@function" },
		-- Tokens that represent a modifier
		["@lsp.type.modifier"] = {},
		-- Identifiers that declare or reference a namespace, module, or package
		["@lsp.type.namespace"] = { link = "@module" },
		-- Tokens that represent a number literal
		["@lsp.type.number"] = { link = "@number" },
		-- Tokens that represent an operator
		["@lsp.type.operator"] = { link = "@operator" },
		-- Identifiers that declare or reference a function or method parameters
		["@lsp.type.parameter"] = { link = "@variable.parameter" },
		-- Identifiers that declare or reference a member property, member field, or member variable
		["@lsp.type.property"] = { link = "@property" },
		-- Tokens that represent a regular expression literal
		["@lsp.type.regexp"] = { link = "@string" },
		-- Tokens that represent a string literal
		["@lsp.type.string"] = { link = "@string" },
		-- Identifiers that declare or reference a struct type
		["@lsp.type.struct"] = { link = "@type" },
		-- Identifiers that declare or reference a type that is not covered above
		["@lsp.type.type"] = { link = "@type" },
		-- Identifiers that declare or reference a type parameter
		["@lsp.type.typeParameter"] = { link = "@type" },
		-- Identifiers that declare or reference a local or global variable
		["@lsp.type.variable"] = { link = "@variable" },

		-- Types and member functions that are abstract
		["@lsp.mod.abstract"] = {},
		-- Functions that are marked async
		["@lsp.mod.async"] = {},
		-- Declarations of symbols
		["@lsp.mod.declaration"] = {},
		-- Symbols that are part of the standard library
		["@lsp.mod.defaultLibrary"] = {},
		-- Definitions of symbols, for example, in header files
		["@lsp.mod.definition"] = {},
		-- Symbols that should no longer be used
		["@lsp.mod.deprecated"] = {},
		-- Occurrences of symbols in documentation
		["@lsp.mod.documentation"] = {},
		-- Variable references where the variable is assigned to
		["@lsp.mod.modification"] = {},
		-- Readonly variables and member fields (constants)
		["@lsp.mod.readonly"] = {},
		-- Class members (static members)
		["@lsp.mod.static"] = {},

		LspInlayHint = {
			fg = c.comments,
			bg = utils.blend(c.non_text, c.bg, 0.4),
		},
		LspReferenceText = { bg = c.surface },
		LspReferenceRead = { bg = c.surface },
		LspReferenceWrite = { bg = c.surface },
		LspCodeLens = { fg = c.surfacefg },
		LspCodeLensSeparator = { fg = c.non_text },
		LspSignatureActiveParameter = { italic = true },
	}

	--- @type { [string]: vim.api.keyset.highlight }
	local diagnostics = {
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticError = { fg = c.error },
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticWarn = { fg = c.raw_text },
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticInfo = { fg = c.search },
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticHint = { fg = c.diagnostic_hint },
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticOk = {},
		-- Used for "Error" diagnostic virtual text.
		DiagnosticVirtualTextError = {
			fg = c.error,
			bg = utils.blend(c.error, c.bg, 0.1),
		},
		-- Used for "Warn" diagnostic virtual text.
		DiagnosticVirtualTextWarn = {
			fg = c.raw_text,
			bg = utils.blend(c.raw_text, c.bg, 0.1),
		},
		-- Used for "Info" diagnostic virtual text.
		DiagnosticVirtualTextInfo = {
			fg = c.search,
			bg = utils.blend(c.search, c.bg, 0.2),
		},
		-- Used for "Hint" diagnostic virtual text.
		DiagnosticVirtualTextHint = {
			fg = c.diagnostic_hint,
			bg = utils.blend(c.diagnostic_hint, c.bg, 0.1),
		},
		-- Used for "Ok" diagnostic virtual text.
		DiagnosticVirtualTextOk = {},
		-- Used for "Error" diagnostic virtual lines.
		DiagnosticVirtualLinesError = {},
		-- Used for "Warn" diagnostic virtual lines.
		DiagnosticVirtualLinesWarn = {},
		-- Used for "Info" diagnostic virtual lines.
		DiagnosticVirtualLinesInfo = {},
		-- Used for "Hint" diagnostic virtual lines.
		DiagnosticVirtualLinesHint = {},
		-- Used for "Ok" diagnostic virtual lines.
		DiagnosticVirtualLinesOk = {},
		-- Used to underline "Error" diagnostics.
		DiagnosticUnderlineError = {},
		-- Used to underline "Warn" diagnostics.
		DiagnosticUnderlineWarn = {},
		-- Used to underline "Info" diagnostics.
		DiagnosticUnderlineInfo = {},
		-- Used to underline "Hint" diagnostics.
		DiagnosticUnderlineHint = {},
		-- Used to underline "Ok" diagnostics.
		DiagnosticUnderlineOk = {},
		-- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
		DiagnosticFloatingError = {},
		-- Used to color "Warn" diagnostic messages in diagnostics float.
		DiagnosticFloatingWarn = {},
		-- Used to color "Info" diagnostic messages in diagnostics float.
		DiagnosticFloatingInfo = {},
		-- Used to color "Hint" diagnostic messages in diagnostics float.
		DiagnosticFloatingHint = {},
		-- Used to color "Ok" diagnostic messages in diagnostics float.
		DiagnosticFloatingOk = {},
		-- Used for "Error" signs in sign column.
		DiagnosticSignError = {},
		-- Used for "Warn" signs in sign column.
		DiagnosticSignWarn = {},
		-- Used for "Info" signs in sign column.
		DiagnosticSignInfo = {},
		-- Used for "Hint" signs in sign column.
		DiagnosticSignHint = {},
		-- Used for "Ok" signs in sign column.
		DiagnosticSignOk = {},
		-- Used for deprecated or obsolete code. Applied by the "underline" handler; disabled when `vim.diagnostic.config({ underline = false })`.
		DiagnosticDeprecated = {},
		-- Used for unnecessary or unused code. Applied by the "underline" handler; disabled when `vim.diagnostic.config({ underline = false })`.
		DiagnosticUnnecessary = {},
	}

	--- @type { [string]: vim.api.keyset.highlight }
	local plugins = {
		gitcommitsummary = { link = "@variable" },
		gitcommitHeader = { link = "Statement" },
		gitcommitSelectedFile = { link = "VCSAdd" },
		gitcommitDiscardedFile = { link = "VCSDelete" },
		gitcommitUnmergedFile = { link = "VCSChange" },
		GitSignsAdd = { fg = c.str },
		GitSignsChange = { fg = c.type },
		GitSignsDelete = { fg = c.error },
		TelescopeMatching = { fg = c.menu_sel },
		TelescopePromptPrefix = { fg = c.type },
		TelescopeSelectionCaret = { fg = c.type, bg = c.selection },
	}

	--- @type { [string]: vim.api.keyset.highlight }
	local groups = vim.tbl_extend(
		"keep",
		treesitter,
		group_name,
		hl_groups,
		lsp,
		diagnostics,
		plugins
	)
	for from, args in pairs(groups) do
		if vim.tbl_isempty(args) then
			goto continue
		end
		utils.highlight(from, args)
		::continue::
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

function M.setup(opts)
	if opts == nil then
		return
	end
	config.transparent_bg = not not opts.transparent_bg

	if not not opts.dev then
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = vim.api.nvim_create_augroup(
				"reload_psmdc_dark",
				{ clear = true }
			),
			pattern = "*",
			callback = function()
				vim.schedule(function()
					vim.cmd("Lazy reload psmdc.nvim")
					vim.cmd("hi clear")
					vim.cmd("colorscheme psmdc_dark")
				end)
			end,
		})
	end
end

return M

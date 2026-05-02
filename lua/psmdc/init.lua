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
		["@variable"] = { link = "Identifier" },
		-- built-in variable names (e.g. `this`)
		["@variable.builtin"] = { fg = c.lightpurple },
		-- parameters of a function
		["@variable.parameter"] = { fg = c.fg, bold = true },
		-- special parameters (e.g. `_`, `it`)
		["@variable.parameter.builtin"] = { link = "@variable.parameter" },
		-- object and struct fields
		["@variable.member"] = { link = "Identifier" },

		-- constant identifiers
		["@constant"] = { link = "Constant" },
		-- built-in constant values
		["@constant.builtin"] = { link = "Constant" },
		-- constants defined by the preprocessor
		["@constant.macro"] = { link = "Define" },

		-- modules or namespaces
		["@module"] = { link = "Identifier" },
		-- built-in modules or namespaces
		["@module.builtin"] = { link = "Identifier" },
		-- GOTO and other labels (e.g. `label:` in C), including heredoc labels
		["@label"] = { link = "Label" },

		--- Literals
		-- string literals
		["@string"] = { link = "String" },
		-- string documenting code (e.g. Python docstrings)
		["@string.documentation"] = { link = "String" },
		-- regular expressions
		["@string.regexp"] = { link = "String" },
		-- escape sequences
		["@string.escape"] = { link = "Special" },
		-- other special strings (e.g. dates)
		["@string.special"] = { link = "String" },
		-- symbols or atoms
		["@string.special.symbol"] = { link = "Identifier" },
		-- URIs (e.g. hyperlinks)
		["@string.special.url"] = { link = "Identifier" },
		-- filenames
		["@string.special.path"] = { sp = c.brown, underline = true },

		-- character literals
		["@character"] = { link = "Character" },
		-- special characters (e.g. wildcards)
		["@character.special"] = { link = "Character" },

		-- boolean literals
		["@boolean"] = { link = "Boolean" },
		-- numeric literals
		["@number"] = { link = "Number" },
		-- floating-point number literals
		["@number.float"] = { link = "Float" },

		--- Types
		-- type or class definitions and annotations
		["@type"] = { link = "Type" },
		-- built-in types
		["@type.builtin"] = { link = "Type" },
		-- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
		["@type.definition"] = { link = "Type" },

		-- attribute annotations (e.g. Python decorators, Rust lifetimes)
		["@attribute"] = { fg = c.brown, bold = true },
		-- builtin annotations (e.g. `@property` in Python)
		["@attribute.builtin"] = { link = "@attribute" },
		-- the key in key/value pairs
		["@property"] = { link = "Identifier" },

		--- Functions
		-- function definitions
		["@function"] = { link = "Function" },
		-- built-in functions
		["@function.builtin"] = { link = "Function" },
		-- function calls
		["@function.call"] = { link = "Function" },
		-- preprocessor macros
		["@function.macro"] = { link = "Macro" },

		-- method definitions
		["@function.method"] = { link = "Function" },
		-- method calls
		["@function.method.call"] = { link = "Function" },

		-- constructor calls and definitions
		["@constructor"] = { link = "Type" },
		-- symbolic operators (e.g. `+` / `*`)
		["@operator"] = { link = "Operator" },

		--- Keywords
		-- keywords not fitting into specific categories
		["@keyword"] = { link = "Keyword" },
		-- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
		["@keyword.coroutine"] = { link = "Keyword" },
		-- keywords that define a function (e.g. `func` in Go, `def` in Python)
		["@keyword.function"] = { link = "Keyword" },
		-- operators that are English words (e.g. `and` / `or`)
		["@keyword.operator"] = { fg = c.lightpink, italic = true },
		-- keywords for including or exporting modules (e.g. `import` / `from` in Python)
		["@keyword.import"] = { link = "Include" },
		-- keywords describing namespaces and composite types (e.g. `struct`, `enum`)
		["@keyword.type"] = { link = "Keyword" },
		-- keywords modifying other constructs (e.g. `const`, `static`, `public`)
		["@keyword.modifier"] = { link = "Keyword" },
		-- keywords related to loops (e.g. `for` / `while`)
		["@keyword.repeat"] = { link = "Repeat" },
		-- keywords like `return` and `yield`
		["@keyword.return"] = { fg = c.blue, italic = true },
		-- keywords related to debugging
		["@keyword.debug"] = { link = "Debug" },
		-- keywords related to exceptions (e.g. `throw` / `catch`)
		["@keyword.exception"] = { link = "Exception" },

		-- keywords related to conditionals (e.g. `if` / `else`)
		["@keyword.conditional"] = { link = "Conditional" },
		-- ternary operator (e.g. `?` / `:`)
		["@keyword.conditional.ternary"] = { link = "Conditional" },

		-- various preprocessor directives & shebangs
		["@keyword.directive"] = { link = "PreProc" },
		-- preprocessor definition directives
		["@keyword.directive.define"] = { link = "Define" },

		--- Punctuation
		-- delimiters (e.g. `;` / `.` / `,`)
		["@punctuation.delimiter"] = { link = "Delimiter" },
		-- brackets (e.g. `()` / `{}` / `[]`)
		["@punctuation.bracket"] = { link = "Delimiter" },
		-- special symbols (e.g. `{}` in string interpolation)
		["@punctuation.special"] = { link = "Delimiter" },

		--- Comments
		-- line and block comments
		["@comment"] = { link = "Comment" },
		-- comments documenting code
		["@comment.documentation"] = { fg = c.comment_doc },

		-- error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
		["@comment.error"] = { fg = c.red, italic = true, reverse = true },
		-- warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
		["@comment.warning"] = { fg = c.yellow, italic = true, reverse = true },
		-- todo-type comments (e.g. `TODO`, `WIP`)
		["@comment.todo"] = { link = "Todo" },
		-- note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
		["@comment.note"] = { fg = c.fg, italic = true, reverse = true },

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
		["@markup.heading"] = { link = "String" },
		-- top-level heading
		["@markup.heading.1"] = { link = "String" },
		-- section heading
		["@markup.heading.2"] = { link = "String" },
		-- subsection heading
		["@markup.heading.3"] = { link = "String" },
		-- and so on
		["@markup.heading.4"] = { link = "String" },
		-- and so forth
		["@markup.heading.5"] = { link = "String" },
		-- six levels ought to be enough for anybody
		["@markup.heading.6"] = { link = "String" },

		-- block quotes
		["@markup.quote"] = { link = "String" },
		-- math environments (e.g. `$ ... $` in LaTeX)
		["@markup.math"] = { link = "String" },

		-- text references, footnotes, citations, etc.
		["@markup.link"] = { sp = c.brown, underline = true },
		-- link, reference descriptions
		["@markup.link.label"] = { link = "@markup.link" },
		-- URL-style links
		["@markup.link.url"] = { link = "@markup.link" },

		-- literal or verbatim text (e.g. inline code)
		["@markup.raw"] = { fg = c.lightyellow },
		-- literal or verbatim text as a stand-alone block; (use priority 90 for blocks with injections)
		["@markup.raw.block"] = { link = "Identifier" },

		-- list markers
		["@markup.list"] = { link = "Delimiter" },
		-- checked todo-style list markers
		["@markup.list.checked"] = { link = "DiffAdd" },
		-- unchecked todo-style list markers
		["@markup.list.unchecked"] = { link = "Todo" },

		-- added text (for diff files)
		["@diff.plus"] = { link = "DiffAdd" },
		-- deleted text (for diff files)
		["@diff.minus"] = { link = "DiffDelete" },
		-- changed text (for diff files)
		["@diff.delta"] = { link = "DiffChange" },

		-- XML-style tag names (and similar)
		["@tag"] = { link = "Keyword" },
		-- builtin tag names (e.g. HTML5 tags)
		["@tag.builtin"] = { link = "Keyword" },
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
		Comment = { fg = c.comments },

		-- any constant
		Constant = { fg = c.orange },
		-- a string constant: "this is a string"
		String = { fg = c.green },
		-- a character constant: 'c', '\n'
		Character = { link = "String" },
		-- a number constant: 234, 0xff
		Number = { fg = c.orange },
		-- a boolean constant: TRUE, false
		Boolean = { fg = c.orange },
		-- a floating point constant: 2.3e10
		Float = { fg = c.orange },

		-- any variable name
		Identifier = { fg = c.fg },
		-- function name (also: methods for classes)
		Function = { fg = c.purple },

		-- any statement
		Statement = { fg = c.blue },
		-- if, then, else, endif, switch, etc.
		Conditional = { fg = c.blue, italic = true },
		-- for, do, while, etc.
		Repeat = { fg = c.blue, italic = true },
		-- case, default, etc.
		Label = { fg = c.fg, italic = true },
		-- "sizeof", "+", "*", etc.
		Operator = { fg = c.lightpink },
		-- any other keyword
		Keyword = { fg = c.blue },
		-- try, catch, throw
		Exception = { fg = c.blue, italic = true },

		-- generic Preprocessor
		PreProc = { fg = c.blue, italic = true },
		-- preprocessor #include
		Include = { fg = c.blue, italic = true },
		-- preprocessor #define
		Define = { fg = c.pink },
		-- same as Define
		Macro = { link = "Define" },
		-- preprocessor #if, #else, #endif, etc.
		PreCondit = { link = "Statement" },

		-- int, long, char, etc.
		Type = { fg = c.yellow },
		-- static, register, volatile, etc.
		StorageClass = { link = "Statement" },
		-- struct, union, enum, etc.
		Structure = { link = "Statement" },
		-- a typedef
		Typedef = { link = "Statement" },

		-- any special symbol
		Special = { fg = c.violet },
		-- special character in a constant
		SpecialChar = { fg = c.violet },
		-- you can use CTRL-] on this
		Tag = { link = "Underlined" },
		-- character that needs attention
		Delimiter = { fg = c.cyan },
		-- special things inside a comment
		SpecialComment = { link = "Todo" },
		-- debugging statements
		Debug = { link = "Special" },

		-- text that stands out, HTML links
		Underlined = { underline = true },

		-- left blank, hidden  |hl-Ignore|
		Ignore = {},

		-- any erroneous construct
		Error = {},

		-- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
		Todo = { fg = c.orange, italic = true, reverse = true },

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
		Conceal = { fg = c.brown, bg = c.bg },
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
		Directory = { fg = c.purple },
		-- Diff mode: Added line. |diff.txt|
		DiffAdd = { fg = c.green2, bg = utils.blend(c.green, c.bg, 0.25) },
		-- Diff mode: Changed line. |diff.txt|
		DiffChange = { bg = utils.blend(c.yellow, c.bg, 0.15) },
		-- Diff mode: Deleted line. |diff.txt|
		DiffDelete = { fg = c.red, bg = utils.blend(c.red, c.bg, 0.1) },
		-- Diff mode: Changed text within a changed line. |diff.txt|
		DiffText = { fg = c.yellow, bg = utils.blend(c.yellow, c.bg, 0.42) },
		-- Diff mode: Added text within a changed line.  Linked to |hl-DiffText| by default. |diff.txt|
		DiffTextAdd = {},
		-- Filler lines (~) after the last line in the buffer. By default, this is highlighted like |hl-NonText|.
		EndOfBuffer = {},
		-- Cursor in a focused terminal.
		TermCursor = {},
		-- Success messages.
		OkMsg = {},
		-- Warning messages.
		WarningMsg = { fg = c.red },
		-- Error messages.
		ErrorMsg = { fg = c.bg, bg = c.red, bold = true },
		-- Messages in stderr from shell commands.
		StderrMsg = {},
		-- Messages in stdout from shell commands.
		StdoutMsg = {},
		-- Separators between window splits.
		WinSeparator = { fg = c.border },
		-- Line used for closed folds.
		Folded = {
			bg = utils.blend(c.cyan, c.bg, 0.2),
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
			bg = utils.blend(c.black_white, c.bg, 0.4),
		},
		-- 'showmode' message (e.g., "-- INSERT --").
		ModeMsg = { fg = c.purple },
		-- Area for messages and command-line, see also 'cmdheight'.
		MsgArea = {},
		-- Separator for scrolled messages |msgsep|.
		MsgSeparator = {},
		-- |more-prompt|
		MoreMsg = { link = "ModeMsg" },
		-- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		NonText = { fg = c.nontext },
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
		FloatTitle = { fg = c.green, bg = c.surface },
		-- Footer of floating windows.
		FloatFooter = {},
		-- Normal text in non-current windows.
		NormalNC = {},
		-- Popup menu: Normal item.
		Pmenu = { fg = c.surfacefg, bg = c.surface },
		-- Popup menu: Selected item. Combined with |hl-Pmenu|.
		PmenuSel = { fg = c.bg, bg = c.pink },
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
		Question = { fg = c.purple },
		-- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		QuickFixLine = {},
		-- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
		Search = { fg = c.white, bg = c.gray },
		-- Tabstops in snippets. |vim.snippet|
		SnippetTabstop = {},
		-- The currently active tabstop. |vim.snippet|
		SnippetTabstopActive = {},
		-- Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
		SpecialKey = { fg = c.comments },
		-- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		SpellBad = { fg = c.red, undercurl = true },
		-- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		SpellCap = { fg = c.purple, undercurl = true },
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
		TabLineSel = { fg = c.bg, bg = c.lightpink },
		-- Titles for output from ":set all", ":autocmd" etc.
		Title = { fg = c.green },
		-- Visual mode selection.
		Visual = { fg = c.selectionfg, bg = c.selection },
		-- Visual mode selection when vim is "Not Owning the Selection".
		VisualNOS = {},
		-- "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
		Whitespace = { link = "NonText" },
		-- Current match in 'wildmenu' completion.
		WildMenu = { fg = c.bg, bg = c.cyan },
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
		["@lsp.type.class"] = { link = "Type" },
		-- Tokens that represent a comment
		["@lsp.type.comment"] = { link = "Comment" },
		-- Identifiers that declare or reference decorators and annotations
		["@lsp.type.decorator"] = { link = "@tag.attribute" },
		-- Identifiers that declare or reference an enumeration type
		["@lsp.type.enum"] = { link = "Type" },
		-- Identifiers that declare or reference an enumeration property, constant, or member
		["@lsp.type.enumMember"] = { link = "Constant" },
		-- Identifiers that declare an event property
		["@lsp.type.event"] = {},
		-- Identifiers that declare a function
		["@lsp.type.function"] = { link = "Function" },
		-- Identifiers that declare or reference an interface type
		["@lsp.type.interface"] = { link = "Type" },
		-- Tokens that represent a language keyword
		["@lsp.type.keyword"] = { link = "Keyword" },
		-- Identifiers that declare a macro
		["@lsp.type.macro"] = { link = "Macro" },
		-- Identifiers that declare a member function or method
		["@lsp.type.method"] = { link = "Function" },
		-- Tokens that represent a modifier
		["@lsp.type.modifier"] = {},
		-- Identifiers that declare or reference a namespace, module, or package
		["@lsp.type.namespace"] = { link = "@module" },
		-- Tokens that represent a number literal
		["@lsp.type.number"] = { link = "Number" },
		-- Tokens that represent an operator
		["@lsp.type.operator"] = { link = "Operator" },
		-- Identifiers that declare or reference a function or method parameters
		["@lsp.type.parameter"] = { link = "@variable.parameter" },
		-- Identifiers that declare or reference a member property, member field, or member variable
		["@lsp.type.property"] = { link = "@property" },
		-- Tokens that represent a regular expression literal
		["@lsp.type.regexp"] = { link = "String" },
		-- Tokens that represent a string literal
		["@lsp.type.string"] = { link = "String" },
		-- Identifiers that declare or reference a struct type
		["@lsp.type.struct"] = { link = "Type" },
		-- Identifiers that declare or reference a type that is not covered above
		["@lsp.type.type"] = { link = "Type" },
		-- Identifiers that declare or reference a type parameter
		["@lsp.type.typeParameter"] = { link = "Type" },
		-- Identifiers that declare or reference a local or global variable
		["@lsp.type.variable"] = { link = "Identifier" },

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
			bg = utils.blend(c.nontext, c.bg, 0.4),
		},
		LspReferenceText = { bg = c.surface },
		LspReferenceRead = { bg = c.surface },
		LspReferenceWrite = { bg = c.surface },
		LspCodeLens = { fg = c.surfacefg },
		LspCodeLensSeparator = { fg = c.nontext },
		LspSignatureActiveParameter = { italic = true },
	}

	--- @type { [string]: vim.api.keyset.highlight }
	local diagnostics = {
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticError = { fg = c.red },
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticWarn = { fg = c.lightyellow },
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticInfo = { fg = c.gray },
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticHint = { fg = c.lightorange },
		-- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticOk = {},
		-- Used for "Error" diagnostic virtual text.
		DiagnosticVirtualTextError = {
			fg = c.red,
			bg = utils.blend(c.red, c.bg, 0.1),
		},
		-- Used for "Warn" diagnostic virtual text.
		DiagnosticVirtualTextWarn = {
			fg = c.lightyellow,
			bg = utils.blend(c.lightyellow, c.bg, 0.1),
		},
		-- Used for "Info" diagnostic virtual text.
		DiagnosticVirtualTextInfo = {
			fg = c.gray,
			bg = utils.blend(c.gray, c.bg, 0.2),
		},
		-- Used for "Hint" diagnostic virtual text.
		DiagnosticVirtualTextHint = {
			fg = c.lightorange,
			bg = utils.blend(c.lightorange, c.bg, 0.1),
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
		gitcommitsummary = { link = "Identifier" },
		gitcommitHeader = { link = "Statement" },
		gitcommitSelectedFile = { link = "VCSAdd" },
		gitcommitDiscardedFile = { link = "VCSDelete" },
		gitcommitUnmergedFile = { link = "VCSChange" },
		GitSignsAdd = { fg = c.green },
		GitSignsChange = { fg = c.yellow },
		GitSignsDelete = { fg = c.red },
		TelescopeMatching = { fg = c.pink },
		TelescopePromptPrefix = { fg = c.yellow },
		TelescopeSelectionCaret = { fg = c.yellow, bg = c.selection },
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

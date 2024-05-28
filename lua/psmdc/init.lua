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
			bg = utils.blend(c.cyan, c.bg, 0.15),
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
		SignColumn = { link = "Normal" },
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
		NormalFloat = { link = "Pmenu" },

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
		-- ae88851cac32415c8239a04b7ee44d8f7625e186
		--- Misc
		["@attribute"] = { fg = c.brown, bold = true },
		["@boolean"] = { link = "Boolean" },
		["@character"] = { link = "Character" },
		["@character.special"] = { link = "Character" },
		["@comment"] = { link = "Comment" },
		["@comment.documentation"] = { link = "Comment" },
		["@conditional"] = { link = "Conditional" },
		["@conditional.ternary"] = { link = "Conditional" },
		["@constant"] = { link = "Constant" },
		["@constant.builtin"] = { link = "Constant" },
		["@constant.macro"] = { link = "Define" },
		["@constructor"] = { link = "Type" },
		["@debug"] = { link = "Debug" },
		["@define"] = { link = "Define" },
		["@error"] = { sp = c.red, underdashed = true },
		["@exception"] = { link = "Exception" },
		["@field"] = { link = "Identifier" },
		["@float"] = { link = "Float" },
		["@function"] = { link = "Function" },
		["@function.builtin"] = { link = "Function" },
		["@function.call"] = { link = "Function" },
		["@function.macro"] = { link = "Macro" },
		["@include"] = { link = "Include" },
		["@keyword"] = { link = "Keyword" },
		["@keyword.coroutine"] = { link = "Keyword" },
		["@keyword.function"] = { link = "Keyword" },
		["@keyword.operator"] = { fg = c.lightpink, italic = true },
		["@keyword.return"] = { fg = c.blue, italic = true },
		["@label"] = { link = "Label" },
		["@method"] = { link = "Function" },
		["@method.call"] = { link = "Function" },
		["@namespace"] = { link = "Identifier" },
		["@none"] = {},
		["@number"] = { link = "Number" },
		["@operator"] = { link = "Operator" },
		["@parameter"] = { fg = c.fg, bold = true },
		["@preproc"] = { link = "PreProc" },
		["@property"] = { link = "Identifier" },
		["@punctuation.bracket"] = { link = "Delimiter" },
		["@punctuation.delimiter"] = { link = "Delimiter" },
		["@punctuation.special"] = { link = "Delimiter" },
		["@repeat"] = { link = "Repeat" },
		["@storageclass"] = { link = "StorageClass" },
		["@string"] = { link = "String" },
		["@string.documentation"] = { link = "String" },
		["@string.escape"] = { link = "Special" },
		["@string.regex"] = { link = "String" },
		["@string.special"] = { link = "String" },
		["@symbol"] = { link = "Identifier" },
		["@tag"] = { link = "Keyword" },
		["@tag.attribute"] = { link = "@parameter" },
		["@tag.delimiter"] = { link = "@punctuation.delimiter" },
		["@text"] = { fg = c.fg },
		["@text.danger"] = { fg = c.red, italic = true, reverse = true },
		["@text.diff.add"] = { link = "diffRemoved" },
		["@text.diff.delete"] = { link = "diffAdded" },
		["@text.emphasis"] = { italic = true },
		["@text.environment"] = { link = "@text" },
		["@text.environment.name"] = { link = "Type" },
		["@text.literal"] = { fg = c.lightyellow },
		["@text.literal.block"] = { link = "@text" },
		["@text.math"] = { link = "Special" },
		["@text.note"] = { fg = c.fg, italic = true, reverse = true },
		["@text.quote"] = { link = "String" },
		["@text.reference"] = { sp = c.brown, underline = true },
		["@text.strike"] = { strikethrough = true },
		["@text.strong"] = { bold = true },
		["@text.title"] = { link = "Statement" },
		["@text.todo"] = { link = "Todo" },
		["@text.underline"] = { link = "Underlined" },
		["@text.uri"] = { link = "Underlined" },
		["@text.warning"] = { fg = c.yellow, italic = true, reverse = true },
		["@type"] = { link = "Type" },
		["@type.builtin"] = { link = "Type" },
		["@type.definition"] = { link = "Type" },
		["@type.qualifier"] = { link = "Keyword" },
		["@variable"] = { link = "Identifier" },
		["@variable.builtin"] = { fg = c.lightpurple },

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

local M = {}
local utils = require("psmdc.utils")
local colors = require("psmdc.colors")
local config = {
	transparent_bg = false
}

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
		DiffChange = { bg = utils.blend(c.yellow, c.bg, 0.15) },
		DiffText = { fg = c.yellow, bg = utils.blend(c.yellow, c.bg, 0.42) },
		ErrorMsg = { fg = c.bg, bg = c.red, bold = true },
		Folded = {
			bg = utils.blend(c.cyan, c.bg, 0.2),
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
		Normal = { fg = c.fg, bg = config.transparent_bg and "NONE" or c.bg },
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
		["@attribute"] = { fg = c.brown, bold = true },
		["@boolean"] = { link = "Boolean" },
		["@character"] = { link = "Character" },
		["@character.special"] = { link = "Character" },
		["@comment"] = { link = "Comment" },
		["@comment.documentation"] = { fg = c.comment_doc },
		["@comment.error"] = { fg = c.red, italic = true, reverse = true },
		["@comment.note"] = { fg = c.fg, italic = true, reverse = true },
		["@comment.todo"] = { link = "Todo" },
		["@comment.warning"] = { fg = c.yellow, italic = true, reverse = true },
		["@constant"] = { link = "Constant" },
		["@constant.builtin"] = { link = "Constant" },
		["@constant.macro"] = { link = "Define" },
		["@constructor"] = { link = "Type" },
		["@diff.delta"] = { link = "DiffChange" },
		["@diff.minus"] = { link = "DiffDelete" },
		["@diff.plus"] = { link = "DiffAdd" },
		-- no longer exists on 0.10
		-- ["@error"] = { sp = c.red, underdashed = true },
		["@function"] = { link = "Function" },
		["@function.builtin"] = { link = "Function" },
		["@function.call"] = { link = "Function" },
		["@function.method"] = { link = "Function" },
		["@function.method.call"] = { link = "Function" },
		["@function.macro"] = { link = "Macro" },
		["@keyword"] = { link = "Keyword" },
		["@keyword.conditional"] = { link = "Conditional" },
		["@keyword.conditional.ternary"] = { link = "Conditional" },
		["@keyword.coroutine"] = { link = "Keyword" },
		["@keyword.debug"] = { link = "Debug" },
		["@keyword.directive"] = { link = "PreProc" },
		["@keyword.directive.define"] = { link = "Define" },
		["@keyword.exception"] = { link = "Exception" },
		["@keyword.function"] = { link = "Keyword" },
		["@keyword.import"] = { link = "Include" },
		-- linked to StorageClass before 0.10
		["@keyword.modifier"] = { link = "Keyword" },
		["@keyword.operator"] = { fg = c.lightpink, italic = true },
		["@keyword.repeat"] = { link = "Repeat" },
		["@keyword.return"] = { fg = c.blue, italic = true },
		["@keyword.type"] = { link = "Keyword" },
		["@label"] = { link = "Label" },
		["@markup.heading"] = { link = "String" },
		["@markup.heading.1"] = { link = "String" },
		["@markup.heading.2"] = { link = "String" },
		["@markup.heading.3"] = { link = "String" },
		["@markup.heading.4"] = { link = "String" },
		["@markup.heading.5"] = { link = "String" },
		["@markup.heading.6"] = { link = "String" },
		["@markup.italic"] = { italic = true },
		["@markup.link"] = { sp = c.brown, underline = true },
		["@markup.link.label"] = { link = "@markup.link" },
		["@markup.link.url"] = { link = "@markup.link" },
		["@markup.list"] = { link = "Delimiter" },
		["@markup.list.checked"] = { link = "Todo" },
		["@markup.list.unchecked"] = { link = "DiffAdd" },
		["@markup.math"] = { link = "Special" },
		["@markup.quote"] = { link = "String" },
		["@markup.raw"] = { fg = c.lightyellow },
		["@markup.raw.block"] = { link = "Identifier" },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.strong"] = { bold = true },
		["@markup.underline"] = { link = "Underlined" },
		["@module"] = { link = "Identifier" },
		["@module.builtin"] = { link = "Identifier" },
		["@none"] = {},
		["@number"] = { link = "Number" },
		["@number.float"] = { link = "Float" },
		["@operator"] = { link = "Operator" },
		["@property"] = { link = "Identifier" },
		["@punctuation.bracket"] = { link = "Delimiter" },
		["@punctuation.delimiter"] = { link = "Delimiter" },
		["@punctuation.special"] = { link = "Delimiter" },
		["@string"] = { link = "String" },
		["@string.documentation"] = { link = "String" },
		["@string.escape"] = { link = "Special" },
		["@string.regex"] = { link = "String" },
		["@string.special"] = { link = "String" },
		["@string.special.path"] = { sp = c.brown, underline = true },
		["@string.special.symbol"] = { link = "Identifier" },
		["@string.special.url"] = { link = "@string.special.path" },
		["@tag"] = { link = "Keyword" },
		["@tag.attribute"] = { link = "@parameter" },
		["@tag.builtin"] = { link = "Keyword" },
		["@tag.delimiter"] = { link = "@punctuation.delimiter" },
		["@type"] = { link = "Type" },
		["@type.builtin"] = { link = "Type" },
		["@type.definition"] = { link = "Type" },
		["@type.qualifier"] = { link = "Keyword" },
		["@variable"] = { link = "Identifier" },
		["@variable.builtin"] = { fg = c.lightpurple },
		["@variable.member"] = { link = "Identifier" },
		["@variable.parameter"] = { fg = c.fg, bold = true },
		["@variable.parameter.builtin"] = { link = "@variable.parameter" },

		--- LSP semantic tokens (type)
		--- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_semanticTokens
		--- :h lsp-semantic-highlight
		["@lsp.type.class"] = { link = "Type" },
		["@lsp.type.decorator"] = { link = "@tag.attribute" },
		["@lsp.type.enum"] = { link = "Type" },
		["@lsp.type.enumMember"] = { link = "Constant" },
		["@lsp.type.function"] = { link = "Function" },
		["@lsp.type.interface"] = { link = "Type" },
		["@lsp.type.macro"] = { link = "Macro" },
		["@lsp.type.method"] = { link = "Function" },
		["@lsp.type.namespace"] = { link = "@module" },
		["@lsp.type.parameter"] = { link = "@variable.parameter" },
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

function M.setup(opts)
	if opts == nil then
		return
	end
	config.transparent_bg = not not opts.transparent_bg
end

return M

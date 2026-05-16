local c = require("psmdc.colors").dark
local blend = require("psmdc.utils").blend

local psmdc = {}

psmdc.normal = {
	a = { fg = c.bg, bg = c.func },
	b = { bg = blend(c.func, c.surface, 0.1) },
	c = { fg = c.surfacefg, bg = c.bg },
}

psmdc.insert = {
	a = { fg = c.bg, bg = c.menu_sel },
	b = { fg = c.fg, bg = blend(c.menu_sel, c.surface, 0.1) },
}

psmdc.command = {
	a = { fg = c.bg, bg = c.delimiter },
	b = { fg = c.fg, bg = blend(c.delimiter, c.surface, 0.1) },
}

psmdc.visual = {
	a = { fg = c.bg, bg = c.type },
	b = { fg = c.fg, bg = blend(c.type, c.surface, 0.1) },
}

psmdc.replace = {
	a = { fg = c.bg, bg = c.constant },
	b = { fg = c.fg, bg = blend(c.constant, c.surface, 0.1) },
}

psmdc.inactive = {
	a = { fg = c.fg_4, bg = c.surface_lighter, },
	b = "Normal",
	c = "Normal",
}

return psmdc

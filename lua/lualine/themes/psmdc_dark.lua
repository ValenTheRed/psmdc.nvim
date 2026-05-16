local c = require("psmdc.colors").dark
local blend = require("psmdc.utils").blend

local psmdc = {}

psmdc.normal = {
	a = { fg = c.bg, bg = c.purple },
	b = { bg = blend(c.purple, c.surface, 0.1) },
	c = { fg = c.surfacefg, bg = c.bg },
}

psmdc.insert = {
	a = { fg = c.bg, bg = c.pink },
	b = { fg = c.fg, bg = blend(c.pink, c.surface, 0.1) },
}

psmdc.command = {
	a = { fg = c.bg, bg = c.cyan },
	b = { fg = c.fg, bg = blend(c.cyan, c.surface, 0.1) },
}

psmdc.visual = {
	a = { fg = c.bg, bg = c.yellow },
	b = { fg = c.fg, bg = blend(c.yellow, c.surface, 0.1) },
}

psmdc.replace = {
	a = { fg = c.bg, bg = c.orange },
	b = { fg = c.fg, bg = blend(c.orange, c.surface, 0.1) },
}

psmdc.inactive = {
	a = { bg = c.surface_lighter },
	b = "Normal",
	c = "Normal",
}

return psmdc

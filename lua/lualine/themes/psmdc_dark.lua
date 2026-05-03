local c = require("psmdc.colors").dark

local psmdc = {}

psmdc.normal = {
	a = { fg = c.bg, bg = c.func },
	b = { fg = c.func, bg = c.surface_darker },
	c = { fg = c.surfacefg, bg = c.surface },
}

psmdc.insert = {
	a = { fg = c.bg, bg = c.menu_sel },
	b = { fg = c.menu_sel, bg = c.surface_darker },
}

psmdc.command = {
	a = { fg = c.bg, bg = c.delimiter },
	b = { fg = c.delimiter, bg = c.surface_darker },
}

psmdc.visual = {
	a = { fg = c.bg, bg = c.type },
	b = { fg = c.type, bg = c.surface_darker },
}

psmdc.replace = {
	a = { fg = c.bg, bg = c.constant },
	b = { fg = c.constant, bg = c.surface_darker },
}

psmdc.inactive = {
	a = { bg = c.surface_lighter },
	b = "Normal",
	c = "Normal",
}

return psmdc

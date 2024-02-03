local M = {}
local utils = require("psmdc.utils")
local hsl = require("psmdc.hsluv").hsluv_to_hex

local hsluv = require("psmdc.hsluv").hsluv_to_hex

M.dark = {
	black_white = hsluv { 0, 0, 100 },
	white = hsluv { 0, 0, 100 },
	black = hsluv { 0, 0, 0 },
	gray = hsluv { 0, 0, 54 },
	yellow = hsluv { 52, 100, 82 },
	orange = hsluv { 20, 88, 64.5 },
	red = hsluv { 7, 91.2, 54.1 },
	pink = hsluv { 337, 82, 64 },
	purple = hsluv { 288, 100, 72 },
	blue = hsluv { 259, 100, 70 },
	cyan = hsluv { 224, 99, 84 },
	green = hsluv { 105, 59, 88 },

	green2 = hsluv { 105, 59, 88 },
	violet = hsluv { 314, 34, 61 },
	brown = hsluv { 21.5, 76, 55.3 },

	lightorange = hsluv { 14, 88, 64.5 },
	lightpink = hsluv { 337, 82, 64 },
	lightblue = hsluv { 259, 100, 70 },
	lightyellow = hsluv { 52, 100, 82 },

	bg = hsluv { 305, 100, 0.70 },
	fg = hsluv { 256, 0, 75 },
	border = hsluv { 0, 0, 82 },
	comments = hsluv { 256, 0, 60 },
	nontext = hsluv { 256, 0, 30 },
	selection = hsluv { 285, 28, 12 },
	cursor_line = hsluv { 305, 55, 3 },
	surface = hsluv { 305, 55, 10 },
	surfacefg = hsluv { 256, 0, 78 },
	surface_darker = hsluv { 305, 55, 4.5 },
	surfacefg_darker = hsluv { 256, 0, 70 },
}

M.light = {
	black_white = hsluv { 0, 0, 0 },
	white = hsluv { 0, 0, 100 },
	black = hsluv { 0, 0, 0 },
	gray = hsluv { 0, 0, 54 },
	yellow = hsluv { 50, 100, 65 },
	orange = hsluv { 20, 88, 64.5 },
	red = hsluv { 7, 91.2, 54.1 },
	pink = hsluv { 337, 82, 60 },
	purple = hsluv { 288, 100, 45 },
	blue = hsluv { 259, 100, 45 },
	cyan = hsluv { 224, 100, 70 },
	green = hsluv { 116, 100, 65 },

	green2 = hsluv { 115, 59, 58 },
	violet = hsluv { 314, 34, 61 },
	brown = hsluv { 21.5, 76, 55.3 },

	lightorange = hsluv { 14, 88, 64.5 },
	lightpink = hsluv { 337, 82, 64 },
	lightblue = hsluv { 259, 100, 70 },
	lightyellow = hsluv { 52, 100, 75 },

	bg = hsluv { 305, 55, 95 },
	fg = hsluv { 256, 0, 25 },
	comments = hsluv { 256, 0, 60 },
	nontext = hsluv { 256, 0, 80 },
	selection = hsluv { 285, 28, 82 },
	cursor_line = hsluv { 305, 55, 92.5 },
	surface = hsluv { 305, 55, 83 },
	surface_darker = hsluv { 305, 55, 90 },
	surfacefg = hsluv { 256, 0, 25 },
	surfacefg_darker = hsluv { 256, 0, 30 },
}

return M

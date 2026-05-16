local M = {}
local hsluv = require("psmdc.hsluv").hsluv_to_hex

local white = {
	"#FFFFFF",
	"#F6F5F4",
	"#DEDDDA",
	"#C0BFBC",
	"#9A9996",
}

--- @class psmdc.palette
--- @field bg string
--- @field fg string
--- @field fg_1 string
--- @field fg_2 string
--- @field fg_3 string
--- @field fg_4 string
--- @field fg_5 string
--- @field white string
--- @field black string
--- @field constant string
--- @field keyword string
--- @field str string
--- @field str_esc string
--- @field delimiter string
--- @field func string
--- @field type string
--- @field error string
--- @field non_text string
--- @field search string
--- @field menu_sel string
--- @field diff_add string
--- @field attr string
--- @field diagnostic_hint string
--- @field operator string
--- @field raw_text string
--- @field comments string
--- @field selection string
--- @field cursor_line string
--- @field surface_lighter string
--- @field surface string
--- @field surfacefg string
--- @field surface_darker string
--- @field surfacefg_darker string

--- @type psmdc.palette
M.dark = {
	bg = "#07070a",
	fg = white[3],

	fg_1 = white[1],
	fg_2 = white[2],
	fg_3 = white[3],
	fg_4 = white[4],
	fg_5 = white[5],

	white = hsluv { 0, 0, 100 },
	black = hsluv { 0, 0, 0 },

	constant = hsluv { 20, 88, 64.5 },
	keyword = hsluv { 259, 100, 70 },
	str = hsluv { 105, 59, 88 },
	str_esc = hsluv { 314, 34, 61 },
	delimiter = hsluv { 224, 99, 84 },
	func = hsluv { 288, 100, 72 },
	type = hsluv { 52, 100, 82 },
	error = hsluv { 7, 91.2, 54.1 },
	non_text = hsluv { 256, 0, 30 },
	search = hsluv { 0, 0, 54 },
	menu_sel = hsluv { 337, 82, 64 },
	diff_add = hsluv { 105, 59, 88 },
	attr = hsluv { 21.5, 76, 55.3 },
	diagnostic_hint = hsluv { 14, 88, 64.5 },
	operator = hsluv { 337, 82, 64 },
	raw_text = hsluv { 52, 100, 82 },

	comments = hsluv { 256, 0, 60 },
	selection = hsluv { 285, 28, 22 },
	cursor_line = hsluv { 305, 55, 3 },
	surface_lighter  = hsluv { 265.9, 3.6, 23.9 },
	surface = "#27272b",
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
	comment_doc = hsluv { 52, 15, 20 },
	nontext = hsluv { 256, 0, 80 },
	selection = hsluv { 285, 28, 82 },
	cursor_line = hsluv { 305, 55, 92.5 },
	surface = hsluv { 305, 55, 83 },
	surface_darker = hsluv { 305, 55, 90 },
	surfacefg = hsluv { 256, 0, 25 },
	surfacefg_darker = hsluv { 256, 0, 30 },
}

return M

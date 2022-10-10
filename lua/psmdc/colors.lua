local M = {}
local utils = require("psmdc.utils")
local hsl = require("psmdc.hsluv").hsluv_to_hex

M.dark = {}
M.dark.clr = {
  white  = hsl {0, 0, 100},
  black  = hsl {0, 0, 0},
  gray   = hsl {0, 0, 68},
  red    = hsl {5, 100, 60},
  orange = hsl {14, 88, 64.5},
  yellow = hsl {57, 100, 84},
  green  = hsl {102, 59, 88},
  green2 = hsl {90, 80, 90},
  cyan   = hsl {224, 99, 84},
  blue   = hsl {265, 99, 69},
  brown  = hsl {22, 37, 59},
  purple = hsl {288, 75,  68},
  pink   = hsl {337, 82, 64},
  violet = hsl {314, 34, 61},

  lightorange = hsl {30, 80, 80},
  lightpink   = hsl {303, 80,  73},
  lightblue   = hsl {217, 24, 80},
  lightyellow = hsl {70, 80, 80},
}
M.dark.grp = {
  bg               = hsl {285, 10, 5},
  fg               = hsl {256, 12, 64},
  surface          = hsl {285, 28, 13},
  surface_darker   = hsl {285, 30, 9},
  surfacefg        = hsl {256, 12, 64},
  surfacefg_darker = hsl {256, 12, 64},
  selection        = hsl {285, 28, 13},
  comments         = hsl {256, 21, 37},
  nontext          = hsl {258, 21, 26},
  cursor_line      = hsl {285, 0, 2},
}

local hsluv = require("psmdc.hsluv").hsluv_to_hex

M.darker = {}
M.darker.clr = {
  white  = hsluv {0, 0, 100},
  black  = hsluv {0, 0, 0},
  gray   = hsluv {0, 0, 54},
  yellow = hsluv {52, 100, 82},
  orange = hsluv {20, 88, 64.5},
  red    = hsluv {7, 91.2, 54.1},
  pink   = hsluv {337, 82, 64},
  purple = hsluv {288, 100,  72},
  blue   = hsluv {259, 100, 70},
  cyan   = hsluv {224, 99, 84},
  green  = hsluv {105, 59, 88},

  green2  = hsluv {105, 59, 88},
  violet = hsluv {314, 34, 61},
  brown = hsluv {20, 88, 64.5},

  lightorange = hsluv {20, 88, 64.5},
  lightpink   = hsluv {337, 82, 64},
  lightblue   = hsluv {259, 100, 70},
  lightyellow = hsluv {52, 100, 82},
}
M.darker.grp = {
  bg               = hsluv {305, 100, .70},
  fg               = hsluv {256, 0, 75},
  comments         = hsluv {256, 0, 60},
  nontext          = hsluv {256, 0, 30},
  selection        = hsluv {285, 28, 12},
  cursor_line      = hsluv {305, 55, 3},
  surface          = hsluv {305, 55, 10},
  surfacefg        = hsluv {256, 0, 78},
  surface_darker   = hsluv {305, 55, 4.5},
  surfacefg_darker = hsluv {256, 0, 65},
}

return M

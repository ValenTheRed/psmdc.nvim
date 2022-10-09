local M = {}
local utils = require("psmdc.utils")
local hsl = require("psmdc.hsluv").hsluv_to_hex

M.dark = {
  bg = hsl {285, 10, 5},
  fg = hsl {256, 12, 64},

  white  = hsl {0, 0, 100},
  black  = hsl {0, 0, 0},
  gray   = hsl {0, 0, 68},
  red    = hsl {5, 100, 60},
  orange = hsl {14, 88, 64.5},
  yellow = hsl {57, 100, 84},
  green  = hsl {102, 59, 88},
  green2  = hsl {90, 80, 90},
  cyan   = hsl {224, 99, 84},
  blue   = hsl {265, 99, 69},
  brown  = hsl {22, 37, 59},
  purple = hsl {288, 75,  68},
  pink   = hsl {337, 82, 64},
  violet = hsl {314, 34, 61},

  paleorange = hsl {30, 80, 80},
  palepink   = hsl {303, 80,  73},
  paleblue   = hsl {217, 24, 80},
  paleyellow = hsl {70, 80, 80},

  selection        = hsl {285, 28, 13},
  selection2 = hsl {285, 30, 9},
  comments         = hsl {256, 21, 37},
  guides           = hsl {258, 21, 26},
  line_numbers     = hsl {258, 21, 26},
  line_highlight   = hsl {269, 0, 2},
  inline_highlight = hsl {260, 27, 9},
  caret            = hsl {60, 10, 62},
}

return M

local M = {}
hsluv = require("psmdc.hsluv")
math = require("math")

-- From tokyonight.util
---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(fg, bg, alpha)
  local bg, fg = hsluv.hex_to_rgb(bg), hsluv.hex_to_rgb(fg)
  local blendChannel = function(i)
    return alpha * fg[i] + (1 - alpha) * bg[i]
  end
  return hsluv.rgb_to_hex {blendChannel(1), blendChannel(2), blendChannel(3)}
end

function M.set_highlight(grp, args)
  vim.api.nvim_command(string.format(
    "highlight %s gui=%s guifg=%s guibg=%s guisp=%s",
    grp,
    args.attr or "NONE",
    args.fg or "NONE",
    args.bg or "NONE",
    args.sp or "NONE"
  ))
end

function M.set_link(from, args)
  local args = args or {}
  vim.api.nvim_command(string.format(
    "highlight%s link %s %s",
    args.force and "!" or "",
    from,
    args.to or "NONE"
  ))
end

return M

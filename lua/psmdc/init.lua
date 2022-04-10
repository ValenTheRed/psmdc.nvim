local M = {}
local utils = require("psmdc.utils")
local colors = require("psmdc.colors")

local function set_groups(c)
  local groups = {
  }

  for grp, args in pairs(groups) do
    utils.set_highlight(grp, args)
  end

  local links = {
  }

  for from, args in pairs(links) do
    utils.set_link(from, args)
  end
end

function M.colorscheme(name)
  vim.api.nvim_command("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.api.nvim_command("syntax reset")
  end

  vim.o.termguicolors = true
  vim.g.colors_name = name
  set_groups(colors[name])
end

return M

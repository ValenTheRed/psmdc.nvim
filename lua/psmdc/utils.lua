local M = {}

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

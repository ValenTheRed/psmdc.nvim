" clear cache so this reloads changes; useful for development
" lua package.loaded["psmdc"] = nil
" lua package.loaded["psmdc.colors"] = nil
" lua package.loaded["psmdc.utils"] = nil
lua vim.opt.background = "light"
lua require("psmdc").colorscheme("light")

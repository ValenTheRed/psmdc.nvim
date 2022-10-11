local c = require("psmdc.colors").dark

local psmdc = {}

psmdc.normal = {
  a = { fg=c.grp.bg, bg=c.clr.purple },
  b = { fg=c.clr.purple, bg=c.grp.surface_darker },
  c = { fg=c.grp.surfacefg, bg=c.grp.surface },
}

psmdc.insert = {
  a = { fg=c.grp.bg, bg=c.clr.pink },
  b = { fg=c.clr.pink, bg=c.grp.surface_darker},
}

psmdc.command = {
  a = { fg=c.grp.bg, bg=c.clr.cyan },
  b = { fg=c.clr.cyan, bg=c.grp.surface_darker},
}

psmdc.visual = {
  a = { fg=c.grp.bg, bg=c.clr.lightyellow },
  b = { fg=c.clr.lightyellow, bg=c.grp.surface_darker},
}

psmdc.replace = {
  a = { fg=c.grp.bg, bg=c.clr.orange },
  b = { fg=c.clr.orange, bg=c.grp.surface_darker},
}

psmdc.inactive = {
  a = { fg=c.grp.surfacefg_darker, bg=c.grp.surface_darker },
  b = { fg=c.grp.surfacefg_darker, bg=c.grp.surface_darker },
  c = { fg=c.grp.surfacefg_darker, bg=c.grp.surface_darker },
}

return psmdc

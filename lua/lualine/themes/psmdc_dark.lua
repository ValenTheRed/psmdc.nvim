local c = require("psmdc.colors").dark

local psmdc = {}

psmdc.normal = {
  a = { fg=c.grp.bg, bg=c.clr.purple },
  b = { fg=c.grp.surfacefg_darker, bg=c.grp.surface_darker },
  c = { fg=c.grp.surfacefg, bg=c.grp.surface },
}

psmdc.insert = {
  a = { fg=c.grp.bg, bg=c.clr.pink },
}

psmdc.command = {
  a = { fg=c.grp.bg, bg=c.clr.cyan },
}

psmdc.visual = {
  a = { fg=c.grp.bg, bg=c.clr.paleyellow },
}

psmdc.replace = {
  a = { fg=c.grp.bg, bg=c.clr.orange },
}

psmdc.inactive = {
  a = { fg=c.grp.surfacefg_darker, bg=c.grp.surface_darker },
  b = { fg=c.grp.surfacefg_darker, bg=c.grp.surface_darker },
  c = { fg=c.grp.surfacefg_darker, bg=c.grp.surface_darker },
}

return psmdc

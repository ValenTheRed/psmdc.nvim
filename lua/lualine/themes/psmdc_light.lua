local c = require("psmdc.colors").light

local psmdc = {}

psmdc.normal = {
  a = { fg=c.grp.bg, bg=c.clr.purple },
  b = { fg=c.clr.purple, bg=c.grp.surface_darker},
  c = { fg=c.grp.surfacefg, bg=c.grp.surface },
}


psmdc.insert = {
  a = { fg=c.grp.bg, bg=c.clr.pink },
  b = { fg=c.clr.pink, bg=c.grp.surface_darker},
}

psmdc.command = {
  a = { fg=c.grp.bg, bg=c.clr.blue },
  b = { fg=c.clr.blue, bg=c.grp.surface_darker},
}

psmdc.visual = {
  a = { fg=c.grp.bg, bg=c.clr.yellow },
  b = { fg=c.clr.yellow, bg=c.grp.surface_darker},
}

psmdc.replace = {
  a = { fg=c.grp.bg, bg=c.clr.orange },
  b = { fg=c.clr.orange, bg=c.grp.surface_darker},
}

psmdc.inactive = {
  a = { fg=c.grp.bg, bg=c.clr.violet },
  b = { fg=c.clr.violet, bg=c.grp.surface_darker },
  c = { fg=c.grp.surfacefg, bg=c.grp.surface },
}

return psmdc

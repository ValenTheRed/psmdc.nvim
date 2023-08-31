local c = require("psmdc.colors").light

local psmdc = {}

psmdc.normal = {
  a = { fg=c.bg, bg=c.purple },
  b = { fg=c.purple, bg=c.surface_darker},
  c = { fg=c.surfacefg, bg=c.surface },
}


psmdc.insert = {
  a = { fg=c.bg, bg=c.pink },
  b = { fg=c.pink, bg=c.surface_darker},
}

psmdc.command = {
  a = { fg=c.bg, bg=c.blue },
  b = { fg=c.blue, bg=c.surface_darker},
}

psmdc.visual = {
  a = { fg=c.bg, bg=c.yellow },
  b = { fg=c.yellow, bg=c.surface_darker},
}

psmdc.replace = {
  a = { fg=c.bg, bg=c.orange },
  b = { fg=c.orange, bg=c.surface_darker},
}

psmdc.inactive = {
  a = { fg=c.bg, bg=c.violet },
  b = { fg=c.violet, bg=c.surface_darker },
  c = { fg=c.surfacefg, bg=c.surface },
}

return psmdc

local c = require("psmdc.colors").dark

local psmdc = {}

psmdc.normal = {
  a = { fg=c.bg, bg=c.purple },
  b = { fg=c.gray, bg=c.selection2 },
  c = { fg=c.gray, bg=c.selection },
}

psmdc.insert = {
  a = { fg=c.bg, bg=c.pink },
  -- b = { fg=c.gray, bg=c.selection2 },
  -- c = { fg=c.gray, bg=c.selection },
}

psmdc.command = {
  a = { fg=c.bg, bg=c.cyan },
  -- b = { fg=c.gray, bg=c.selection2 },
  -- c = { fg=c.gray, bg=c.selection },
}

psmdc.visual = {
  a = { fg=c.bg, bg=c.paleyellow },
  -- b = { fg=c.gray, bg=c.selection2 },
  -- c = { fg=c.gray, bg=c.selection },
}

psmdc.replace = {
  a = { fg=c.bg, bg=c.orange },
  -- b = { fg=c.gray, bg=c.selection2 },
  -- c = { fg=c.gray, bg=c.selection },
}

psmdc.inactive = {
  a = { fg=c.comments, bg=c.selection2 },
  b = { fg=c.comments, bg=c.selection2 },
  c = { fg=c.comments, bg=c.selection2 },
}

return psmdc

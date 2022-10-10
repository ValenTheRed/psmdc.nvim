local c = require("psmdc.colors").dark

local psmdc = {}

psmdc.normal = {
  a = { fg=c.grp.bg, bg=c.clr.purple },
  b = { fg=c.clr.gray, bg=c.grp.selection2 },
  c = { fg=c.clr.gray, bg=c.grp.selection },
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
  a = { fg=c.grp.comments, bg=c.grp.selection2 },
  b = { fg=c.grp.comments, bg=c.grp.selection2 },
  c = { fg=c.grp.comments, bg=c.grp.selection2 },
}

return psmdc

local m = require("util").lazy_map

local opts = {
  keep_focus = false,
}

return {
  "ariel-frischer/bmessages.nvim",
  event = "CmdlineEnter",
  opts = opts,
  keys = {
    m("<leader>bm", "Bmessages"),
  },
}

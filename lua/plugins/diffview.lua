local u = require("util")
local c = u.create_cmd
local m = u.lazy_map

--  TODO: 2024-06-21 - Create user command to view diffs between branches.
--  Prompt for branches

return {
  "sindrets/diffview.nvim",
  init = function()
    c("DiffviewPrompt", require("util.diffview").open)
  end,
  config = true,
  cmd = { "DiffviewOpen" },
  keys = {
    m("<leader>do", [[DiffviewOpen]]),
    m("<leader>dq", [[DiffviewClose]]),
    m("<leader>dm", [[DiffviewPrompt]]),
  },
}

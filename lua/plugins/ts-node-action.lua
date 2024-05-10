local m = require("util").lazy_map
local u = require("util")

local function expand_class(node)
  local row = node:start()
  local node_text = vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf())
  local classes = u.split_string(node_text)
  local quote = classes[1]:sub(1, 1)
  classes[1] = classes[1]:sub(2)
  classes[#classes] = classes[#classes]:sub(1, -2)
  local spaces = (" "):rep(row + vim.bo.shiftwidth)
  local lines = { spaces .. "class=" .. quote }
  for _, class in ipairs(classes) do
    table.insert(lines, spaces .. (" "):rep(vim.bo.shiftwidth) .. class)
  end
  table.insert(lines, spaces .. quote)
  vim.api.nvim_buf_set_lines(0, row, row + 1, false, lines)
  if not vim.b.disable_autoformat then
    vim.b.disable_autoformat = true
  end
end

local function collapse_class(node)
  local row_start, col_start = node:start()
  local row_end, col_end = node:end_()
  local node_text = vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf())
  local quote = node_text:sub(1, 1)
  local cleaned_text = node_text:gsub("\n", " "):gsub("%s+", " "):match("^%s*(.-)%s*$"):sub(3, -3)
  local line = "=" .. quote .. cleaned_text .. quote
  vim.api.nvim_buf_set_text(0, row_start, col_start - 1, row_end, col_end, { line })
  if vim.b.disable_autoformat then
    vim.b.disable_autoformat = false
  end
end

return {
  "CKolkey/ts-node-action",
  opts = {
    vue = {
      ["attribute_name"] = function(tsnode)
        local node_text = vim.treesitter.get_node_text(tsnode, vim.api.nvim_get_current_buf())
        if node_text == "class" then
          local sibling = tsnode:next_named_sibling()
          if not sibling then
            return
          end
          local row = sibling:start()
          local end_row = sibling:end_()
          if row == end_row then
            expand_class(sibling)
          else
            collapse_class(sibling)
          end
        end
      end,
    },
  },
  keys = {
    m("<leader>i", [[lua require("ts-node-action").node_action()]]),
  },
}

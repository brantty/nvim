local dev = true
local e = vim.tbl_extend

local opts = {}

local plugin = {
	keys = {
		{
			"<leader>z",
			function()
				vim.cmd([[Lazy reload vue-goto-definition]])
			end,
		},
	},
	dependencies = "nvim-lua/plenary.nvim",
	opts = opts,
	enabled = true,
}

if dev == true then
	return e("keep", plugin, {
		dir = "~/git/vue-goto-definition.nvim",
		lazy = false,
	})
else
	return e("keep", plugin, {
		"catgoose/vue-goto-definition.nvim",
		event = "BufReadPre",
	})
end

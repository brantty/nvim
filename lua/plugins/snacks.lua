local opts = {
	-- more beautiful vim.ui.input
	input = {
		enabled = true,
		win = {
			relative = "cursor",
			backup = true,
		},
	},
	-- more beautiful vim.ui.select
	picker = { enabled = true },
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = opts,
}

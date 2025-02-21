local config = function()
	require("which-key").setup({
		preset = "modern",
		icons = {
			mappings = false,
		},
	})
end

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = config,
}

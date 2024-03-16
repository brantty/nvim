local m = require("util").lazy_map

local opts = {
	-- ensure_installed = {
	-- 	"angular",
	-- 	"bash",
	-- 	"css",
	-- 	"docker",
	-- 	"dom",
	-- 	"eslint",
	-- 	"fish-3.6",
	-- 	"html",
	-- 	"http",
	-- 	"i3",
	-- 	"javascript",
	-- 	"jq",
	-- 	"jsdoc",
	-- 	"lua-5.1",
	-- 	"markdown",
	-- 	"nginx",
	-- 	"node",
	-- 	"prettier",
	-- 	"sass",
	-- 	"tailwindcss",
	-- 	"typescript",
	-- 	"vue-3",
	-- 	"vue_router-4",
	-- },
}

return {
	"luckasRanarison/nvim-devdocs",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = true,
	cmd = {
		"DevdocsFetch",
		"DevdocsInstall",
		"DevdocsUninstall",
		"DevdocsOpen",
		"DevdocsOpenFloat",
		"DevdocsOpenCurrent",
		"DevdocsOpenCurrentFloat",
		"DevdocsUpdate",
		"DevdocsUpdateAll",
	},
	event = "VeryLazy",
	opts = opts,
	keys = {
		m("<leader>dv", [[DevdocsOpen]]),
	},
}

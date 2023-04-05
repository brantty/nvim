local opts = {
	filetypes = {
		"*",
		typescript = {
			css = false,
			names = false,
		},
		json = {
			css = false,
			names = false,
		},
		sh = {
			css = false,
			names = false,
		},
		mason = {
			css = false,
			names = false,
		},
		markdown = {
			names = false,
		},
		help = {
			names = false,
		},
	},
	user_default_options = {
		RGB = true,
		RRGGBB = true,
		names = true,
		RRGGBBAA = true,
		AARRGGBB = true,
		rgb_fn = true,
		hsl_fn = true,
		css = true,
		css_fn = true,
		mode = "background",
		method = "lsp",
		tailwind = true,
		sass = { enable = true, parsers = { "css" } },
		virtualtext = "■",
	},
	buftypes = { "!prompt", "!popup" },
}

return {
	"NvChad/nvim-colorizer.lua",
	opts = opts,
	event = "BufReadPre",
}

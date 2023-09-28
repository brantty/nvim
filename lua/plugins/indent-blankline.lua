--  TODO: 2023-09-28 - :help ibl.config
-- https://www.reddit.com/r/neovim/comments/16uiops/how_do_i_change_the_brightness_of_the/
local opts = {
	-- filetype_exclude = { "checkhealth", "help", "terminal", "markdown" },
	-- buftype_exclude = { "terminal", "nofile" },
	-- show_first_indent_level = false,
	-- show_current_context = true,
	-- show_current_context_start = false,
	-- use_treesitter = true,
	-- use_treesitter_scope = true,
	-- show_trailing_blankline_indent = false,
	-- context_patterns = {
	-- 	"class",
	-- 	"^func",
	-- 	"method",
	-- 	"^if",
	-- 	"while",
	-- 	"for",
	-- 	"with",
	-- 	"try",
	-- 	"except",
	-- 	"arguments",
	-- 	"argument_list",
	-- 	"object",
	-- 	"dictionary",
	-- 	"element",
	-- 	"table",
	-- 	"tuple",
	-- 	"do_block",
	-- },
}
return {
	"lukas-reineke/indent-blankline.nvim",
	opts = opts,
	event = "BufReadPre",
	main = "ibl",
}

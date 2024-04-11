local opts = {
	auto_update = true,
	run_on_start = true,
	ensure_installed = {
		"prettierd",
		"stylua",
		"shellcheck",
		"misspell",
		"eslint_d",
		"beautysh",
		"jsonlint",
		"hadolint",
	},
}

return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	opts = opts,
	cmd = "MasonToolsUpdate",
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}

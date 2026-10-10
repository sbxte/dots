return {
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				"flake8",
				"rust-analyzer",
			},
		},
	},
}

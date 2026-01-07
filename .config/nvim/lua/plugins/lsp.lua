return {
	"neovim/nvim-lspconfig",
	config = function()
		require("nvchad.configs.lspconfig").defaults()
		require("configs.lsp-config")
	end,
	dependencies = {
		-- format
		{
			"stevearc/conform.nvim",
			config = function()
				require("configs.conform")
			end,
		},
		-- linting
		{
			"mfussenegger/nvim-lint",
			config = function()
				require("configs.nvim-lint")
			end,
		},
		-- manage lsp servers
		{
			"williamboman/mason-lspconfig.nvim",
		},
	},
}

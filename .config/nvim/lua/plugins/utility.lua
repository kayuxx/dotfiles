return {
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascriptreact", "typescriptreact", "tsx", "jsx", "astro" },
		opts = require("configs.nvim-ts-autotag"),
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "VeryLazy",
		opts = require("configs.lspsaga"),
	},
	{
		"tpope/vim-surround",
		event = "VeryLazy",
	},
	{
		"barrett-ruth/import-cost.nvim",
		build = "sh install.sh yarn",
		ft = { "javascriptreact", "typescriptreact", "tsx" },
		config = true,
	},
	-- {
	-- 	"andweeb/presence.nvim",
	-- 	lazy = false,
	-- },
	-- {
	-- 	"brenoprata10/nvim-highlight-colors",
	-- 	opts = require("configs.nvim-highlight-colors"),
	-- },
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
	},
	{
		"folke/ts-comments.nvim",
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		config = true,
		name = "tailwind-tools",
		ft = { "html", "javascriptreact", "typescriptreact", "tsx", "jsx", "astro" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = require("configs.tailwind-tools"), -- required to startup the plugins
	},
	{
		"OXY2DEV/markview.nvim",
		enabled = false,
		lazy = false,
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
}

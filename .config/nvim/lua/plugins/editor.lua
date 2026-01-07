return {
	{
		"nvim-telescope/telescope.nvim",
		opts = require("configs.telescope"),
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = require("configs.treesitter"),
	},

	{ import = "nvchad.blink.lazyspec" },
	{
		"saghen/blink.cmp",
		opts = function()
			dofile(vim.g.base46_cache .. "blink")
			return require("configs.blink")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "User FilePost",
		opts = function()
			return require("configs.gitsigns")
		end,
	},
	{
		"stevearc/oil.nvim",
		event = "VeryLazy",
		opts = require("configs.oil"),
	},
	{
		"gsuuon/note.nvim",
		cmd = { "Note" },
		opts = require("configs.note"),
	},
}

local plugins = {
	"lukas-reineke/indent-blankline.nvim",
	"nvim-tree/nvim-tree.lua",
	"NvChad/nvim-colorizer.lua",
	"numToStr/Comment.nvim",
	"nvimdev/lspsaga.nvim",
	"hrsh7th/nvim-cmp",
	"folke/noice.nvim",
	"rafamadriz/friendly-snippets",
	"L3MON4D3/LuaSnip",
	"barrett-ruth/import-cost.nvim",
	"folke/which-key.nvim",
}

local disabledPlugins = {}

for key, value in ipairs(plugins) do
	disabledPlugins[key] = { value, enabled = false }
end

return disabledPlugins

local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		markdown = { "prettierd" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		javascript = { "deno_fmt" },
		typescript = { "deno_fmt" },
		javascriptreact = { "deno_fmt" },
		typescriptreact = { "deno_fmt" },
		json = { "deno_fmt" },
		css = { "prettierd" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

require("conform").setup(options)

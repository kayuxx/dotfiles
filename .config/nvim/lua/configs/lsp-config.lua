-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "ts_ls", "tailwindcss", "astro", "powershell_es", "pyright" }
local capabilities = require("nvchad.configs.lspconfig").capabilities

capabilities.snippetSupport = false

vim.lsp.config("*", {
	capabilities = capabilities,
	textDocument = { completion = { completionItem = { snippetSupport = false } } },
})

vim.lsp.enable(servers)

vim.diagnostic.config({
	-- virtual_text = { spacing = 4, prefix = "" },
	virtual_text = false,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
})

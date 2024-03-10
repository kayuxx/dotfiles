local lspconfig = require("lspconfig")
local config = require("nvchad.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities
local on_init = config.on_init

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "tailwindcss", "astro", "powershell_es", "pyright", "lua_ls" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		on_init = on_init,
	})
end

vim.diagnostic.config({
	virtual_text = { spacing = 4 },
	update_in_insert = true,
	underline = true,
	severity_sort = true,
})

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   underline = true,
--   update_in_insert = false,
--   virtual_text = { spacing = 4 },
--   severity_sort = true,
-- })

-- lspconfig.pyright.setup { blabla}
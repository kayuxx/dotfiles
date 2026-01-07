local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	markdown = { "alex" },
	yaml = { "actionlint" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
-- local tailwind_filetypes = { "javascriptreact", "typescriptreact", "html", "css" }

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = lint_augroup,
	callback = function()
		-- if vim.tbl_contains(tailwind_filetypes, vim.bo.filetype) then
		-- 	vim.cmd("TailwindSort")
		-- end
		if vim.bo.filetype == "prisma" then
			vim.cmd("!bunx prisma format")
		end
		lint.try_lint()
	end,
})

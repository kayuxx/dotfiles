local isTextBeforeCursor = function()
	return string.match(vim.fn.getline("."):sub(1, vim.fn.col(".") - 1), "^%s*$")
end

-- more customizable
-- local function isTextBeforeCursor()
-- 	local line = vim.api.nvim_get_current_line()
-- 	local col = vim.api.nvim_win_get_cursor(0)[2]
--
-- 	local before = line:sub(1, col)
-- 	local after = line:sub(col + 1)
--
-- 	-- only whitespace everywhere: "   |   "
-- 	if before:match("^%s*$") and after:match("^%s*$") then
-- 		return true
-- 	end
--
-- 	-- "|word" or "   |word"
-- 	if before:match("^%s*$") and after:match("^%w") then
-- 		return true
-- 	end
--
-- 	-- "word |"
-- 	if before:match("%w%s+$") then
-- 		return true
-- 	end
--
-- 	return false
-- end

return {
	cmdline = {
		enabled = true,
	},
	appearance = { nerd_font_variant = "normal" },
	fuzzy = { implementation = "prefer_rust" },
	sources = { default = { "lsp", "buffer", "path" } },

	keymap = {
		preset = "default",

		["<CR>"] = {
			function()
				local completion_list = require("blink.cmp.completion.list")
				local item = completion_list.get_selected_item()
				if item == nil then
					return false
				end

				vim.schedule(function()
					completion_list.accept({})
				end)

				return true
			end,
			"fallback",
		},
		["<Tab>"] = {
			function()
				local completion_list = require("blink.cmp.completion.list")

				if isTextBeforeCursor() then
					return false
				end

				vim.schedule(function()
					completion_list.select_next()
				end)

				return true
			end,
			"fallback",
		},

		["<S-Tab>"] = {
			function()
				local completion_list = require("blink.cmp.completion.list")

				if isTextBeforeCursor() then
					return false
				end

				vim.schedule(function()
					completion_list.select_prev()
				end)

				return true
			end,
			"fallback",
		},
	},

	completion = {
		documentation = {
			auto_show = false,
			auto_show_delay_ms = 200,
			window = { border = "single" },
		},

		menu = { auto_show = false },
	},
}

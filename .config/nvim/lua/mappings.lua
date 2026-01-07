require("nvchad.mappings")

-- add yours here
local map = vim.keymap.set
local disable_keymap = require("utils").disable_keymap

local opts = { noremap = true, silent = true }

local disabled_keymaps = {
	"<leader>ff",
	"<leader>fa",
	"<leader>fw",
	"<leader>fb",
	"<leader>fh",
	"<leader>fo",
	"<leader>fz",
	"<leader>e>",
	"<leader>b>",
	"<leader>x>",
	"<A-h>",
	"<A-v>",
	"<A-i>",
}

for _, value in ipairs(disabled_keymaps) do
	disable_keymap(value)
end

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fn", function()
	vim.cmd('normal! o<Esc>0"_D')
end, { desc = "Utils insert new line without exit normal mode" })

map("n", "<leader>cc", function()
	vim.cmd("noh")
end, { desc = "Utils delete highlighting" })

map("n", "+", "<C-a>", { desc = "Utils increase number" })

map("n", "-", "<C-x>", { desc = "Utils decrease number" })

map("n", "<leader>to", function()
	vim.cmd("enew")
end, { desc = "Utils New buffer" })

map("n", "<leader>tc", function()
	require("base46").toggle_theme()
end, { desc = "NvChad Toggle Theme" })

map("n", "<leader>tx", function()
	require("nvchad.tabufline").close_buffer()
end, { desc = "NvChad Close buffer" })

map("n", "<leader>tt", function()
	require("base46").toggle_transparency()
end, { desc = "NvChad Toggle transparency" })

map("n", "fl", "<cmd>Oil --float<cr>", { desc = "oil open parent directory" })

map("n", "gl", vim.diagnostic.open_float, { desc = "LSP Show diagnostic" })
map("n", "gn", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "LSP Next diagnostic" })
map("n", "gp", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "LSP Previous diagnostic" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover to display doc" })
map("n", "ra", vim.lsp.buf.rename, { desc = "LSP Rename" })
map("n", "ga", vim.lsp.buf.definition, { desc = "LSP Go to defenition" })
map("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Lsp Display help signature" })

-- lspsaga
-- map("n", "gn", "<cmd>lspsaga diagnostic_jump_next<cr>", { desc = "lspsaga go to next diagnostic" })
--
-- map("n", "gl", "<cmd>lspsaga show_line_diagnostics<cr>", { desc = "lspsaga show in line diagnostic" })
-- map("n", "k", "<cmd>lspsaga hover_doc<cr>", { desc = "lspsaga hover to display doc" })
--
-- map("n", "gd", "<cmd>lspsaga finder<cr>", { desc = "lspsaga find similar defenitions" })
--
-- map("n", "ra", "<cmd>lspsaga rename<cr>", { desc = "lspsaga rename variables, functions, etc" })
--
-- map("n", "ga", "<cmd>lspsaga goto_definition<cr>", { desc = "lspsaga go to defenition" })
--
-- map("n", "gk", "<cmd>lspsaga peek_definition<cr>", { desc = "lspsaga peek defenition" })

-- map("n", "gx", function()
-- 	require("lspsaga.codeaction"):code_action()
-- end, { desc = "lspsaga open code actions" })
--
--

map("n", "ff", "<cmd>Telescope find_files <CR>", { desc = "Telescope Find files" })

map("n", "fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Telescope Find all" })

map("n", "fw", "<cmd>Telescope live_grep <CR>", { desc = "Telescope Live grep" })

map("n", "fb", "<cmd>Telescope buffers <CR>", { desc = "Telescope Find buffers" })

map("n", "fh", "<cmd>Telescope help_tags <CR>", { desc = "Telescope Help page" })

map("n", "fo", "<cmd>Telescope oldfiles <CR>", { desc = "Telescope Find oldfiles" })

map("n", "fz", "<cmd>Telescope current_buffer_fuzzy_find <CR>", { desc = "Telescope Find in current buffer" })

map("n", "<leader>fm", function()
	require("conform").format()
end, { desc = "Conform Format file" })

map("n", "<leader>l", function()
	require("lint").try_lint()
end, { desc = "Lint Lint file" })

-- map("n", "<leader>b", "<cmd>nvimtreetoggle<cr>", { desc = "nvimtree toggle" })

-- vim.g.nvim_tree_auto_open = 1 -- "0 by default, opens the tree when typing `vim $dir` or `vim`

map("n", "<leader>sh", "<cmd>Telescope notify<cr>", { desc = "Telescope notify" })

-- commenting using builtin feature
map("n", "<leader>/", "<cmd>normal gcc<cr>", opts)
map("v", "<leader>/", "<cmd>normal gc<cr>", opts)

-- tmux navigation
map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Tmux Window left" })
map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Tmux Window right" })
map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Tmux Window Down" })
map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Tmux Window up" })

-- re-indent
map("i", "<S-Tab>", "<C-d>", opts)

-- better indenting in visual and normal mode
map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })
map("n", "<", "<<", { desc = "Indent left and reselect" })
map("n", ">", ">>", { desc = "Indent right and reselect" })

-- move lines up and down
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- center screen when jumping
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

map("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

map({ "n", "i", "v" }, "<C-t>", function()
	require("utils").tmux_pane_function({
		pane_direction = "bottom",
		pane_size = 15,
	})
end, { desc = "[P]Terminal on tmux pane" })

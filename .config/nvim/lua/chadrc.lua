---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("highlights")
M.base46 = {
	theme = "yoru",
	theme_toggle = { "rosepine", "palenight" },
	changed_themes = highlights.changed_themes,
	transparency = false,
	hl_override = highlights.override,
	hl_add = highlights.add,
}

M.ui = {
	statusline = {
		separator_style = "default",
		theme = "vscode_colored",
	},

	tabufline = {
		enabled = true,
		lazyload = true,
		modules = {
			-- You can add your custom component
			btns = function()
				return ""
			end,
		},
	},

	cmp = {
		enabled = true,
		style = "atom",
		format_colors = {
			tailwind = true,
		},
	},

	telescope = {
		style = "bordered",
	},
}

M.nvdash = {
	load_on_startup = true,
	--
	-- 	-- header = {
	-- 	-- 	-- "██╗  ██╗ █████╗ ██╗   ██╗██╗   ██╗██╗  ██╗██╗  ██╗",
	-- 	-- 	-- "██║ ██╔╝██╔══██╗╚██╗ ██╔╝██║   ██║╚██╗██╔╝╚██╗██╔╝",
	-- 	-- 	-- "█████╔╝ ███████║ ╚████╔╝ ██║   ██║ ╚███╔╝  ╚███╔╝ ",
	-- 	-- 	-- "██║  ██╗██║  ██║   ██║   ╚██████╔╝██╔╝ ██╗██╔╝ ██╗",
	-- 	-- 	-- "╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝",
	-- 	--  }
	--
	header = {
		-- "                  ▄▄         ▄ ▄▄▄▄▄▄▄                    ",
		"                ▄▀███▄     ▄██ █████▀                     ",
		"                ██▄▀███▄   ███                            ",
		"                ███  ▀███▄ ███                            ",
		"                ███    ▀██ ███                            ",
		"                ███      ▀ ███                            ",
		"                ▀██ █████▄▀█▀▄██████▄                     ",
		-- "                  ▀ ▀▀▀▀▀▀▀ ▀▀▀▀▀▀▀▀▀▀                    ",
		"                                                          ",
		"                  Powered By  eovim                     ",
		-- "                                                          ",
	},
}

M.lsp = {
	semantic_tokens = false, -- should be true but nvchad dosen't really support it in base46
	signature = false,
}

M.mason = {
	cmd = true,
	pkgs = {
		-- lua stuff
		"lua-language-server",
		"stylua",
		-- web dev stuff
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"deno",
		"prettierd",
		"ast-grep",
		"eslint_d",
		"tailwindcss-language-server",
		"astro-language-server",
		-- "prisma-language-server",
		-- md
		"alex",
		--yaml
		"actionlint",
	},
}

return M

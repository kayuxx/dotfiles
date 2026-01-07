-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors
local M = {}

local set_hl_styles = require("utils").set_hl_styles

local styles = {
	enable = {
		italic = false,
		bold = true,
		reverse = true,
		strikethrough = true,
		undercurl = true,
		underline = true,
		standout = true,
	},
	hls = {
		italic = {
			"Comment",
			"@comment",
			"Identifier",
			"Function",
			"Keyword",
			"@keyword",
			"@keyword.function",
		},
		bold = {
			"DiffAdd",
			"DiffChange",
			"DiffDelete",
			"DiffText",
			"WinSeperatror",
			"Folded",
			"MatchParen",
			"NonText",
			"Question",
			"QuickFixLine",
			"Title",
			"WarningMsg",
			"Todo",
			"LspSignatureActiveParameter",
			"LazyProgressDone",
			"LazyProgressTodo",
		},
		reverse = {
			"ErrorMsg",
			-- "PmenuSel",
			"PmenuSbar",
			"PmenuThumb",
			"Search",
			"Visual",
			"VisualNOS",
		},
		undercurl = {
			"SpellBad",
			"SpellCap",
			"SpellLocal",
			"SpellRare",
			"DiagnosticUnderlineError",
			"DiagnosticUnderlineWarn",
			"DiagnosticUnderlineInfo",
			"DiagnosticUnderlineHint",
			"@lsp.type.unresolvedReference",
		},
		underline = {
			"LspReferenceText",
			"LspReferenceRead",
			"LspReferenceWrite",
			"@text.reference",
		},
		standout = {
			"IncSearch",
		},
		strikethrough = {
			"CmpItemAbbrDeprecated",
		},
	},
}

---@type Base46HLGroupsList
M.override = {
	TblineFill = {
		link = "none",
	},
	TbLineBufOn = {
		italic = true,
		bold = true,
	},
	-- used for CmpDoc if tranparency is disabled
	CmpDoc = {
		link = "",
	},
	-- St_CommandMode = { bg = "none" },
	-- St_NormalMode = { bg = "none" },
	-- St_VisualMode = { bg = "none" },
	-- St_InsertMode = { bg = "none" },
}

---@type HLTable
M.add = {
	-- for CmpDoc hl if tranparency is enabled
	CmpDocTransparent = { link = "none" },
	DiagnosticUnderlineError = { undercurl = true, sp = "red" },
	DiagnosticUnderlineWarn = { undercurl = true, sp = "yellow" },
	DiagnosticUnderlineInfo = { undercurl = true, sp = "blue" },
	DiagnosticUnderlineHint = { undercurl = true, sp = "purple" },
	NvimTreeOpenedFolderName = { fg = "green", bold = true },
	SagaBorder = { link = "CmpDocBorder" },
}

-- it should use base46 variables to get colors just like hl_override
local tag_color = true and "#b28500" or "#849900"

M.changed_themes = {
	gruvchad = {
		polish_hl = {

			defaults = {
				Normal = { bg = "#151718" },
			},
		},
	},
	solarized_osaka = {
		polish_hl = {
			statusline = {
				St_CommandMode = { bg = "none", bold = false },
				St_NormalMode = { bg = "none", bold = false },
				St_VisualMode = { bg = "none", bold = false },
				St_InsertMode = { bg = "none", bold = false },
			},
			treesitter = {
				["@tag"] = { fg = tag_color },
				["@tag.builtin"] = { fg = tag_color },
				Tag = { fg = tag_color },
			},
		},
	},
}

M.override = set_hl_styles(styles, M.override)

return M

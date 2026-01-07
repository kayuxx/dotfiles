local M = {}

-- set highlights styles, italic, bold, reverse, etc
M.set_hl_styles = function(styles, override)
	local T = {}
	for style, tbl in pairs(styles.hls) do
		for _, hl in ipairs(tbl) do
			if styles.enable[style] then
				T[hl] = { [style] = true, link = "" }
			end
		end
	end
	return vim.tbl_deep_extend("force", override, T)
end

-- idk why vim.keymap.del didn't work
-- maybe its removing it before nvchad add that map
M.disable_keymap = function(lhs, mode)
	mode = mode and mode or "n"
	vim.keymap.set(mode, lhs, "", { desc = "" })
end

---@class tmux_pane_opts
---@field dir? string|nil -- directory path
---@field auto_cd_to_new_dir? boolean -- variable that controls the auto-cd behavior
---@field fish_ignore_history? boolean -- prevent fish to save history item
---@field pane_direction? "right"|"bottom" -- tmux split window direction
---@field move_key_top? string -- tmux move to top keybind
---@field move_key_left? string -- tmux move to left keybind
---@field pane_size? number -- tmux pane size

-- edited version
-- https://github.com/linkarzu/dotfiles-latest/blob/47510426363bb215e6371cbeeb8b1a175a087a98/neovim/neobean/lua/config/keymaps.lua#l889

---@param u_opts tmux_pane_opts
---toggle tmux pane in the current neovim directory
M.tmux_pane_function = function(u_opts)
	---@type tmux_pane_opts
	local default_opts = {
		dir = nil,
		auto_cd_to_new_dir = true,
		fish_ignore_history = true,
		pane_direction = "right",
		move_key_top = "C-k",
		move_key_left = "C-l",
		pane_size = 60,
	}
	--
	local opts = vim.tbl_deep_extend("force", default_opts, u_opts)
	-- return unless pane_direction is either right or bottom
	if opts.pane_direction ~= "right" and opts.pane_direction ~= "bottom" then
		return
	end

	local move_key = (opts.pane_direction == "right") and opts.move_key_left or opts.move_key_top
	local split_cmd = (opts.pane_direction == "right") and "-h" or "-v"
	-- if no dir is passed, use the current file's directory
	local file_dir = opts.dir or vim.fn.expand("%:p:h")
	-- check if a pane existed
	local has_panes = vim.fn.system("tmux display-message -p '#{window_panes}'"):gsub("%s+", "") ~= "1"
	-- check if the current pane is zoomed (maximized)
	local is_zoomed = vim.fn.system("tmux display-message -p '#{window_zoomed_flag}'"):gsub("%s+", "") == "1"
	-- escape the directory path for shell
	local escaped_dir = file_dir:gsub("'", "'\\''")
	-- if any additional pane exists
	if has_panes then
		if is_zoomed then
			-- compare the stored pane directory with the current file directory
			if opts.auto_cd_to_new_dir and vim.g.tmux_pane_dir ~= escaped_dir then
				local fish_ignore_history_flag = opts.fish_ignore_history and " " or ""
				-- cd into the ne dir and clear
				local navigate_and_clear = string.format("'%scd %s && clear'", fish_ignore_history_flag, escaped_dir)
				local send_keys = string.format("tmux send-keys -t :.+ %s Enter", navigate_and_clear)
				vim.fn.system(send_keys)
				-- update the stored directory to the new one
				vim.g.tmux_pane_dir = escaped_dir
			end
			-- if zoomed, unzoom and switch to the correct pane
			vim.fn.system("tmux resize-pane -Z")
			vim.fn.system("tmux send-keys " .. move_key)
		else
			-- if not zoomed, zoom current pane
			vim.fn.system("tmux resize-pane -Z")
		end
	else
		-- store the initial directory in a neovim variable
		if vim.g.tmux_pane_dir == nil then
			vim.g.tmux_pane_dir = escaped_dir
		end

		local split_window = string.format("tmux split-window %s -l %s -c %s", split_cmd, opts.pane_size, escaped_dir)
		vim.fn.system(split_window)
		vim.fn.system("tmux send-keys " .. move_key)
	end
end

return M

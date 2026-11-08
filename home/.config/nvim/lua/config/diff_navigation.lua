local M = {}
local pending

local function current_view()
	local lib = package.loaded["diffview.lib"]
	return lib and lib.get_current_view()
end

local function normal(keys)
	local ok, err = pcall(vim.cmd.normal, { bang = true, args = { keys } })
	if not ok then
		vim.notify("Diff navigation: " .. tostring(err), vim.log.levels.ERROR)
	end
	return ok
end

local function jump_within_file(direction)
	local before = vim.fn.line(".")
	if not normal(direction > 0 and "]c" or "[c") then
		return true -- Do not interpret a command failure as a file boundary.
	end
	local after = vim.fn.line(".")
	return direction > 0 and after > before or direction < 0 and after < before
end

local function jump_to_boundary_hunk(win, direction)
	vim.api.nvim_win_call(win, function()
		vim.cmd("diffupdate")
		normal(direction > 0 and "gg" or "G")
		local line = vim.fn.line(".")
		if vim.fn.diff_hlID(line, 1) == 0 and vim.fn.diff_filler(line) == 0 then
			normal(direction > 0 and "]c" or "[c")
		elseif direction < 0 then
			while line > 1 and vim.fn.diff_hlID(line - 1, 1) ~= 0 do
				line = line - 1
			end
			vim.api.nvim_win_set_cursor(win, { line, 0 })
		end
	end)
end

local function select_adjacent_file(view, direction)
	local files = view.panel:ordered_file_list()
	if #files < 2 then return end
	local index
	for i, entry in ipairs(files) do
		if entry == view.cur_entry then index = i; break end
	end
	if not index then return end

	local target = files[(index - 1 + direction) % #files + 1]
	local request = { view = view }
	pending = request
	local function on_file_open(_, entry)
		-- Diffview can still restore cursor/scroll positions during this event.
		-- Wait until its handlers finish before positioning the new file.
		vim.schedule(function()
			if pending ~= request then return end
			pending = nil
			if entry ~= target or current_view() ~= view or view.cur_entry ~= target then return end
			local win = view.cur_layout:get_main_win()
			if win and vim.api.nvim_win_is_valid(win.id) then
				jump_to_boundary_hunk(win.id, direction)
			end
		end)
	end
	view.emitter:once("file_open_post", on_file_open)
	-- A failed or cancelled file load must not leave navigation locked forever.
	vim.defer_fn(function()
		if pending == request then
			pending = nil
			view.emitter:off(on_file_open, "file_open_post")
			vim.notify("Diff navigation: file switch did not complete", vim.log.levels.WARN)
		end
	end, 5000)
	view:set_file(target, false, true)
end

-- Return false outside Diffview so Gitsigns can use its own navigation.
function M.jump(direction)
	local view = current_view()
	if not view then return false end
	if pending and pending.view == view then return true end
	if jump_within_file(direction) then return true end

	-- File-history panels have a different entry model; keep native hunk motions.
	local DiffView = require("diffview.scene.views.diff.diff_view").DiffView
	if view:instanceof(DiffView) then
		select_adjacent_file(view, direction)
	end
	return true
end

return M

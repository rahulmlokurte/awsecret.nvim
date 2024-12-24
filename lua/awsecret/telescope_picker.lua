local config = require("awsecret.config")
local secrets_manager = require("awsecret.secrets_manager")
local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local M = {}

local function display_key_value_pairs(json_table)
	local items = {}

	for k, v in pairs(json_table) do
		local value_str = type(v) == "table" and vim.fn.json_encode(v) or tostring(v)
		table.insert(items, k .. ": " .. value_str)
	end

	pickers
		.new({}, {
			prompt_title = "Key-Value Pairs",
			finder = finders.new_table({
				results = items,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")

				map("i", "<CR>", function()
					local selection = action_state.get_selected_entry()
					if selection then
						local selected_item = selection[1]
						vim.notify("Selected: " .. selected_item, vim.log.levels.INFO)
					end
					actions.close(prompt_bufnr)
				end)
				return true
			end,
		})
		:find()
end

M.select_key = function()
	local cached_secrets = secrets_manager.load_secrets()

	if not cached_secrets or vim.tbl_isempty(cached_secrets) then
		vim.notify("No cached secrets found", vim.log.levels.WARN)
		return
	end

	local keys = vim.tbl_keys(cached_secrets)

	pickers
		.new({}, {
			prompt_title = "Select a Key",
			finder = finders.new_table({
				results = keys,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				map("i", "<CR>", function()
					local actions = require("telescope.actions")
					local action_state = require("telescope.actions.state")
					local picker = action_state.get_current_picker(prompt_bufnr)
					if not picker then
						vim.notify("Picker not found or already closed", vim.log.levels.ERROR)
						return
					end
					local selection = action_state.get_selected_entry()
					if selection then
						local key = selection[1]
						local value = cached_secrets[key]

						if type(value) == "string" then
							value = vim.fn.json_decode(value)
						end
						display_key_value_pairs(value)
					end
					-- actions.close(prompt_bufnr)
				end)

				return true
			end,
		})
		:find()
end

return M

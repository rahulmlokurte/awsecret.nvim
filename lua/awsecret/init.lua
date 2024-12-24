local config = require("awsecret.config")
local secret_manager = require("awsecret.secrets_manager")
local telescope_picker = require("awsecret.telescope_picker")

local M = {}

M.setup = function(opts)
	config.setup(opts)
end

M.fetch_and_cache = secret_manager.fetch_and_cache
M.select_secret = telescope_picker.select_key

return M

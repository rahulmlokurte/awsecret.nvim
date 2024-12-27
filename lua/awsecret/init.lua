local config = require("awsecret.config")
local secrets_manager = require("awsecret.secrets_manager")
local telescope_picker = require("awsecret.telescope_picker")

local M = {}

M.setup = function(opts)
  opts = opts or {}
  config.setup(opts)
  vim.api.nvim_create_user_command("AwsecretFetch", function()
    secrets_manager.fetch_and_cache()
  end, {})
  vim.api.nvim_create_user_command("AwsecretSelect", telescope_picker.select_key, {})

  vim.keymap.set("n", "<leader>smf", secrets_manager.fetch_and_cache, {
    desc = "Fetch Secrets From AWS Secret Manager",
    silent = true,
  })

  vim.keymap.set("n", "<leader>sms", telescope_picker.select_key, {
    desc = "Select the Secret Key",
    silent = true,
  })
end

-- M.fetch_and_cache = secret_manager.fetch_and_cache
-- M.select_secret = telescope_picker.select_key

return M

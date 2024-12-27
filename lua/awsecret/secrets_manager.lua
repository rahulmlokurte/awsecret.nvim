local config = require("awsecret.config")

local M = {}

M.get_secret = function(secret_name)
  local cmd = string.format(
    "aws secretsmanager get-secret-value --secret-id %s --query 'SecretString' --output text",
    secret_name
  )
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()

  if result and result ~= "" then
    return vim.fn.json_decode(result)
  else
    vim.notify("Failed to fetch secret: " .. secret_name, vim.log.levels.ERROR)
    return nil
  end
end

M.save_secrets = function(secrets)
  local file = io.open(config.options.cache_path, "w")
  if file then
    file:write(vim.fn.json_encode(secrets))
    file:close()
    vim.notify("Secrets cached to " .. config.options.cache_path, vim.log.levels.INFO)
  else
    vim.notify("Failed to save secrets to cache", vim.log.levels.ERROR)
  end
end

M.load_secrets = function()
  local file = io.open(config.options.cache_path, "r")
  if file then
    local content = file:read("*a")
    file:close()
    if content and content ~= "" then
      return vim.fn.json_decode(content)
    end
  end
  return {}
end

M.fetch_and_cache = function(secret_name)
  if not secret_name or secret_name == "" then
    vim.ui.input({ prompt = "Enter the AWS Secret Name: " }, function(input)
      if input and input ~= "" then
        secret_name = input
        local secret = M.get_secret(secret_name)
        if secret then
          local cached_secrets = M.load_secrets()
          cached_secrets[secret_name] = secret
          M.save_secrets(cached_secrets)
        end
      else
        vim.notify("No secret name provided. Operation Cancelled", vim.log.levels.WARN)
      end
    end)
  else
    local secret = M.get_secret(secret_name)
    if secret then
      local cached_secrets = M.load_secrets()
      cached_secrets[secret_name] = secret
      M.save_secrets(cached_secrets)
    end
  end
end

return M

local M = {}

M.options = {
	cache_path = vim.fn.stdpath("data") .. "/awsecret_cache.json",
}

M.setup = function(opts)
	M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M

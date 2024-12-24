local M = {}

M.options = {
	cache_path = vim.fn.stdpath("data") .. "/awsecret_cache.json",
	floating_window = {
		width = 0.5,
		height = 0.3,
		border = "rounded",
	},
}

M.setup = function(opts)
	M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M

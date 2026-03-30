-- Load all plugin files
local plugins = {}
local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
local glob = vim.fn.glob(plugin_dir .. "/*.lua", false, true)
for _, f in ipairs(glob) do
	local name = vim.fn.fnamemodify(f, ":t:r")
	if name ~= "init" then
		local ok, plugin = pcall(require, "plugins." .. name)
		if ok and plugin then
			table.insert(plugins, plugin)
		end
	end
end
return plugins

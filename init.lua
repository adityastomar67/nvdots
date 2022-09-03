local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
	impatient.enable_profile()
end

for _, source in ipairs({
	-- CORE
	"core.plugins",
	"core.options",
	"core.colorscheme",
	"core.keymaps",
	"core.cmds",
	"core.files",
	"core.abbreviations",

	-- PLUGS
	"plugins.alpha",
	"plugins.toggler",
	"plugins.todo",
	"plugins.cmp",
	"plugins.telescope",
	"plugins.treesitter",
	"plugins.nvim-tree",
	"plugins.null-ls",
	"plugins.gitsigns",
	"plugins.toggleterm",
	"plugins.lspInstaller",
	"plugins.lsp",
	"plugins.lsp-saga",
	"plugins.lua-snip",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
	end
end

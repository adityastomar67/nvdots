local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then impatient.enable_profile() end

for _, source in ipairs({
	-- CORE
	"core.plugins",
	"core.options",
	"core.colorscheme",
	"core.keymaps",
	"core.cmds",
	"core.files",

	-- PLUGS
	"core.alpha",
	"core.toggler",
	"core.todo",
	"core.cmp",
	"core.telescope",
	"core.treesitter",
	"core.nvim-tree",
	"core.null-ls",
	"core.gitsigns",
	"core.toggleterm",
	"core.lspInstaller",
	"core.lsp",
	"core.lsp-saga",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
	end
end

-- EXTRAS / OTHERS
vim.notify = require("notify")
vim.cmd("source $HOME/.abbreviations.vim")

-- NOTE: Needs to be checked
require("notify").setup({
	background_colour = "#000000",
})

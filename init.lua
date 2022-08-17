-- CORE
require "core.plugins"
require "core.options"
require "core.colorscheme"
require "core.keymaps"
require "core.cmds"
require "core.files"

-- PLUGS
require "core.alpha"
require "core.toggler"
require "core.todo"
require "core.cmp"
require "core.telescope"
require "core.treesitter"
require "core.nvim-tree"
require "core.null-ls"
require "core.gitsigns"
require "core.toggleterm"
require "core.lspInstaller"
require "core.lsp"
require "core.lsp-saga"

-- EXTRAS / OTHERS
vim.notify = require("notify")
vim.cmd('source $HOME/.abbreviations.vim')

-- NOTE: Needs to be checked
require("notify").setup({
    background_colour = "#000000",
})

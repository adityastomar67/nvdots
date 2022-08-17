local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({border = "rounded"})
        end
    }
})

-- Install your plugins here
return packer.startup(function(use)
    use("wbthomason/packer.nvim")                                                   -- Have packer manage itself
    use("lewis6991/impatient.nvim")
    use("wfxr/minimap.vim")                                                         -- For VSCode like Minimap
    use("junegunn/limelight.vim")                                                   -- Better focus when other code is dimmed out
    use("stevearc/dressing.nvim")                                                   -- For the sweet sweet UI Components
    use("rebelot/kanagawa.nvim")                                                    -- Colorscheme of choice
    use("nvim-lua/popup.nvim")                                                      -- An implementation of the Popup API from vim in Neovim
    use("nvim-lua/plenary.nvim")                                                    -- Useful lua functions used ny lots of plugins
    use("psliwka/vim-smoothie")                                                     -- For smooth scrolling
    use("kyazdani42/nvim-web-devicons")                                             -- Icons for webdev
    use("kyazdani42/nvim-tree.lua")                                                 -- Tree view for files
    use("hrsh7th/nvim-cmp")                                                         -- The completion plugin
    use("hrsh7th/cmp-buffer")                                                       -- buffer completions
    use("hrsh7th/cmp-path")                                                         -- path completions
    use("hrsh7th/cmp-cmdline")                                                      -- cmdline completions
    use("saadparwaiz1/cmp_luasnip")                                                 -- snippet completions
    use("hrsh7th/cmp-nvim-lsp")                                                     -- lsp completions
    use("hrsh7th/cmp-nvim-lua")                                                     -- lua completions
    use("L3MON4D3/LuaSnip")                                                         -- snippet engine
    use("rafamadriz/friendly-snippets")                                             -- a bunch of snippets to use
    use("notomo/cmp-neosnippet")                                                    -- a bunch of snippets to use
    use("neovim/nvim-lspconfig")                                                    -- enable LSP
    use("williamboman/nvim-lsp-installer")                                          -- simple to use language server installer
    use("jose-elias-alvarez/null-ls.nvim")                                          -- for formatters and linters
    use("p00f/nvim-ts-rainbow")                                                     -- rainbow colors for syntax highlighting
    use("nvim-treesitter/playground")                                               -- playground for treesitter
    use("nvim-telescope/telescope.nvim")                                            -- telescope for quick navigation
    use("nvim-telescope/telescope-media-files.nvim")                                -- telescope for quick navigation
    use("kdheepak/lazygit.nvim")                                                    -- lazygit for git
    use("lewis6991/gitsigns.nvim")                                                  -- gitsigns for git
    use("rcarriga/nvim-notify")                                                     -- notify for notifications
    use("akinsho/toggleterm.nvim")                                                  -- toggleterm for terminal
    use("glepnir/lspsaga.nvim")                                                     -- LSP UIs
    use("kg8m/vim-simple-align")                                                    -- for allignment of text, look on internet for references
    use('RishabhRD/nvim-cheat.sh')                                                  -- For cheatsheets rignt in neovim
    use('RishabhRD/popfix')
    use("nvim-telescope/telescope-file-browser.nvim")
    use("anuvyklack/hydra.nvim")                                                    -- Vim Submodes using Hydra
    use("cometsong/CommentFrame.vim")                                               -- For Fancy CommentFrame
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})                     -- treesitter
    use({'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}) -- Autocomplete engine for tabnine
    use({"zbirenbaum/copilot-cmp", after = {"copilot.lua", "nvim-cmp"}})            -- For Getting Copilot Suggestions in Completion Engine
    use({"goolord/alpha-nvim", requires = "kyazdani42/nvim-web-devicons"})          -- For The Dahboard
    use({"folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim"})           -- Todo Comments

    -- For the awesome Hoping Word Features
    use {
      'phaazon/hop.nvim',
      branch = 'v1', -- optional but strongly recommended
      config = function()
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    }

    -- For Auto-Pairing the Brackets
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- For Copilot Engine in Lua
    use({
        "zbirenbaum/copilot.lua",
        event = {"VimEnter"},
        config = function()
            vim.defer_fn(function() require("copilot").setup() end, 100)
        end
    })
    -- use "github/copilot.vim" -- Its a dependency if you're setting up copilot for the first time

    -- For Hovering the information eg: Diagnostics
    use({
        "lewis6991/hover.nvim",
        config = function()
            require("hover").setup({
                init = function()
                    require("hover.providers.lsp")
                    require("hover.providers.gh")
                    -- require('hover.providers.man')
                    -- require('hover.providers.dictionary')
                end,
                preview_opts = {border = nil},
                title = true
            })
            vim.keymap.set("n", "K", require("hover").hover,
                           {desc = "hover.nvim"})
            vim.keymap.set("n", "gK", require("hover").hover_select,
                           {desc = "hover.nvim (select)"})
        end
    })

    -- For Provind the Comments Functionality
    use({
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup({line_mapping = "<leader>gcc"})
        end
    })

    -- More Colors
    use({
    'norcalli/nvim-colorizer.lua',
    config =function ()
        require("colorizer").setup()
    end
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then require("packer").sync() end
end)

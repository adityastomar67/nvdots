local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local M = {}

local dropdown_theme = require('telescope.themes').get_dropdown({
    results_height = 20,
    width = 0.6,
    prompt_title = '',
    prompt_prefix = 'Files> ',
    previewer = false,
    borderchars = {
        { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    },
})

-- searches files on ~/.config
M.xdg_config = function()
    require("telescope.builtin").find_files({
        prompt_title = "XDG-CONFIG",
        find_command = { 'fd', '--no-ignore-vcs' },
        sorting_strategy = "ascending",
        file_ignore_patterns = { "lua-language-server", "chromium" },
        cwd = "~/.dotfiles",
        layout_config = {  width = 0.7 , height = 0.3 },
        results_height = 20,
        hidden = true,
        previewer = false,
        borderchars = {
            { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
            preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        },
    })
end

-- searches opened buffers
M.buffers = function()
    require("telescope.builtin").buffers({
        prompt_title = "BUFFERS",
        sorting_strategy = "ascending",
        file_ignore_patterns = { "lua-language-server", "chromium" },
        previewer = false,
        layout_config = { height = 0.3 },
        layout_config = { width = 0.5 },
        hidden = true,
    })
end

M.nvim_files = function()
    require("telescope.builtin").find_files({
        prompt_title = "NVIM FILES",
        previewer = false,
        find_command = { 'fd', '--no-ignore-vcs' },
        sorting_strategy = "ascending",
        file_ignore_patterns = { ".git" },
        cwd = "~/.config/nvim",
        hidden = true,
    })
end

-- searches on ~/.dotfiles
M.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = "DOTFILES",
        find_command = { 'fd', '--no-ignore-vcs' },
        shorten_path = true,
        sorting_strategy = "ascending",
        cwd = vim.env.DOTFILES,
        hidden = true,
        previewer = false,
        layout_config = { height = 0.3 },
        layout_config = { width = 0.5 },
    })
end

-- searches on ~/.dotfiles
M.search_oldfiles = function()
    require("telescope.builtin").oldfiles({
        prompt_title = "OLDFILES",
        previewer = false,
        shorten_path = true,
        sorting_strategy = "ascending",
        -- cwd = vim.env.DOTFILES,
        hidden = true,
        layout_config = { height = 0.3 },
        layout_config = { width = 0.5 },
    })
end

-- searches on ~/.dotfiles
M.grep_dotfiles = function()
    require("telescope.builtin").live_grep({
        prompt_title = "GREP DOTFILES",
        shorten_path = true,
        sorting_strategy = "ascending",
        cwd = vim.env.DOTFILES,
        hidden = true,
    })
end

M.grep_wiki = function()
    local opts = {}
    opts.hidden = true
    opts.search_dirs = {
        "~/.dotfiles/wiki",
    }
    opts.prompt_prefix = ">"
    opts.prompt_title = "Grep Wiki"
    opts.path_display = { "smart" }
    require("telescope.builtin").live_grep(opts)
end

return M

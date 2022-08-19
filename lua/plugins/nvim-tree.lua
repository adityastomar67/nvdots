local winsize = require("core.utils").winsize
local mode = require("core.consts").modes
local map = require("core.utils").map
local nvim_tree_events = require("nvim-tree.events")

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then return end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then return end

local tree_cb = nvim_tree_config.nvim_tree_callback

local DEFAULT_WIDTH = 30

local function inc_width()
    local width, _height = winsize()
    local new_width = width + 10
    vim.cmd(string.format("NvimTreeResize %d", new_width))
end

local function dec_width()
    local width, _height = winsize()
    local new_width = width - 10
    if new_width < DEFAULT_WIDTH then return end
    vim.cmd(string.format("NvimTreeResize %d", new_width))
end

nvim_tree.setup({
    auto_reload_on_write = true,
    renderer = {
        highlight_opened_files = "name",
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "U",
                    ignored = "◌"
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = ""
                }
            }
        }
    },
    update_cwd = true,
    update_focused_file = {enable = true, update_cwd = true, ignore_list = {}},
    git = {enable = true, ignore = true, timeout = 500},
    filters = {custom = {".git"}},
    sort_by = "name",
    view = {
        adaptive_size = true,
        centralize_selection = true,
        width = DEFAULT_WIDTH,
        side = "left",
        mappings = {
            custom_only = false,
            list = {
                {key = {"l"    , "<CR>", "o"}                   , cb = tree_cb("edit")} ,
                {key = "h"     , cb = tree_cb("close_node")}    ,
                {key = "<C-v>" , action = "vsplit"}             ,
                {key = "<C-x>" , action = "split"}              ,
                {key = "a"     , action = "create"}             ,
                {key = "d"     , action = "remove"}             ,
                {key = "r"     , action = "rename"}             ,
                {key = "y"     , action = "copy_name"}          ,
                {key = "Y"     , action = "copy_path"}          ,
                {key = "gy"    , action = "copy_absolute_path"} ,
                {key = "q"     , action = "close"}              ,
                {key = "W"     , action = "collapse_all"}       ,
                {key = "S"     , action = "search_node"}        ,
                {key = "<C-k>" , action = "toggle_file_info"}   ,
                {key = ">"     , action = "more_wide"           , action_cb = inc_width} ,
                {key = "<"     , action = "less_wide"           , action_cb = dec_width}
            }
        }
    }
})

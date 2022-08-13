local status_ok, alpha = pcall(require, "alpha")
if not status_ok then return end

local status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
if not status_ok then return end

math.randomseed(os.time())
local function pick_color()
    local colors = {"String", "Identifier", "Keyword", "Number"}
    return colors[math.random(#colors)]
end
local function footer()
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info =
        "   v" .. version.major .. "." .. version.minor .. "." ..
            version.patch
    return datetime .. "   " .. total_plugins .. " plugins" ..
               nvim_version_info
end
local logo = {
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "              ███████████             ",
    "            ████▒▒▒▒▒▒▒████          ",
    "          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██          ",
    "        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██      ",
    "      ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██     ",
    "      ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓▒▒██    ",
    "      ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓▒▒██    ",
    "    ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ▒▒██    ",
    "    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ",
    "    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ",
    "    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ",
    "    ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    ",
    "    ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒▒▒██    ",
    "    ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██    ",
    "    ██      ██      ████      ████    ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      ",
    "                                      "
}
dashboard.section.header.val = logo
dashboard.section.header.opts.hl = pick_color()
dashboard.section.buttons.val = {
    dashboard.button("Ctrl+E", "  File Explorer"),
    dashboard.button("<LDR>fo", "  Find File"),
    dashboard.button("<LDR>lg", "  Git Terminal"),
    dashboard.button("<LDR>ps", "  Update plugins"),
    dashboard.button("Q", "  Quit", ":q!<CR>")
}
-- dashboard.section.footer.val = footer()
-- dashboard.section.footer.opts.hl = "Constant"
alpha.setup(dashboard.opts)
vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])

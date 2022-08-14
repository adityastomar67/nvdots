-- AutoCommands
-- nvim_create_augroup      — Create or get an augroup.
-- nvim_create_autocmd      — Create an autocmd.
-- nvim_del_augroup_by_id   — Delete an augroup by id.
-- nvim_del_augroup_by_name — Delete an augroup by name.
-- nvim_del_autocmd         — Delete an autocmd by id.
-- nvim_do_autocmd          — Do one autocmd.
-- nvim_get_autocmds        — Get autocmds that match the requirements.

local api   = vim.api
local opt   = vim.opt                     -- global
local g     = vim.g                       -- global for let options
local wo    = vim.wo                      -- window local
local bo    = vim.bo                      -- buffer local
local fn    = vim.fn                      -- access vim functions
local cmd   = vim.cmd                     -- vim commands
local map   = require("core.utils").map   -- import map helper
local alias = require("core.utils").alias -- import alias creator

-- Go to definition
function def()
  vim.lsp.buf.definition()
end
alias("def", "Def")

-- Toggles NERDTree.
function nt_find()
  vim.api.nvim_command("NvimTreeFindFile")
end
alias("nt_find", "F")

function diagnose()
  vim.api.nvim_command("TroubleToggle")
end
alias("diagnose", "Di")

-- Sources init.lua.
function source()
  vim.api.nvim_command("source $MYVIMRC")
end
alias("source", "Source")

-- Cuts current line and appends text without leading whitespace to the line above.
function line_up()
  local seq = vim.api.nvim_replace_termcodes(
    "^dg_k$A <Esc>pjdd",
    true,
    false,
    true
  )
  vim.api.nvim_feedkeys(seq, "n", false)
end
alias("line_up", "LU")

-- Shows the filetype.
function ft()
  vim.cmd("set filetype?")
end

-- Copies the relative file path of file in current buffer to system clipboard.
function cc_rfp()
  local full_path = vim.api.nvim_buf_get_name(0)
  local cwd = vim.fn.getcwd()
  local rfp = vim.split(full_path, string.format("%s/", cwd))[2]
  local cmd = string.format("printf %s | pbcopy", rfp)
  os.execute(cmd)
  print(rfp)
end
alias("cc_rfp", "CCP")

-- Pretty prints a Lua table.
function inspect(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

-- Collapses visually selected lines into single line separated by "sep".
function collapse(sep)
  local start_ln = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
  local end_ln = vim.api.nvim_buf_get_mark(0, ">")[1]
  local lines = vim.api.nvim_buf_get_lines(0, start_ln, end_ln, true)

  local result = ""

  lines[1] = string.gsub(lines[1], "[ \t]+%f[\r\n%z]", "")

  for i=2, #lines do
    lines[i], _ = string.gsub(lines[i], "^%s*(.-)%s*$", "%1")
  end

  if sep then
    for i=1,#lines-1 do
      result = result .. lines[i]
      result = result .. sep
    end

    result = result .. lines[#lines]
  else
    for i=1,#lines do
      result = result .. lines[i]
    end
  end
  vim.api.nvim_buf_set_lines(0, start_ln, end_ln, true, { result })

  local curr_row = vim.api.nvim_win_get_cursor(0)[1]
  local curr_ln_len = #vim.api.nvim_get_current_line()
  vim.api.nvim_win_set_cursor(0, { curr_row, curr_ln_len })
end

function show_virtual_diagnostics()
  vim.diagnostic.config({ virtual_lines = true })
end

function hide_virtual_diagnostics()
  vim.diagnostic.config({ virtual_lines = false })
end

function toggle_style()
  if vim.g.tokyonight_style == "night" then
    vim.g.tokyonight_style = "day"
  elseif vim.g.tokyonight_style == "day" then
    vim.g.tokyonight_style = "night"
  end

  vim.cmd("colorscheme tokyonight")
end

function send_visual_selection_to_terminal()
  vim.cmd("ToggleTermSendVisualSelection")
  vim.cmd("ToggleTerm")
end

-- Horizontal terminal
function hterm()
  height = math.floor(vim.api.nvim_win_get_height(0) * 0.3)
  cmd = string.format("ToggleTerm direction=horizontal size=%d", height)
  vim.api.nvim_command(cmd)
end
alias("hterm", "HTerm")


function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command("augroup END")
    end
end

vim.api.nvim_create_autocmd({"VimEnter"}, {pattern = "*", command = "Limelight"})
-- vim.cmd([[autocmd InsertEnter * norm zz]]) -- Vertically center document when entering insert mode
vim.cmd([[command! Realtime set autoread | au CursorHold * checktime | call feedkeys("lh")]]) -- Automatic update of any Buffer when not in use
vim.cmd([[command! Cls lua require("core.utils").preserve('%s/\\s\\+$//ge')]])
vim.cmd([[command! Reindent lua require('core.utils').preserve("sil keepj normal! gg=G")]])
vim.cmd([[command! BufOnly lua require('core.utils').preserve("silent! %bd|e#|bd#")]])
vim.cmd([[command! CloneBuffer new | 0put =getbufline('#',1,'$')]])
vim.cmd([[command! Mappings drop ~/.config/nvim/lua/core/keymaps.lua]])
vim.cmd([[command! Scratch new | setlocal bt=nofile bh=wipe nobl noswapfile nu]])
vim.cmd([[command! Blockwise lua require('core.utils').blockwise_clipboard()]])
vim.cmd([[command! SaveAsRoot w !doas tee %]])
vim.cmd([[command! ReloadConfig lua require("utils").ReloadConfig()]])
vim.cmd([[syntax sync minlines=64]]) -- faster syntax hl
vim.cmd([[cmap w!! w !doas tee % >/dev/null]]) -- save as root, in my case I use the command 'doas'
vim.cmd([[set iskeyword+=-]])
-- vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]])
-- vim.cmd("hi normal guibg=NONE ctermbg=NONE")
-- vim.cmd([[command! -bar -nargs=1 Grep silent grep <q-args> | redraw! | cw]])
-- vim.cmd([[hi ActiveWindow ctermbg=16 | hi InactiveWindow ctermbg=233]])
-- vim.cmd([[set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow]])

-- Turn Syntax off for non-code files
vim.api.nvim_create_autocmd("BufEnter", {
    group = syntax_group,
    pattern = "*",
    callback = function()
      if vim.api.nvim_buf_line_count(0) > 10000 then
        vim.cmd [[ syntax off ]]
      end
    end
})

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
})

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
    "BufReadPost",
    { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- windows to close with "q"
api.nvim_create_autocmd(
    "FileType",
    { pattern = { "help", "startuptime", "qf", "lspinfo" }, command = [[nnoremap <buffer><silent> q :close<CR>]] }
)
api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

-- show cursor line only in active window
-- local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
-- api.nvim_create_autocmd(
--   { "InsertLeave", "WinEnter" },
--   { pattern = "*", command = "set cursorline", group = cursorGrp }
-- )
-- api.nvim_create_autocmd(
--   { "InsertEnter", "WinLeave" },
--   { pattern = "*", command = "set nocursorline", group = cursorGrp }
-- )

local function code_keymap()
    if vim.fn.has("nvim-0.7") then
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                vim.schedule(CodeRunner)
            end,
        })
    else
        vim.cmd("autocmd FileType * lua CodeRunner()")
    end

    function CodeRunner()
        local bufnr = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
        local fname = vim.fn.expand("%:p:t")
        local keymap_c = {}

        if ft == "python" then
            keymap_c = {
                name = "Code",
                r = { "<cmd>update<CR><cmd>exec '!python3' shellescape(@%, 1)<cr>", "Run" },
                m = { "<cmd>TermExec cmd='nodemon -e py %'<cr>", "Monitor" },
            }
        elseif ft == "lua" then
            keymap_c = {
                name = "Code",
                r = { "<cmd>luafile %<cr>", "Run" },
            }
        elseif ft == "rust" then
            keymap_c = {
                name = "Code",
                r = { "<cmd>Cargo run<cr>", "Run" },
                D = { "<cmd>RustDebuggables<cr>", "Debuggables" },
                h = { "<cmd>RustHoverActions<cr>", "Hover Actions" },
                R = { "<cmd>RustRunnables<cr>", "Runnables" },
            }
        elseif ft == "go" then
            keymap_c = {
                name = "Code",
                r = { "<cmd>GoRun<cr>", "Run" },
            }
        elseif ft == "typescript" or ft == "typescriptreact" or ft == "javascript" or ft == "javascriptreact" then
            keymap_c = {
                name = "Code",
                o = { "<cmd>TSLspOrganize<cr>", "Organize" },
                r = { "<cmd>TSLspRenameFile<cr>", "Rename File" },
                i = { "<cmd>TSLspImportAll<cr>", "Import All" },
                R = { "<cmd>lua require('config.test').javascript_runner()<cr>", "Choose Test Runner" },
                s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" },
                t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" },
            }
        end

        if fname == "package.json" then
            keymap_c.v = { "<cmd>lua require('package-info').show()<cr>", "Show Version" }
            keymap_c.c = { "<cmd>lua require('package-info').change_version()<cr>", "Change Version" }
            keymap_c.s = { "<cmd>2TermExec cmd='yarn start'<cr>", "Yarn Start" }
            keymap_c.t = { "<cmd>2TermExec cmd='yarn test'<cr>", "Yarn Test" }
        end

        -- if next(keymap_c) ~= nil then
        -- 	whichkey.register(
        -- 		{ c = keymap_c },
        -- 		{ mode = "n", silent = true, noremap = true, buffer = bufnr, prefix = "<leader>" }
        -- 	)
        -- end
    end
end

local autocmds = {
    reload_vimrc = {
        -- {"BufWritePost",[[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]]};
        { "BufWritePre", "$MYVIMRC", "lua require('core.utils').ReloadConfig()" },
    },
    dsa = {
        { "BufWritePre", "practice.cpp", [[!g++ -std=c++20 % && ./a.out && rm -f a.out]] },
    },
    clear_cmdline = {
        { "CmdlineLeave", "*", "echo ''" },
    },
    conceal_quotations = {
        { "BufEnter", "*", 'syntax match singlequotes "\'" conceal' },
        { "BufEnter", "*", "syntax match singlequotes '\"' conceal" },
    },
    general_settings = {
        { "Filetype", "qf,help,man,lspinfo", ":nnoremap <silent> <buffer> q :close<CR>" },
        { "Filetype", "qf", ":set nobuflisted" },
    },
    autoquickfix = {
        { "QuickFixCmdPost", "[^l]*", "cwindow" },
        { "QuickFixCmdPost", "l*", "lwindow" },
    },
    fix_commentstring = {
        { "Bufenter", "*config,*rc,*conf", "set commentstring=#%s" },
        { "Bufenter", "*config,*conf,sxhkdrc,bspwmrc", "set syntax=config" },
    },
    reload_sxhkd_bindings = {
        { "BufWritePost", "*sxhkdrc", "silent! !pkill -USR1 -x sxhkd" },
        { 'BufWritePost', '*bspwmrc', [[silent! !bspc wm -r]] },
    },
    make_scripts_executable = {
        { "BufWritePost", "*.sh,*.py,*.zsh", [[silent !chmod +x %]] },
    },
    live_reload_webDev = {
        { "BufWritePost", "index.html,*.css", [[silent! !~/.scripts/refresh]] },
    },
    custom_updates = {
        { "BufWritePost", "~/.Xresources", "!xrdb -merge ~/.Xresources" },
        { "BufWritePost", "~/.Xdefaults", "!xrdb -merge ~/.Xdefaults" },
        { "BufWritePost", "fonts.conf", "!fc-cache" },
    },
    format_options = { -- :h fo-talbe (for help)
        { "BufWinEnter,BufRead,BufNewFile", "*", "setlocal formatoptions-=r formatoptions-=o" },
    },
    change_header = {
        { "BufWinLeave", "*", "lua require('core.utils').changeheader()" },
    },
    resize_windows_proportionally = {
        { "VimResized", "*", ":wincmd =" },
        { "Filetype", "help", ":wincmd =" },
    },
    packer = {
        { "BufWritePost", "plugins.lua", "source <afile> | PackerSync" },
    },
    terminal_job = {
        { "TermOpen", "*", [[tnoremap <buffer> <Esc> <c-\><c-n>]] },
        { "TermOpen", "*", [[tnoremap <buffer> <leader>x <c-\><c-n>:bd!<cr>]] },
        { "TermOpen", "*", [[tnoremap <expr> <A-r> '<c-\><c-n>"'.nr2char(getchar()).'pi' ]] },
        { "TermOpen", "*", "startinsert" },
        { "TermOpen", "*", [[nnoremap <buffer> <C-c> i<C-c>]] },
        { "TermOpen", "*", "setlocal listchars= nonumber norelativenumber" },
        { "TermOpen", "*", [[lua vim.opt_local.buflisted = false]] },
    },
    restore_cursor = {
        { "BufRead", "*", [[call setpos(".", getpos("'\""))]] },
    },
    save_shada = {
        { "VimLeave", "*", "wshada!" },
        { "CursorHold", "*", [[rshada|wshada]] },
    },
    wins = {
        -- { "VimResized", "*", ":wincmd =" },
        -- { "WinEnter", "*", "wincmd =" },
        { "BufEnter", "NvimTree", [[setlocal cursorline]] },
    },
    toggle_search_highlighting = {
        { "InsertEnter,InsertLeave", "*", [[set cul!]] },
        { "InsertEnter", "*", "setlocal nohlsearch" },
        { "InsertEnter", "*", [[call clearmatches()]] },
        { "InsertLeave", "*", [[highlight RedundantSpaces ctermbg=red guibg=red]] },
        { "InsertLeave", "*", [[match RedundantSpaces /\s\+$/]] },
    },
    lua_highlight = {
        { "TextYankPost", "*", [[silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=600}]] },
    },
    clean_trailing_spaces = {
        { "BufWritePre", "*", [[lua require("core.utils").preserve('%s/\\s\\+$//ge')]] },
    },
    -- autoskel = {
    -- {"BufNewFile", "*.lua,*.sh", 'lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i_skel<CR>",true,false,true),"m",true)' },
    -- },
    -- wrap_spell = {
    --     { "FileType", "markdown", ":setlocal wrap" },
    --     { "FileType", "markdown", ":setlocal spell" },
    -- },
    -- hicurrent_word = {
    --     { "CursorHold", "*", [[:exec 'match Search /\V\<' . expand('<cword>') . '\>/']] },
    -- },
    -- auto_exit_insertmode = {
    --     { "CursorHoldI", "*", "stopinsert" },
    -- },
    -- auto_working_directory = {
    --     { "BufEnter", "*", "silent! lcd %:p:h" },
    -- },
    -- ansi_esc_log = {
    --     { "BufEnter", "*.log", ":AnsiEsc" };
    -- };
    -- AutoRecoverSwapFile = {
    --     { "SwapExists", "*", [[let v:swapchoice = 'r' | let b:swapname = v:swapname]] },
    --     { "BufWinEnter", "*", [[if exists("b:swapname") | call delete(b:swapname) | endif]] },
    -- },
    -- flash_cursor_line = {
    --     { "WinEnter", "*", "lua require('core.utils').flash_cursorline()" },
    --     -- { "WinEnter", "*", "Beacon" },
    --     -- https://stackoverflow.com/a/42118416/2571881  - https://st.suckless.org/patches/blinking_cursor/
    --     { "VimLeave", "*", "lua vim.opt.guicursor='a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,n-v:hor20'"},
    -- },
    -- attatch_colorizer = {
    -- 	-- {BufReadPost *.conf setl ft=conf};
    -- 	{"BufReadPost", "config", "setl ft=conf"};
    -- 	{"FileType", "conf", "ColorizerAttachToBuffer<CR>"};
    -- };
}
nvim_create_augroups(autocmds)
-- autocommands END

local augroups = {}
augroups.buf_write_pre = {
    mkdir_before_saving = {
        event = { "BufWritePre", "FileWritePre" },
        pattern = "*",
        -- TODO: Replace vimscript function
        command = [[ silent! call mkdir(expand("<afile>:p:h"), "p") ]],
    },
    trim_extra_spaces_and_newlines = {
        event = "BufWritePre",
        pattern = "*",
        -- TODO: Replace vimscript function
        command = require("core.utils").preserve("%s/\\s\\+$//ge"),
    },
}

augroups.misc = {
    highlight_yank = {
        event = "TextYankPost",
        pattern = "*",
        callback = function()
            vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400, on_visual = true })
        end,
    },
    -- trigger_nvim_lint = {
    -- 	event = {"BufEnter", "BufNew", "InsertLeave", "TextChanged"},
    -- 	pattern = "<buffer>",
    -- 	callback = function ()
    -- 		require("lint").try_lint()
    -- 	end,
    -- },
    unlist_terminal = {
        event = "TermOpen",
        pattern = "*",
        callback = function()
            vim.opt_local.buflisted = false
            vim.opt.listchars = ""
            vim.cmd("startinsert")
        end,
    },
}

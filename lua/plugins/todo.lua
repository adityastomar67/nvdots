local status_ok, todo = pcall(require, "todo-comments")
if not status_ok then return end

todo.setup {
    signs = true,
    sign_priority = 8,
    keywords = {
        FIX = {
            icon = " ",
            color = "#C34043",
            alt = {"FIXME", "BUG", "FIXIT", "ISSUE"}
            -- signs = false, -- configure signs for some keywords individually
        },
        TODO = {icon = "✖", color = "info"},
        DONE = {icon = " ", color = "done"},
        HACK = {icon = " ", color = "warning"},
        WARN = {icon = " ", color = "error", alt = {"WARNING", "XXX"}},
        PERF = {icon = " ", alt = {"OPTIM", "PERFORMANCE", "OPTIMIZE"}},
        NOTE = {icon = " ", color = "hint", alt = {"INFO"}}
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    highlight = {
        before = "", -- "fg" or "bg" or empty
        keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
        after = "fg", -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true, -- uses treesitter to match keywords in comments only
        max_line_len = 400, -- ignore lines longer than this
        exclude = {} -- list of file types to exclude highlighting
    },
    colors = {
        error = {"DiagnosticError", "ErrorMsg", "#DC2626"},
        warning = {"DiagnosticWarning", "WarningMsg", "#FBBF24"},
        info = {"DiagnosticInfo", "#7FB4CA"},
        done = {"DiagnosticDone", "#00A600"},
        hint = {"DiagnosticHint", "#10B981"},
        default = {"Identifier", "#C34043"}
    },
    search = {
        command = "rg",
        args = {
            "--color=never", "--no-heading", "--with-filename", "--line-number",
            "--column"
        },
        pattern = [[\b(KEYWORDS):]] -- ripgrep regex
    }
}

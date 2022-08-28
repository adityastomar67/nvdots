require("kanagawa").setup({
	undercurl            = true,              -- undercurl is enabled by default
	specialReturn        = true,              -- special highlight for the return keyword
	specialKeyword       = true,              -- special highlight for the keyword "return"
	specialException     = true,              -- special highlight for exception handling keywords
	dimInactive          = false,             -- dim inactive window `:h hl-NormalNC`
	globalStatus         = false,             -- adjust window separators highlight for laststatus = 3
	commentStyle         = { italic = true }, -- Italicize comments
	functionStyle        = { italic = true }, -- Italicize functions
	keywordStyle         = { italic = true }, -- Italic Keywords
	statementStyle       = { bold   = true }, -- Bold is the default for statements.
	typeStyle            = { italic = true }, -- Italic is used for type names.
	variablebuiltinStyle = { italic = true }, -- Italic for builtin variables
	colors               = {},
	overrides            = {},
})

local colorscheme = "kanagawa"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " not found!")
	return
end

vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

-- Split color modification
vim.cmd("highlight VertSplit guibg=#ff000000")

-- Data for limelight_conceal
vim.cmd("let g:limelight_conceal_ctermfg = 'gray'")
vim.cmd("let g:limelight_conceal_ctermfg = 240")
vim.cmd("let g:limelight_conceal_guifg = 'DarkGray'")
vim.cmd("let g:limelight_conceal_guifg = '#777777'")
vim.cmd("let g:limelight_default_coefficient = 0.9")

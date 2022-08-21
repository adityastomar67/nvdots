-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"

local opts = {noremap = true, silent = true}
local term_opts = {silent = true}
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Show/Unshow Relative line Numbers
keymap("n", "<leader>z", ":set invrnu invnu<CR>", opts)

-- Increment/decrement
keymap('n', '+', '<C-a>',opts)
keymap('n', '-', '<C-x>',opts)

-- Delete a word backwards
keymap('n', 'db', 'vb"_d', opts)

-- LazyGit Inside the Terminal
keymap("n", "<leader>lg", ":LazyGit<CR>", opts)

-- Pawning the Terminal
keymap("n" , "<leader>tt" , ':TermExec size=30 direction=float cmd="clear"<CR>' , opts)
keymap("n" , "<leader>th" , ':TermExec size=8 direction=horizontal cmd="clear"<CR>'   , opts)

-- Shell file Runner
keymap("n", "<leader>sh", ":!chmod +x % && source %<CR>", opts)

-- Source init.lua
keymap("n", "<leader>so", ":so %<CR>", opts)

-- Remove the Highlighting from the search
keymap("n", "<CR>", ":noh<CR><CR>", opts)

-- Better Redo Option
keymap("n", "U", "<C-r>", opts)

-- Better Hoping then numerous keystrokes
keymap("n" , "f"     , ":HopWord<CR>"      , opts)
keymap("n" , "F"     , ":HopLine<CR>"      , opts)
keymap("i" , "<C-F>" , "<ESC>:HopLine<CR>" , opts)

-- Telescope Stuff
keymap("n" , "<C-o>"      , ":Telescope find_files<CR>" , opts)
keymap("n" , "<leader>fg" , ":Telescope live_grep<CR>"  , opts)
keymap("n" , "<leader>fb" , ":Telescope buffers<CR>"    , opts)
keymap("n" , "<leader>ft" , ":Telescope tags<CR>"       , opts)

-- For not yanking when deleting chars
keymap('n', 'x', '"_x', opts)

-- For Running the current buffer
keymap("n" , "<leader>pr" , ':TermExec cmd="clear && prog %"<CR>'      , opts)
keymap("i" , "<leader>pr" , '<ESC>:TermExec cmd="clear && prog %"<CR>' , opts)

-- For Easier Splitting of buffer
keymap("n", "<leader>|", "<C-w>v", opts)
keymap("n", "<leader>_", "<C-w>s", opts)

-- Yank all content
keymap("n" , "<leader>y" , "ggVGy" , opts)
keymap("n" , "Y"         , "y$"    , opts)

-- Writing & exiting
keymap("n" , "Q"     , ":q!<CR>"     , opts)
keymap("n" , "<C-c>" , ":bw<CR>"     , opts)
keymap("n" , "<C-s>" , ":w<CR>"      , opts)
keymap("n" , "qo"    , ":on<CR>"     , opts)
keymap("i" , "<C-s>" , "<ESC>:w<CR>" , opts)
keymap("v" , "q"     , "<ESC>"       , opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n" , "<C-Up>"    , ":resize +2<CR>"          , opts)
keymap("n" , "<C-Down>"  , ":resize -2<CR>"          , opts)
keymap("n" , "<C-Left>"  , ":vertical resize -2<CR>" , opts)
keymap("n" , "<C-Right>" , ":vertical resize +2<CR>" , opts)

-- Navigate buffers
keymap("n" , "<S-l>" , ":bnext<CR>"     , opts)
keymap("n" , "<S-h>" , ":bprevious<CR>" , opts)

-- Braces pairing
keymap("i" , "<>" , "<><Left>" , opts)
keymap("i" , "{}" , "{}<Left>" , opts)
keymap("i" , "()" , "()<Left>" , opts)
keymap("i" , "[]" , "[]<Left>" , opts)
keymap("i" , '""' , '""<Left>' , opts)
keymap("i" , "''" , "''<Left>" , opts)
keymap("i" , "``" , "``<Left>" , opts)

-- Press qq fast to enter Normal Mode
keymap("i", "qq", "<ESC>", opts)
keymap("v", "qq", "<ESC>", opts)
keymap("x", "qq", "<ESC>", opts)

-- Getting Rid Of Bad Habbits
keymap("n" , "<Up>"    , "<Nop>" , opts)
keymap("i" , "<Up>"    , "<Nop>" , opts)
keymap("x" , "<Up>"    , "<Nop>" , opts)
keymap("v" , "<Up>"    , "<Nop>" , opts)
keymap("n" , "<Down>"  , "<Nop>" , opts)
keymap("i" , "<Down>"  , "<Nop>" , opts)
keymap("x" , "<Down>"  , "<Nop>" , opts)
keymap("v" , "<Down>"  , "<Nop>" , opts)
keymap("n" , "<Left>"  , "<Nop>" , opts)
keymap("i" , "<Left>"  , "<Nop>" , opts)
keymap("x" , "<Left>"  , "<Nop>" , opts)
keymap("v" , "<Left>"  , "<Nop>" , opts)
keymap("n" , "<Right>" , "<Nop>" , opts)
keymap("i" , "<Right>" , "<Nop>" , opts)
keymap("x" , "<Right>" , "<Nop>" , opts)
keymap("v" , "<Right>" , "<Nop>" , opts)

-- Better Navigation in insert mode
keymap("i" , "<C-h>" , "<Left>"  , opts)
keymap("i" , "<C-l>" , "<Right>" , opts)
keymap("i" , "<C-j>" , "<Down>"  , opts)
keymap("i" , "<C-k>" , "<Up>"    , opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v" , "<A-j>" , ":m .+1<CR>==" , opts)
keymap("v" , "<A-k>" , ":m .-2<CR>==" , opts)
keymap("v" , "p"     , '"_dP'         , opts)

-- Move text up and down
keymap("x" , "J"     , ":move '>+1<CR>gv-gv" , opts)
keymap("x" , "K"     , ":move '<-2<CR>gv-gv" , opts)
keymap("x" , "<A-k>" , ":move '<-2<CR>gv-gv" , opts)
keymap("x" , "<A-j>" , ":move '>+1<CR>gv-gv" , opts)

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- File Tree Pawn
keymap("n", "<C-e>", ":NvimTreeToggle<cr>", opts)

-- Syncing The Plugins
keymap("n", "<leader>ps", ":PackerSync<CR>", opts)

-- For Alligning of Text Easliy
keymap("v", "sa", ":SimpleAlign ", opts) -- For Alligning items, need to put any character whose respect to which it Align

-- For editing files
keymap("n", "<leader>1", ":e ~/.config/nvim/init.lua<CR>", opts)
keymap("n", "<leader>2", ":e ~/.zshrc<CR>", opts)
keymap("n", "<leader>3", ":e ~/.bashrc<CR>", opts)

-- For Conceal enable/disable
vim.keymap.set("n",  "<F10>" , function()
	if vim.o.conceallevel > 0 then
		vim.o.conceallevel = 0
	else
		vim.o.conceallevel = 2
	end
end, opts)

vim.keymap.set("n",  "<F11>" , function()
	if vim.o.concealcursor == "n" then
		vim.o.concealcursor = ""
	else
		vim.o.concealcursor = "n"
	end
end, opts)

-- Hacks for Problems
-- keymap("n", "A", "$i<Right><Right>", opts)

-- More Extra Stuff
vim.cmd([[cnoreab cls Cls]])
vim.cmd([[cnoreab Bo BufOnly]])
vim.cmd([[cnoreab W w]])
vim.cmd([[cnoreab W! w!]])
vim.cmd([[cnoreab Bw Blockwise]])
vim.cmd([[inoreab Fname <c-r>=expand("%:p")<cr>]])
vim.cmd([[inoreab Iname <c-r>=expand("%:p")<cr>]])
vim.cmd([[inoreab fname <c-r>=expand("%:t")<cr>]])
vim.cmd([[inoreab iname <c-r>=expand("%:t")<cr>]])
vim.cmd([[inoreabbrev idate <C-R>=strftime("%b %d %Y %H:%M")<CR>]])

local function custom_codeAction_callback(_, _, action)
	print(vim.inspect(action))
end

local servers = {
	pyright = {},
	clangd = {},
	bashls = {},
	sqls = {},
	sumneko_lua = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins" },
					disable = {
						"lowercase-global",
						"undefined-global",
						"unused-local",
						"unused-vararg",
						"trailing-space",
					},
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
					-- library = vim.api.nvim_get_runtime_file("", true),
					maxPreload = 2000,
					preloadFileSize = 50000,
				},
				completion = { callSnippet = "Both" },
				telemetry = { enable = false },
			},
		},
	},
	jsonls = {},
	eslint = {},
}

local opts = { noremap = true, silent = true }

-- Mappings.
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
vim.api.nvim_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
vim.api.nvim_set_keymap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gw", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ah", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>af", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ee", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ar", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ai", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ao", "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", opts)

local on_attach = function(client, bufnr)
	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"<space>wl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		opts
	)
end

-- for _, lsp in pairs(servers) do
-- 	require("lspconfig")[_].setup({
-- 		on_attach = on_attach,
-- 		flags = {
-- 			-- This will be the default in neovim 0.7+
-- 			debounce_text_changes = 150,
-- 		},
-- 	})
-- end

vim.diagnostic.config({ virtual_text = false })

vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
-- vim.lsp.callback['textDocument/codeAction'] = custom_codeAction_callback

local lsp = {
	float = { focusable = true, style = "minimal", border = "rounded" },
	diagnostic = {
		virtual_text = false,
		-- virtual_text = { spacing = 4, prefix = "●" },
		underline = false,
		update_in_insert = false,
		severity_sort = true,
		float = { focusable = true, style = "minimal", border = "rounded" },
	},
}

-- Diagnostic signs
local diagnostic_signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(diagnostic_signs) do
	vim.fn.sign_define(sign.name, {
		texthl = sign.name,
		text = sign.text,
		numhl = sign.name,
	})
end

vim.diagnostic.config(lsp.diagnostic)
-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, lsp.float)
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, lsp.float)
-- vim.lsp.handlers["textDocument/definition"] = vim.lsp.with(vim.lsp.handlers.definition, lsp.float)
-- vim.lsp.handlers["textDocument/typeDefinition"] = vim.lsp.with(vim.lsp.handlers.type_definition, lsp.float)

vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

require'lspconfig'.eslint.setup{}
require'lspconfig'.emmet_ls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.pyright.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.jdtls.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.sqls.setup{}
require'lspconfig'.sumneko_lua.setup{}
require'lspconfig'.tailwindcss.setup{}

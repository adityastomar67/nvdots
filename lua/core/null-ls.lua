local present, null_ls = pcall(require, "null-ls")

if not present then
	return
end

local b = null_ls.builtins

local sources = {

	-- webdev stuff
	b.formatting.deno_fmt,
	b.formatting.prettier.with({
		filetypes = { "html", "markdown", "css" },
		extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
	}),

	-- Lua
	b.formatting.stylua,

	-- Shell
	b.formatting.shfmt,
	b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

	-- cpp
	b.formatting.clang_format,

    -- pyhton
    b.formatting.black.with({ extra_args = { "--fast" }}),
    b.diagnostics.flake8,
}

null_ls.setup({
	debug = true,
	sources = sources,
})

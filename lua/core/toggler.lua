local t = vim.tbl_add_reverse_lookup({
  ['true'] = 'false',
  ['yes']  = 'no',
  ['on']   = 'off',
  ['left'] = 'right',
  ['up']   = 'down',
})

local setup = function(u_tbl)
  t = vim.tbl_extend('force', t, vim.tbl_add_reverse_lookup(u_tbl or {}))
end

local c = {
  ['n'] = 'norm! ciw',
  ['v'] = 'norm! c',
}

local toggle = function()
  local i = vim.tbl_get(t, vim.fn.expand('<cword>'))
  xpcall(function()
    vim.cmd(vim.tbl_get(c, vim.api.nvim_get_mode().mode) .. i)
  end, function()
    print('toggler: unsupported value.')
  end)
end

vim.keymap.set({ 'n', 'v' }, '<leader>i', toggle, { noremap = true, silent = true })

return { setup = setup, toggle = toggle }

P = function(obj)
    vim.print(vim.inspect(obj))
    return obj
end

vim.keymap.set('n', '<leader>xx', ":w<CR>:source %<CR>")
vim.keymap.set('n', '<leader>gh', ":Telescope help_tags<CR>")
vim.keymap.set('n', '<leader>tl', "<Plug>PlenaryTestFile")

-- maven control
vim.api.nvim_create_user_command('MvnCleanCompile', function() require("maven").do_mvn_clean_compile() end, {})
vim.keymap.set('n', '<leader>mc', ":MvnCleanCompile<CR>")

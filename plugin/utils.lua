P = function(obj)
    vim.print(vim.inspect(obj))
    return obj
end

vim.keymap.set('n', "<leader>xx", ":w<CR>:source %<CR>")
vim.keymap.set('n', "<leader>gh", ":Telescope help_tags<CR>")
vim.keymap.set('n', "<leader>tl", "<Plug>PlenaryTestFile")

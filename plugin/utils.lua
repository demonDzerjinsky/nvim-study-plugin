P = function(obj)
    vim.print(vim.inspect(obj))
    return obj
end

vim.keymap.set('n', "<leader>xx", ":source %<CR>")
vim.keymap.set('n', "<leader>gh", ":Telescope help_tags<CR>")

P = function(obj)
    vim.print(vim.inspect(obj))
    return obj
end

vim.keymap.set('n', '<leader><leader>x', ":w<CR>:source %<CR>")
vim.keymap.set('n', '<leader>x', ":.lua<CR>")
vim.keymap.set('v', '<leader>x', ":lua<CR>")
-- vim.keymap.set('n', '<leader>tl', "<Plug>PlenaryTestFile")

-- maven control
vim.api.nvim_create_user_command('MvnCleanCompile', function() require("maven").do_mvn_clean_compile() end, {})
vim.api.nvim_create_user_command('MvnCleanTest', function() require("maven").do_mvn_clean_test() end, {})
vim.api.nvim_create_user_command('MvnCleanPackage', function() require("maven").do_mvn_clean_package() end, {})
vim.api.nvim_create_user_command('MvnCleanInstall', function() require("maven").do_mvn_clean_install() end, {})
vim.api.nvim_create_user_command('MvnCleanDeploy', function() require("maven").do_mvn_clean_deploy() end, {})
vim.keymap.set('n', '<leader>mc', ":MvnCleanCompile<CR>")
vim.keymap.set('n', '<leader>mt', ":MvnCleanTest<CR>")
vim.keymap.set('n', '<leader>mp', ":MvnCleanPackage<CR>")
vim.keymap.set('n', '<leader>mi', ":MvnCleanInstall<CR>")
vim.keymap.set('n', '<leader>md', ":MvnCleanDeploy<CR>")

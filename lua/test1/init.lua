local M = {}

-- public api, pushes keymapping into local stack
M.push = function(name, mode, mappings)
    local map = vim.api.nvim_get_keymap(mode)
    P(map)
end

M.pop = function(name)

end

M.push("debug", 'n', {
    ["<leader>sh"] = "echo 'hello'",
    ["<leader>sz"] = "echo 'good by'"
})

return M

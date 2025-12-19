local M = {}

-- locals
local find_mappings = function(map, lhs)
    for _, val in ipairs(map) do
        if val.lhs == lhs then
            return val
        end
    end
    return nil
end

-- public api, pushes keymapping into local stack
M.push = function(name, mode, mappings)
    local map = vim.api.nvim_get_keymap(mode)
    local existing_map = {}
    for lhs, rhs in pairs(mappings) do
        print("searching for", lhs)
        P(find_mappings(map, lhs))
    end
end

M.pop = function(name)

end

-- main proc
M.push("debug", 'n', {
    [" sh"] = "echo 'hello'",
    [" sz"] = "echo 'good by'"
})

return M

local M = {}
M._stack = {}

-- locals
local find_mappings = function(map, lhs)
    for _, val in ipairs(map) do
        if val.lhs == lhs then
            return val
        end
    end
end

-- public api, pushes keymapping into local stack
M.push = function(name, mode, mappings)
    local map = vim.api.nvim_get_keymap(mode)
    local existing_maps = {}
    for lhs, rhs in pairs(mappings) do
        local existing = find_mappings(map, lhs)
        if existing then
            table.insert(existing_maps, existing)
        end
    end
    M._stack[name] = existing_maps;
end

-- assign new keymappings
M.assign = function(mode, mappings)
    for lsh, rsh in pairs(mappings) do
        vim.keymap.set(mode, lsh, rsh)
    end
end

-- save existing mappings to stack and assign new mappings
M.save_and_reassign = function(name, mode, mappings)
    M.push(name, mode, mappings)
    M.assign(mode, mappings)
end

M.pop = function(name)

end

-- main proc
M.save_and_reassign("debug", 'n', {
    [" sh"] = "echo 'hello'",
    [" sz"] = "echo 'good by'"
})

return M

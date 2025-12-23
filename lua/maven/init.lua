local M = {}
M.buffer = nil -- todo clear on exit

local winsize = function()
    local width = vim.api.nvim_get_option('columns')
    local height = vim.api.nvim_get_option('lines')
    local wheight = math.min(math.ceil(height * 3 / 4), 30)
    local wwidth
    if width < 150 then
        wwidth = math.ceil(width - 8)
    else
        wwidth = math.ceil(width * 0.95)
    end
    return { wwidth, wheight, math.ceil((width - wwidth) / 2), math.ceil((height - wheight) / 2) }
end

local init_buffer = function()
    if M.buffer then return end
    M.buffer = vim.api.nvim_create_buf(false, true)
end

local push_buffer = function(data)
    init_buffer()
    vim.api.nvim_buf_set_lines(M.buffer, -1, -1, false, data)
end

local make_win_opt = function()
    local wsize = winsize()
    local opt = {
        relative = 'win',
        width = wsize[1],
        height = wsize[2],
        col = wsize[3],
        row = wsize[4],
        border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
        title = 'maven clean compile', --support parameter 
        title_pos = 'center',
        footer = 'press <Enter> to continue with editor', --todo support pressing Enter
        footer_pos = 'center'
    }
    return opt
end

local open_win = function()
    vim.api.nvim_open_win(M.buffer, true, make_win_opt())
end

local receiver = function(job_id, data, event)
    if data then
        push_buffer(data)
        open_win()
    end
end

M.do_mvn_clean_compile = function()
    local cmd = { 'mvn', 'clean', 'compile' } --todo make parameter
    vim.fn.jobstart(cmd, {
        stdout_buffered = false,
        on_stdout = receiver, --tode add error
    })
end
--todo make user command
--todo make nmap for user command
return M

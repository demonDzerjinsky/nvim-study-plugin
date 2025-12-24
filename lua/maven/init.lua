local M = {}
M.buffer = nil
M.win = nil
M.cmd = nil
M.is_open = nil -- support parmeter: init on start and clear on window exit

local win_size = function()
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
    local wsize = win_size()
    local opt = {
        relative = 'win',
        width = wsize[1],
        height = wsize[2],
        col = wsize[3],
        row = wsize[4],
        border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
        title = table.concat(M.cmd, ' '),
        title_pos = 'center',
        footer = 'press <Enter> to continue with editor', --todo support pressing Enter
        footer_pos = 'center'
    }
    return opt
end

local open_win = function()
    if M.win then return end
    M.win = vim.api.nvim_open_win(M.buffer, true, make_win_opt())
end

local supply = function(job_id, data, event)
    if data then
        push_buffer(data)
        open_win()
    end
end

local log = function(msg)
    supply(nil, { os.date("The time is %I:%M %p on %B %d, %Y: ", os.time()) .. msg }, nil)
end

local clear_state = function()
    M.buffer = nil
    M.win = nil
    M.cmd = nil
end

local do_process = function()
    log("starting " .. M.cmd[1])
    vim.fn.jobstart(M.cmd, {
        stdout_buffered = false,
        on_stdout = supply,
        on_strerr = supply,
        on_exit = function()
            log(M.cmd[1] .. " completed")
            clear_state()
        end
    })
end

M.do_mvn_clean_compile = function()
    M.cmd = { 'mvn', 'clean', 'compile' }
    do_process()
end

M.do_mvn_clean_test = function()
    M.cmd = { 'mvn', 'clean', 'test' }
    do_process()
end

M.do_mvn_clean_package = function()
    M.cmd = { 'mvn', 'clean', 'package' }
    do_process()
end

M.do_mvn_clean_install = function()
    M.cmd = { 'mvn', 'clean', 'install' }
    do_process()
end

M.do_mvn_clean_deploy = function()
    M.cmd = { 'mvn', 'clean', 'deploy' }
    do_process()
end


--[[todo make nmap for user command
- default keqmap <leader>mc mt mp mi md - phases
    + mc
    - mt input tag dialog
- save and restore keymappings + check it runs on maven project (alert if not) and if maven project - write all buffers before
    ]]

return M

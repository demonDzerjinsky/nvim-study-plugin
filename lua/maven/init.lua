local M = {}

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

local getBuffer = function(data)
    local buffer = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buffer, -1, -1, false, data)
    return buffer
end

local makeOpt = function()
    local wsize = winsize()
    local opt = {
        relative = 'win',
        width = wsize[1],
        height = wsize[2],
        col = wsize[3],
        row = wsize[4],
        border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
        title = 'maven clean compile',
        title_pos = 'center',
        footer = 'press <Enter> to continue with editor',
        footer_pos = 'center'
    }
    return opt
end

local getWin = function(buffer)
    local opt = makeOpt()
    local win = vim.api.nvim_open_win(buffer, true, opt)
    if win == 0 then
        vim.notify("create window error in getWin()", vim.log.levels.ERROR, {})
    end
    return win
end

local receiver = function(job_id, data, event)
    if data then
        local lbuf = getBuffer(data)
        local lwin = getWin(lbuf)
    end
end

M.do_mvn_clean_compile = function()
    local cmd = { 'mvn', 'clean', 'compile' }
    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = receiver,
    })
end

return M

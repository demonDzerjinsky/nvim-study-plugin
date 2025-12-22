local M = {}

M.do_mvn_clean_compile = function()
    local cmd = { 'mvn', 'clean', 'compile' }
    local fhdr = function(job_id, data, event)
        if data then
            P(data)
        end
    end
    vim.fn.jobstart(cmd, {
        stdout_buffered = yes,
        stderr_buffered = yes,
        on_stdout = fhdr,
        on_stderr = fhdr
    })
end

M.do_mvn_clean_compile()

return M

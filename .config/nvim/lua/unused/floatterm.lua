local term_bufnr
local term_winid
local float_terminal_open = false
local float_terminal_hidden = false

vim.api.nvim_command('highlight MyFloatTerm guibg=none')

function create_float_window(buff)
    local buf_config = {
        buftype = 'nofile',
        hidden = true,
        termfinish = 'close'
    }
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)
    local win_config = {
        relative = 'editor',
        width = math.floor(width * 0.8),
        height = math.floor(height * 0.8),
        col = math.floor(width * 0.1),
        row = math.floor(height * 0.1),
        style = 'minimal',
        border = 'rounded'
    }
    return vim.api.nvim_open_win(buff, true, win_config)
end

function create_float_terminal()
    term_bufnr = vim.api.nvim_create_buf(false, true)
    term_winid = create_float_window(term_bufnr)

    vim.api.nvim_win_set_buf(term_winid, term_bufnr)
    -- Set the background color to grey
    vim.api.nvim_win_set_option(term_winid, 'winhighlight', 'Normal:MyFloatTerm')
    vim.api.nvim_win_set_buf(term_winid, term_bufnr)
    vim.api.nvim_command('terminal')

    -- Remove the status line
    vim.api.nvim_win_set_option(term_winid, 'statusline', '')

    float_terminal_open = true
    float_terminal_hidden = false

    vim.api.nvim_command('autocmd TermClose <buffer> execute "bdelete! " . expand("<abuf>")')

end

function _G.toggle_float_terminal()
    if float_terminal_open then
        if vim.api.nvim_buf_is_valid(term_bufnr) then
            if float_terminal_hidden then
                term_winid = create_float_window(term_bufnr)
                vim.api.nvim_win_set_buf(term_winid, term_bufnr)
                float_terminal_hidden = false
            else
                vim.api.nvim_win_close(term_winid, false)
                float_terminal_hidden = true
            end
        else
            float_terminal_open = false
            create_float_terminal()
        end
    else
        create_float_terminal()
    end
end

-- vim.api.nvim_set_keymap('n', '<C-\\>', ':lua _G.toggle_float_terminal()<CR>', {
--     noremap = true,
--     silent = true
-- })

-- vim.api.nvim_set_keymap('t', '<C-\\>', '<C-\\><C-n>:lua _G.toggle_float_terminal()<CR>', {
--     noremap = true,
--     silent = true
-- })

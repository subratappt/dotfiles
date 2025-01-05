return {
    'akinsho/toggleterm.nvim',
    version = "*",
    vim.api.nvim_command('highlight MyHighlight guibg=none'),

    config = function()
        require("toggleterm").setup({
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shell = vim.o.shell,
            direction = "float",
            float_opts = {
                border = "double",
                width = 120,
                height = 15,
                highlights = {
                    background = 'MyHighlight',
                    border = 'MyHighlight'
                }
            },
            on_open = function(term)
                vim.api.nvim_win_set_option(term.window, 'winhighlight', 'Normal:MyHighlight,FloatBorder:MyHighlight')
            end
        })
    end

}

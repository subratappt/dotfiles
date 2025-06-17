M = {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        local style = vim.o.background == 'dark' and 'night' or 'day'
        print('tokyonight style: ' .. style)
        require('tokyonight').setup({
            style = style,
            light_style = 'day',
            transparent = true,
            styles = {
                sidebars = 'transparent',
                floats = 'transparent',
            },
        })
        vim.cmd('colorscheme tokyonight')
    end,
}

return M

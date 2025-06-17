return {
    'epwalsh/obsidian.nvim',
    version = '*',
    lazy = true,
    ft = 'markdown',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    opts = {
        workspaces = {
            {
                name = 'work',
                path = vim.fn.expand('~/notes/work'), -- Expands the '~' to the full path
            },
        },

        templates = {
            subdir = 'templates',
            date_format = '%b %e, %Y',
            time_format = '%l:%M %p',
        },
    },
    config = function()
        -- Ensure the directory exists
        local path = vim.fn.expand('~/notes/')
        if not vim.fn.isdirectory(path) then
            vim.fn.mkdir(path, 'p') -- Create the directory if it doesn't exist
        end
        require('obsidian').setup({
            dir = vim.fn.expand('~/notes/'), -- Set the directory for Obsidian notes
            ui = {
                enable = false,
            },
        })
    end,
}

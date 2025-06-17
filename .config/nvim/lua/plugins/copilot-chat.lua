return {
    'CopilotC-Nvim/CopilotChat.nvim',
    enabled = true,
    dependencies = {
        {
            'zbirenbaum/copilot.lua',
            { 'nvim-lua/plenary.nvim', branch = 'master' },
        },
    },
    build = 'make tiktoken',
    opts = {
        model = 'gpt-4',
        agent = 'copilot',
        mappings = {
            reset = {
                normal = '<leader>rr',
                insert = '<leader>rr',
            },
        },
        window = {
            border = 'shadow',
            title = 'Copilot Chat', -- title of chat window
        },
    },
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
        -- to toggle the chat window
        {
            '<C-t>',
            function()
                require('CopilotChat').toggle()
            end,
            desc = 'CopilotChat - Toggle chat window',
        },
    },
}

return {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
        {
            'zbirenbaum/copilot.lua',
            { 'nvim-lua/plenary.nvim', branch = 'master' },
        },
    },
    build = 'make tiktoken',
    opts = {
        model = 'gpt-4o',
    },
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
        {
            '<leader>ch',
            function()
                vim.ui.input({
                    prompt = 'Chat with Copilot: ',
                }, function(input)
                    if input and input ~= '' then
                        require('CopilotChat').ask(input, {
                            selection = require('CopilotChat.select').buffer,
                        })
                    end
                end)
            end,
            desc = 'CopilotChat - Quick chat',
        },
    },
}

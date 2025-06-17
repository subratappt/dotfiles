return {
    'zbirenbaum/copilot.lua',
    enabled = true,
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
        require('copilot').setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = '<C-e>',
                },
            },
        })
    end,
}

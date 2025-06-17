return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        require('codecompanion').setup({
            adapters = {
                gemini = function()
                    return require('codecompanion.adapters').extend('gemini', {
                        env = {
                            api_key = "cmd: gpg --quiet --batch --yes --passphrase 'neovim' --decrypt ~/api_keys/gemini_api_key.gpg",
                        },
                    })
                end,
            },
            strategies = {
                chat = {
                    adapter = 'copilot',
                    keymaps = {
                        send = {
                            modes = { n = '<C-s>', i = '<C-s>' },
                            opts = {},
                        },
                        close = {
                            modes = { n = '<C-c>', i = '<C-c>' },
                            opts = {},
                        },
                    },
                },
                inline = {
                    adapter = 'copilot',
                    keymaps = {
                        accept_change = {
                            modes = { n = 'ga' },
                            description = 'Accept the suggested change',
                        },
                        reject_change = {
                            modes = { n = 'gr' },
                            description = 'Reject the suggested change',
                        },
                    },
                },
                cmd = {
                    adapter = 'copilot',
                },
            },
            opts = {
                log_level = 'DEBUG', -- or "TRACE"
            },
        })
    end,
}

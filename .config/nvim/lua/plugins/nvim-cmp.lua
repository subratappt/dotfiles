return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-buffer', -- source for text in buffer
        'hrsh7th/cmp-path', -- source for file system paths
        'L3MON4D3/LuaSnip', -- snippet engine
        'saadparwaiz1/cmp_luasnip', -- for autocompletion
        'rafamadriz/friendly-snippets', -- useful snippets
        'onsails/lspkind.nvim', -- vs-code like pictograms
        'kdheepak/cmp-latex-symbols', -- latex symbols
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require('luasnip.loaders.from_vscode').lazy_load()
        cmp.setup({
            preselect = cmp.PreselectMode.None,
            completion = {
                completeopt = 'menu,menuone,preview,noselect',
            },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
            }),
            -- sources for autocompletion
            sources = cmp.config.sources({
                -- { name = "copilot", group_index = 2 },
                { name = 'nvim_lsp' },
                { name = 'path' }, -- file system paths
                { name = 'luasnip' }, -- snippets
                { name = 'buffer' }, -- text within current buffer
                { name = 'latex_symbols', option = { strategy = 1 } }, -- latex symbols 0: mixed, 1: julia, 2: latex
                { name = 'render-markdown' },
            }),
            -- configure lspkind for vs-code like pictograms in completion menu
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol',
                    max_width = 50,
                    symbol_map = { Copilot = '' },
                }),
            },
        })
    end,
}

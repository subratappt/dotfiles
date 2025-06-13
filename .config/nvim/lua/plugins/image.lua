return {
    '3rd/image.nvim',
    enabled = true,
    init = function()
        package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?/init.lua'
        package.path = package.path .. ';' .. vim.fn.expand('$HOME') .. '/.luarocks/share/lua/5.1/?.lua'
    end,
    event = 'VeryLazy',
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            config = function()
                require('nvim-treesitter.configs').setup({
                    ensure_installed = {
                        'markdown',
                    },
                    highlight = {
                        enable = true,
                    },
                })
            end,
        },
    },
    opts = {
        -- rocks = { hererocks = true },
        backend = 'kitty',
        processor = 'magick_cli',
        integrations = {
            markdown = {
                enabled = true,
                clear_in_insert_mode = false,
                download_remote_images = true,
                only_render_image_at_cursor = false,
                filetypes = {
                    'markdown',
                    'vimwiki',
                }, -- markdown extensions (ie. quarto) can go here
            },
        },
        max_width = 70, -- tweak to preference
        max_height = 70, -- ^
        max_height_window_percentage = math.huge, -- this is necessary for a good experience
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = {
            'cmp_menu',
            'cmp_docs',
            'snacks_notif',
            'scrollview',
            'scrollview_sign',
        },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = {
            '*.png',
            '*.jpg',
            '*.jpeg',
            '*.gif',
            '*.webp',
            '*.avif',
        }, -- render image files as images when opened
    },
}

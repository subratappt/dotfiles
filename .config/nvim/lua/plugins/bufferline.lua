return {
    "akinsho/bufferline.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    version = "*",
    config = function()
        require('bufferline').setup {
            options = {
                offsets = {
                    {
                        -- filetype = "NvimTree",
                        filetype = "neo-tree",
                        text = "Explorer",
                        padding = 0
                    },
                    {
                        filetype = "NvimTree",
                        -- filetype = "neo-tree",
                        text = "Explorer",
                        padding = 0
                    }
                },
                numbers = "both",
                number_style = "superscript",
                mappings = true,
                modified_icon = '●',
                max_name_length = 18,
                max_prefix_length = 15,
                tab_size = 18,
                diagnostics = "nvim_lsp",
                show_buffer_close_icons = true,
                persist_buffer_sort = true,
                separator_style = "thin",
                enforce_regular_tabs = false,
                always_show_bufferline = true
            }
        }
    end

}

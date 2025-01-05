return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        "s1n7ax/nvim-window-picker"
    },

    config = function()
        require("neo-tree").setup({
            commands = {
                copy_absolute_path = function(state)
                    local node = state.tree:get_node()
                    local filepath = node:get_id()
                    if filepath then
                        vim.notify(("Copied: `%s`"):format(filepath))
                        vim.fn.setreg("+", filepath)
                    end
                end,

                copy_relative_path = function(state)
                    local node = state.tree:get_node()
                    local filepath = vim.fn.fnamemodify(node:get_id(), ":~:.")
                    if filepath then
                        vim.notify(("Copied: `%s`"):format(filepath))
                        vim.fn.setreg("+", filepath)
                    end
                end,

                copy_filename = function(state)
                    local node = state.tree:get_node()
                    local filename = node.name
                    if filename then
                        vim.notify(("Copied: `%s`"):format(filename))
                        vim.fn.setreg("+", filename)
                    end
                end

            },
            window = {
                mappings = {
                    ["<SPACE>"] = false,
                    ['<TAB>'] = "open",
                    ["P"] = "",
                    ga = "copy_absolute_path",
                    gr = "copy_relative_path",
                    gf = "copy_filename",
                    o = "open"
                }
            },
            source_selector = {
                winbar = true,
                statusline = false
            }
        })
    end

}


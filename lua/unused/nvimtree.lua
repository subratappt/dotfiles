return {
    "nvim-tree/nvim-tree.lua",
    cmd = {
        "NvimTreeToggle",
        "NvimTreeFocus"
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local nvimtree = require("nvim-tree")

        -- recommended settings from nvim-tree documentation
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- change color for arrows in tree to light blue
        vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
        vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

        -- configure nvim-tree
        nvimtree.setup({
            view = {
                width = 35,
                relativenumber = false
            },
            -- change folder arrow icons
            renderer = {
                indent_markers = {
                    enable = true
                },
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = false
                    },

                    glyphs = {
                        default = "󰈚",
                        symlink = "",
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                            symlink_open = "",
                            arrow_open = "",
                            arrow_closed = ""
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌"
                        }
                    }
                }
            },
            -- disable window_picker for
            -- explorer to work well with
            -- window splits
            actions = {
                open_file = {
                    window_picker = {
                        enable = false
                    }
                }
            },
            filters = {
                custom = {
                    ".DS_Store"
                }
            },
            git = {
                ignore = false
            }
        })
    end
    -- init = function()
    --     if vim.fn.argc(-1) == 1 then
    --         local stat = vim.loop.fs_stat(vim.fn.argv(0))
    --         if stat and stat.type == "directory" then
    --             require("nvim-tree").setup({})
    --         end
    --     end
    -- end

}
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1

-- vim.cmd([[
--     autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'cd '.argv()[0] | NvimTreeToggle | endif
--     ]])

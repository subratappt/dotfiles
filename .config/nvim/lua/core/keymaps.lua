-- set leader key
vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps
keymap.set("i", "jj", "<Esc>", {
    desc = "jj to escape"
})
keymap.set("i", "jk", "<Esc>", {
    desc = "jk to escape"
})

-- file save and quit
keymap.set("n", "<leader>w", "<cmd>write<CR>", {
    desc = "Save file"
})
keymap.set("n", "<leader>q", "<cmd>quit<CR>", {
    desc = "Quit file"
})
keymap.set("n", "<leader>wq", "<cmd>write<CR><cmd>quit<CR>", {
    desc = "Save and quit file"
})

-- buffer navigation

keymap.set('n', '<Tab>', ':bnext<CR>', {
    noremap = true,
    silent = true,
    desc = "Next buffer"
})

keymap.set('n', '<S-Tab>', ':bprevious<CR>', {
    noremap = true,
    silent = true,
    desc = "Previous buffer"
})

keymap.set('n', '<leader>bd', function()
    vim.api.nvim_command('bp|sp|bn|bd')
end, {
    noremap = true,
    silent = true,
    desc = "Delete buffer and keep window open"
})

keymap.set('n', '<leader>bn', ':enew<CR>', {
    noremap = true,
    silent = true,
    desc = "New buffer"
})

-- window navigation

keymap.set('n', '<C-l>', ':wincmd l<CR>', {
    noremap = true,
    silent = true,
    desc = "Move to right window"
})

keymap.set('n', '<C-h>', ':wincmd h<CR>', {
    noremap = true,
    silent = true,
    desc = "Move to left window"
})

keymap.set("n", "<leader>ee", "<cmd>Neotree toggle<CR>", {
    desc = "Toggle file explorer"
})

-- keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", {
--     desc = "Toggle file explorer"
-- })

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", {
    desc = "Find files"
})


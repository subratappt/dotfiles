-- set leader key
vim.g.mapleader = ' '

local keymap = vim.keymap

-- General keymaps
keymap.set('i', 'jj', '<Esc>', {
    desc = 'jj to escape',
})
keymap.set('i', 'jk', '<Esc>', {
    desc = 'jk to escape',
})

keymap.set('n', '<Tab>', '>>', { noremap = true, silent = true })
keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true })
keymap.set('i', '<S-Tab>', '<BS>', { noremap = true, silent = true })
keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })
keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
keymap.set('n', '<leader>h', '<cmd>nohlsearch<CR>', {
    noremap = true,
    silent = true,
    desc = 'Clear highlights',
})
-- nnoremap <silent><esc><esc> :nohlsearch<CR>
-- file save and quit
keymap.set('n', '<leader>w', '<cmd>write<CR>', {
    desc = 'Save file',
})
keymap.set('n', '<leader>q', '<cmd>quit<CR>', {
    desc = 'Quit file',
})
keymap.set('n', '<leader>wq', '<cmd>write<CR><cmd>quit<CR>', {
    desc = 'Save and quit file',
})

-- buffer navigation

keymap.set('n', '<Tab>', ':bnext<CR>', {
    noremap = true,
    silent = true,
    desc = 'Next buffer',
})

keymap.set('n', '<S-Tab>', ':bprevious<CR>', {
    noremap = true,
    silent = true,
    desc = 'Previous buffer',
})

-- keymap.set('n', '<leader>bd', function()
--     vim.api.nvim_command('bp|sp|bn|bd')
-- end, {
--     noremap = true,
--     silent = true,
--     desc = 'Delete buffer and keep window open',
-- })

keymap.set('n', '<leader>bw', ':bw<CR>', {
    noremap = true,
    silent = true,
    desc = 'Wipeout buffer',
})

keymap.set('n', '<leader>bn', ':enew<CR>', {
    noremap = true,
    silent = true,
    desc = 'New buffer',
})

-- window resize
keymap.set('n', '<M-h>', ':vertical resize -5<CR>', {
    noremap = true,
    silent = true,
    desc = 'Resize window left',
})
keymap.set('n', '<M-l>', ':vertical resize +5<CR>', {
    noremap = true,
    silent = true,
    desc = 'Resize window right',
})
keymap.set('n', '<M-j>', ':resize -2<CR>', {
    noremap = true,
    silent = true,
    desc = 'Resize window down',
})
keymap.set('n', '<M-k>', ':resize +2<CR>', {
    noremap = true,
    silent = true,
    desc = 'Resize window up',
})

keymap.set('n', '<leader>ee', '<cmd>Neotree toggle<CR>', {
    desc = 'Toggle file explorer',
})

-- keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", {
--     desc = "Toggle file explorer"
-- })

keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<CR>', {
    desc = 'Find files',
})

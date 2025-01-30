vim.cmd([[
    function! SlimeOverrideConfig()
        let l:last_pane_id = trim(system('tmux display -pt "{last}" "#{pane_id}"'))
        let b:slime_config = {"socket_name": "default", "target_pane": l:last_pane_id}
    endfunction
]])
return {
    'jpalardy/vim-slime',
    config = function()
        vim.g.slime_target = 'tmux'
        vim.g['slime_bracketed_paste'] = 1
        vim.g.slime_cell_delimiter = '# %%'
        -- vim.g.slime_default_config = { socket_name = "default", target_pane = "{last}" }
        vim.keymap.set(
            'n',
            '<leader>tt',
            '<Plug>SlimeSendCell',
            { remap = true, silent = false, desc = 'Slime Send cell' }
        )
        vim.keymap.set(
            'n',
            '<leader>t',
            '<Plug>SlimeLineSend',
            { remap = true, silent = false, desc = 'Slime Send line' }
        )
        vim.keymap.set(
            'x',
            '<leader>t',
            '<Plug>SlimeRegionSend',
            { remap = true, silent = false, desc = 'Slime Send region' }
        )
    end,
}

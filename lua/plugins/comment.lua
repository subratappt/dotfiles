-- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
return {
    'numToStr/Comment.nvim',
    event = {
        "BufReadPre",
        "BufNewFile"
    },
    config = function()
        require('Comment').setup({
            ignore = '^$',
            toggler = {
                line = '<leader>/'
            },
            opleader = {
                line = '<leader>/'
            }
        })
    end

}

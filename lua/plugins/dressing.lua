return {
    "stevearc/dressing.nvim",
    -- event = "VeryLazy",
    config = function()
        require("dressing").setup({
            input = {
                relative = "win"
            }
        })
    end
}

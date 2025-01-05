return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<c-l>"
                }
            }
        })
    end
}
-- return {
--     "github/copilot.vim",
--     event = "InsertEnter",
--     cmd = "Copilot"
-- }

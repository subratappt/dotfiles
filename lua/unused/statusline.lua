local modes = {
    ["n"] = "N",
    ["no"] = "N",
    ["v"] = "V",
    ["V"] = "VL",
    [""] = "VB",
    ["s"] = "S",
    ["S"] = "SL",
    [""] = "SB",
    ["i"] = "I",
    ["ic"] = "I",
    ["R"] = "R",
    ["Rv"] = "VR",
    ["c"] = "COMMAND",
    ["cv"] = "VIM EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "T"
}

vim.cmd("highlight StatusLineNormal guifg=#038e18")
vim.cmd("highlight StatusLineVisual guifg=#17508e")
vim.cmd("highlight StatusLineInsert guifg=#cd2e2e")
vim.cmd("highlight StatusLineReplace guifg=#b98d0a")
vim.cmd("highlight StatusLineCmdLine guifg=#377690")
vim.cmd("highlight StatusLineTerminal guifg=#941358")
vim.cmd("highlight StatusLineExtra guifg=#1fa7c6")

vim.cmd("highlight LspDiagnosticsSignError guifg=#991313")
vim.cmd("highlight LspDiagnosticsSignWarning guifg=#c49213")
vim.cmd("highlight LspDiagnosticsSignHint guifg=#13c9a1")
vim.cmd("highlight LspDiagnosticsSignInformation guifg=#1399c4")

local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end
local function update_mode_colors()
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_color = "%#StatusLineNormal#"
    if current_mode == "n" then
        mode_color = "%#StatuslineNormal#"
    elseif current_mode == "i" or current_mode == "ic" then
        mode_color = "%#StatuslineInsert#"
    elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
        mode_color = "%#StatuslineVisual#"
    elseif current_mode == "R" then
        mode_color = "%#StatuslineReplace#"
    elseif current_mode == "c" then
        mode_color = "%#StatuslineCmdLine#"
    elseif current_mode == "t" then
        mode_color = "%#StatuslineTerminal#"
    end
    return mode_color
end

local function filepath()
    local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
    if fpath == "" or fpath == "." then
        return " "
    end
    return string.format(" %%<%s/", fpath)
end

local function filename()
    local fname = vim.fn.expand("%:t")
    if fname == "" then
        return ""
    end
    return fname .. " "
end

local function lsp()
    local count = {}
    local levels = {
        errors = "Error",
        warnings = "Warn",
        info = "Info",
        hints = "Hint"
    }
    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, {
            severity = level
        }))
    end
    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""
    if count["errors"] ~= 0 then
        errors = " %#LspDiagnosticsSignError# " .. count["errors"]
    end
    if count["warnings"] ~= 0 then
        warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
    end
    if count["hints"] ~= 0 then
        hints = " %#LspDiagnosticsSignHint#💡 " .. count["hints"]
    end
    if count["info"] ~= 0 then
        info = " %#LspDiagnosticsSignInformation# " .. count["info"]
    end
    return errors .. warnings .. hints .. info
end

local filetype_icons = {
    ["lua"] = "",
    ["python"] = "",
    ["javascript"] = "",
    ["typescript"] = "",
    ["html"] = "",
    ["css"] = "",
    ["json"] = "",
    ["yaml"] = "",
    ["markdown"] = "",
    ["sh"] = "",
    ["vim"] = "",
    ["java"] = "",
    ["c"] = "",
    ["cpp"] = "",
    ["haskell"] = "",
    ["rust"] = "",
    ["go"] = "",
    ["php"] = "",
    ["ruby"] = ""
    -- add more filetypes and their corresponding icons here...
}

local function filetype_with_icon()
    local filetype = vim.bo.filetype
    local icon = filetype_icons[filetype] or "󰈙"
    return icon .. " " .. filetype
end

local function filetype_only_icon()
    local filetype = vim.bo.filetype
    local icon = filetype_icons[filetype] or "󰈙"
    return icon
end

local function filetype()
    return string.format(" %s ", vim.bo.filetype):upper()
end

local function lineinfo()
    if vim.bo.filetype == "alpha" then
        return ""
    end
    return " %P %l:%c "
end
local vcs = function()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == "" then
        return ""
    end
    local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
    local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
    local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
    if git_info.added == 0 then
        added = ""
    end
    if git_info.changed == 0 then
        changed = ""
    end
    if git_info.removed == 0 then
        removed = ""
    end
    return table.concat({
        " ",
        "%#GitSignsAdd# ",
        git_info.head,
        " ",
        added,
        changed,
        removed
    })
end
Statusline = {}
Statusline.active = function()
    return table.concat({
        "%#Statusline#",
        update_mode_colors(),
        mode(),
        "%#Normal# ",
        filetype_only_icon(),
        filepath(),
        filename(),
        "%#Normal#",
        vcs(),
        "%#Normal# ",
        lsp(),
        "%#Normal# ",
        "%=",
        -- filetype_with_icon(),
        "%#StatusLineExtra#",
        lineinfo()
    })
end
function Statusline.inactive()
    return " %F"
end
function Statusline.short()
    return "  NvimTree"
end
function Statusline.shortLeave()
    return "  NvimTree"
end

function DisableST()
    return " "
end

vim.api.nvim_exec([[
    augroup Statusline
    au!
    au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
    au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
    au WinEnter,BufEnter,FileType NvimTree_* setlocal statusline=%!v:lua.Statusline.short()
    au WinLeave,BufLeave,Filetype NvimTree_* setlocal statusline=%!v:lua.Statusline.short()
    au TermOpen * setlocal statusline=%!v:lua.Statusline.terminal()
    augroup END
    ]], false)

-- vim.api.nvim_exec([[
--     au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree_1" | set laststatus=0 | else | set laststatus=2 | endif
--     ]], false)

-- require('nvim-tree.api').events.subscribe(api.events.Event.TreeOpen, function ()
--     vim.wo.statusline = ' '
-- end)

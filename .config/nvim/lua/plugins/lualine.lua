-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.
-- stylua: ignore
local colors = {
    blue = '#80a0ff',
    cyan = '#79dac8',
    black = '#080808',
    white = '#c6c6c6',
    red = '#ff5189',
    violet = '#d183e8',
    grey = '#303030'
}

local bubbles_theme = {
	normal = {
		a = {
			fg = colors.black,
			bg = colors.violet,
		},
		b = {
			fg = colors.white,
			bg = colors.grey,
		},
		c = {
			fg = colors.white,
		},
	},

	insert = {
		a = {
			fg = colors.black,
			bg = colors.blue,
		},
	},
	visual = {
		a = {
			fg = colors.black,
			bg = colors.cyan,
		},
	},
	replace = {
		a = {
			fg = colors.black,
			bg = colors.red,
		},
	},

	inactive = {
		a = {
			fg = colors.white,
			bg = colors.black,
		},
		b = {
			fg = colors.white,
			bg = colors.black,
		},
		c = {
			fg = colors.white,
		},
	},
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		require("lualine").setup({
			options = {
				theme = bubbles_theme,
				component_separators = {
					left = "",
					right = "",
				},
				section_separators = {
					left = "",
					right = "",
				},
				-- section_separators = { left = "", right = "" },
				icons_enabled = true,
				disabled_filetypes = {
					"neo-tree",
					"NvimTree",
					"Outline",
					"packer",
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = {
							left = "",
							right = "",
						},
						padding = {
							left = 0,
							right = 0,
						},
					},
				},
				lualine_b = {
					{
						"filename",
						path = 1,
					},
					"branch",
				},
				lualine_c = {
					{
						"diagnostics",
						sources = {
							"nvim_lsp",
						},
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
						},
						color_error = colors.red,
						color_warn = colors.violet,
						color_info = colors.blue,
					},
				},
				lualine_x = {},
				lualine_y = {
					"filetype",
					"progress",
				},
				lualine_z = {
					{
						"location",
						separator = {
							right = "",
						},
					},
				},
			},
			inactive_sections = {
				lualine_a = {
					{
						"filename",
						separator = {
							left = "",
							right = "",
						},
					},
				},
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {
					{
						"location",
						separator = {
							left = "",
							right = "",
						},
					},
				},
			},
			tabline = {},
			extensions = {},
		})
		vim.cmd("highlight statusline guifg=white guibg=NONE gui=NONE")
		vim.cmd("highlight statuslineNC guifg=black guibg=NONE gui=NONE")
	end,
}

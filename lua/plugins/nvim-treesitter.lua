return {
	"nvim-treesitter/nvim-treesitter",
	event = {
		"BufReadPost",
		"BufNewFile",
	},
	cmd = {
		"TSInstall",
		"TSBufEnable",
		"TSBufDisable",
		"TSModuleInfo",
	},
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},

	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			ensure_installed = {
				"lua",
				"c",
				"cpp",
				"fortran",
				"python",
				"markdown",
				-- "latex" -- not working due to tree-sitter issue
			},
			auto_install = true,
			highlight = {
				enable = true,
				-- additional_vim_regex_highlighting = false,
			},
			-- enable indentation
			indent = {
				enable = true,
			},
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
		})

		-- require"nvim-treesitter.install".compilers = {
		--     ""
		-- }
	end,
}

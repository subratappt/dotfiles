return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"kdheepak/cmp-latex-symbols", -- latex symbols
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		local function check_back_space()
			local col = vim.fn.col(".") - 1
			if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
				return true
			else
				return false
			end
		end

		local function feedkey(key, mode)
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
		end

		function _G.tab_complete()
			if cmp and cmp.visible() then
				cmp.select_next_item()
			elseif luasnip and luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_back_space() then
				return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
			else
				return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
			end
			return ""
		end

		function _G.s_tab_complete()
			if cmp and cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip and luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
			end
			return ""
		end

		-- Function to handle de-indentation in insert mode and move cursor
		function _G.shift_tab_deindent()
			local line = vim.api.nvim_get_current_line()
			local col = vim.fn.col(".") - 1
			if col == 0 then
				return ""
			elseif vim.fn.matchstr(line:sub(1, col), "\\s*$") ~= "" then
				vim.api.nvim_input("<C-d>")
				return ""
			else
				return vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true)
			end
		end

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args) luasnip.lsp_expand(args.body) end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						if luasnip.expandable() then
							luasnip.expand()
						else
							cmp.confirm({
								select = true,
							})
						end
					else
						fallback()
					end
				end),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					elseif check_back_space() then
						fallback()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			-- sources for autocompletion
			sources = cmp.config.sources({
				-- { name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
				{ name = "path" }, -- file system paths
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "latex_symbols", option = { strategy = 1 } }, -- latex symbols 0: mixed, 1: julia, 2: latex
			}),
			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol",
					max_width = 50,
					symbol_map = { Copilot = "" },
				}),
			},
		})

		-- Key mappings for tab completion
		vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true, noremap = true, silent = true })
		vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true, noremap = true, silent = true })
		vim.api.nvim_set_keymap(
			"i",
			"<S-Tab>",
			"v:lua.shift_tab_deindent()",
			{ expr = true, noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"s",
			"<S-Tab>",
			"v:lua.shift_tab_deindent()",
			{ expr = true, noremap = true, silent = true }
		)
	end,
}

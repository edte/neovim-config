vim.g.skip_ts_context_commentstring_module = true
lvim.builtin.treesitter.matchup.enable = true

-- -- 上下滚动浏览
keymap("", "<C-j>", "5j")
keymap("", "<C-k>", "5k")

-- vim.cmd("nmap <tab> %")

local M = {}
M.textConfig = function()
	local c = try_require("nvim-treesitter.configs")
	if c == nil then
		return
	end

	c.setup({
		refactor = {
			-- 高亮显示光标下当前符号的定义和用法。
			highlight_definitions = {
				enable = true,
				-- Set to false if you have an `updatetime` of ~100.
				clear_on_cursor_move = true,
			},

			-- 强调块从目前的范围在哪里的光标。
			-- highlight_current_scope = { enable = true },

			-- 重命名当前作用域（和当前文件）内光标下的符号。
			smart_rename = {
				enable = true,
				-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
				keymaps = {
					smart_rename = "gm",
					-- smart_rename = false,
				},
			},

			-- 为光标下的符号提供 "转到定义"，并列出当前文件中的定义。
			-- 如果 nvim-treesitter 无法解析变量，则使用 vim.lsp.buf.definition 代替下面配置中的 goto_definition_lsp_fallback。
			-- goto_next_usage/goto_previous_usage 将转到光标下标识符的下一个用法。
			navigation = {
				enable = true,
				-- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
				keymaps = {
					-- goto_definition = "gm",
					-- list_definitions = "gnD",
					-- list_definitions_toc = "gO",
					-- goto_next_usage = "<c-n>",
					-- goto_previous_usage = "<c-p>",
				},
			},
		},
	})
end

M.textsubjectsConfig = function()
	local c = try_require("nvim-treesitter.configs")
	if c == nil then
		return
	end

	c.setup({
		textsubjects = {
			enable = true,
			prev_selection = ",",
			keymaps = {
				["."] = "textsubjects-smart",
				[";"] = "textsubjects-container-outer",
				["i;"] = "textsubjects-container-inner",
			},
		},
	})
end

M.contextConfig = function()
	local c = try_require("treesitter-context")
	if c == nil then
		return
	end
	c.setup({
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
		min_window_height = 1, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
		line_numbers = true,
		multiline_threshold = 1, -- Maximum number of lines to show for a single context
		trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
		-- Separator between context and content. Should be a single character string, like '-'.
		-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
		separator = nil,
		zindex = 1, -- The Z-index of the context window
		on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
	})
end

-- gf 跳函数开头
local c = try_require("nvim-treesitter.configs")
if c == nil then
	return
end
c.setup({
	textobjects = {
		move = {
			enable = true,
			set_jumps = true,
			goto_previous_start = {
				["gf"] = { query = { "@function.outer" } },
			},
		},
	},
	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
	},
})

local co = try_require("ts_context_commentstring")
if co ~= nil then
	co.setup({})
end

return M

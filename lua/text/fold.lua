--
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1"

local M = {}

-- 延迟加载
M.foldConfig = function()
	local ufo = try_require("ufo")
	if ufo == nil then
		return
	end

	local ftMap = {
		vim = "indent",
		python = { "indent" },
		git = "",
	}
	ufo.setup({
		open_fold_hl_timeout = 150,
		close_fold_kinds_for_ft = { "imports" },
		preview = {
			win_config = {
				border = { "", "─", "", "", "", "─", "", "" },
				winhighlight = "Normal:Folded",
				winblend = 0,
			},
			mappings = {
				scrollU = "<C-u>",
				scrollD = "<C-d>",
				jumpTop = "[",
				jumpBot = "]",
			},
		},
		provider_selector = function(bufnr, filetype, buftype)
			-- if you prefer treesitter provider rather than lsp,
			return ftMap[filetype] or { "treesitter", "indent" }
			-- return ftMap[filetype]

			-- refer to ./doc/example.lua for detail
		end,
	})

	vim.keymap.set("n", "zR", ufo.openAllFolds)
	vim.keymap.set("n", "zM", ufo.closeAllFolds)
	-- 开启所有函数
	vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds)
	-- 折叠所有函数
	vim.keymap.set("n", "zm", ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

	-- za 折叠/开启单个函数
end

return M

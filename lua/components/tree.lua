-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- preview tree
local M = {}

M.symbolsConfig = function()
	local r = try_require("symbols-outline")
	if r == nil then
		return
	end
	r.setup()

	keymap("", "S", "<Cmd>SymbolsOutline<cr>")
end

return M

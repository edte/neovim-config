lvim.builtin.terminal.active = true

-- toggle terminal 设置
function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts) -- 切换 normal 模式
	vim.api.nvim_buf_set_keymap(0, "t", "jx", "jk<cmd>q<CR>", { noremap = true, silent = true }) -- 关闭
	-- vim.api.nvim_buf_set_keymap(0, "t", "<A-8>", '<esc><cmd>execute  v:count . "ToggleTerm"<CR>', {}) -- 切换终端
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local term = try_require("toggleterm")
if term == nil then
	return
end

term.setup({
	shell = "/opt/homebrew/bin/zsh",
})

------------------------------------keymap------------------------------------------------------------------
-- 终端
lvim.builtin.which_key.mappings["t"] = {
	'<cmd>execute  v:count . "ToggleTerm"<CR>',
	"term",
}

keymap("n", "T", '<cmd>execute  v:count . "ToggleTerm"<CR>')

keymap("t", "jk", "<esc>")

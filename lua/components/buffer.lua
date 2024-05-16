vim.opt.termguicolors = true
local buffer = try_require("bufferline")
if buffer == nil then
	return
end

-- 删除buffer
keymap("n", "c", "<cmd>bd<CR>")
keymap("n", "ch", ":BufferLineCloseLeft<cr>")
keymap("n", "cl", ":BufferLineCloseRight<cr>")
keymap("n", "co", ":BufferLineCloseOthers<cr>")
keymap("n", "<<", ":BufferLineMovePrev<cr>")
keymap("n", ">>", ":BufferLineMoveNext<cr>")

-- keymap("n", "c", ":BufferKill<CR>")

-- -- 移动左右 buffer
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>")
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>")

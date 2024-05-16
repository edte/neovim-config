------------------------------------------------------------------
--                          分屏
------------------------------------------------------------------
keymap("n", "s", "") -- 取消 s 默认功能
-- map("n", "S", "", opt)                          -- 取消 s 默认功能

-- 分屏状态下，一起滚动，用于简单的diff
-- set scrollbind
-- 恢复
-- set noscrollbind

keymap("n", "sv", ":vsp<CR>") -- 水平分屏
keymap("n", "sh", ":sp<CR>") -- 垂直分屏

keymap("n", "sc", "<C-w>c") -- 关闭当前屏幕
keymap("n", "so", "<C-w>o") -- 关闭其它屏幕

keymap("n", "s,", ":vertical resize +20<CR>") -- 向右移动屏幕
keymap("n", "s.", ":vertical resize -20<CR>") -- 向左移动屏幕

keymap("n", "sm", "<C-w>|") -- 全屏
keymap("n", "sn", "<C-w>=") -- 恢复全屏

keymap("n", "<a-,>", "<C-w>h") -- 移动到左分屏
keymap("n", "<a-.>", "<C-w>l") -- 移动到右分屏

-- 窗口切换
keymap("n", "<left>", "<c-w>h")
keymap("n", "<right>", "<c-w>l")
keymap("n", "<up>", "<c-w>k")
keymap("n", "<down>", "<c-w>j")
keymap("", "<c-h>", "<c-w>h")
keymap("", "<c-l>", "<c-w>l")

-- vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
-- vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})

-- =================================================vim option settings=======================================================
-- 设置 vim 的剪切板与系统公用
vim.opt.clipboard = "unnamedplus"

--=================================================luvar_vim general settings==============================================================
-- 日志等级
lvim.log.level = "error"

-- lvim.log.level = "trace"
-- vim.lsp.set_log_level("trace")

-- 不可见字符的显示，这里只把空格显示为一个点
vim.o.list = false
vim.o.listchars = "space:·"

vim.o.hidden = true

-- -- 恢复上次会话
-- vim.opt.sessionoptions = 'buffers,curdir,tabpages,winsize'

-- -- tab 的空格数
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- kitty 终端区分 c-i 和 tab
if vim.env.TERM == "xterm-kitty" then
	print("test")
	vim.cmd([[autocmd UIEnter * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[>1u") | endif]])
	vim.cmd([[autocmd UILeave * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[<1u") | endif]])

	vim.cmd("nnoremap <c-i> <c-i>")
	vim.cmd("nnoremap <ESC>[105;5u <C-I>")
	vim.cmd("nnoremap <Tab>        %")
	vim.cmd("noremap  <ESC>[88;5u  :!echo B<CR>")
	vim.cmd("noremap  <ESC>[49;5u  :!echo C<CR>")
	vim.cmd("noremap  <ESC>[1;5P   :!echo D<CR>")
end

-- 这段自动命令可以防止你在一个注释行中换行后，新行会继续注释的情况
autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
})

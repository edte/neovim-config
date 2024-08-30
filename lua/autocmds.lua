-- https://vi.stackexchange.com/questions/4493/what-is-the-order-of-winenter-bufenter-bufread-syntax-filetype-events

-- autocmd({ "VimLeave" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		require("plenary.profile").stop()
-- 	end,
-- })

-- 这段自动命令可以防止你在一个注释行中换行后，新行会继续注释的情况
Autocmd({ "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
	end,
	group = GroupId("comment_", { clear = true }),
})

-- 打开二进制文件
cmd([[
	" vim -b : edit binary using xxd-format!
	augroup Binary
	  autocmd!
	  autocmd BufReadPre  *.bin set binary
	  autocmd BufReadPost *.bin
	    \ if &binary
	    \ |   execute "silent %!xxd -c 32"
	    \ |   set filetype=xxd
	    \ |   redraw
	    \ | endif
	  autocmd BufWritePre *.bin
	    \ if &binary
	    \ |   let s:view = winsaveview()
	    \ |   execute "silent %!xxd -r -c 32"
	    \ | endif
	  autocmd BufWritePost *.bin
	    \ if &binary
	    \ |   execute "silent %!xxd -c 32"
	    \ |   set nomodified
	    \ |   call winrestview(s:view)
	    \ |   redraw
	    \ | endif
	augroup END
]])

-- tmux 状态栏和vim 状态栏同步
Autocmd({ "VimLeavePre", "FocusLost", "VimSuspend" }, {
	group = GroupId("tmux-status-on", { clear = true }),
	callback = function()
		vim.system({ "tmux", "set", "status", "on" }, {}, function() end)
	end,
})

Autocmd({ "FocusGained", "VimResume" }, {
	group = GroupId("tmux-status-off", { clear = true }),
	callback = function()
		vim.system({ "tmux", "set", "status", "off" }, {}, function() end)
	end,
})

vim.system({ "tmux", "set", "status", "off" }, {}, function() end)

-- -- 剪切板快捷键支持系统
-- map("v", "y", '"+y', opt)
-- map("v", "d", '"+d', opt)
-- map("v", "p", '"+p', opt)


local cmd = vim.cmd

-- p, d 不覆盖无名寄存器
-- cmd("xnoremap p pgvy")
cmd("xnoremap p P")
-- cmd('nnoremap d "_d')
-- cmd('vnoremap d "_d')

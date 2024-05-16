-- --==========================================luvar_vim keybinding settings===============================================================
-- 取消lunar的一些默认快捷键
lvim.keys.insert_mode["<A-j>"] = false
lvim.keys.insert_mode["<A-k>"] = false
lvim.keys.normal_mode["<A-j>"] = false
lvim.keys.normal_mode["<A-k>"] = false
lvim.keys.visual_block_mode["<A-j>"] = false
lvim.keys.visual_block_mode["<A-k>"] = false
lvim.keys.visual_block_mode["J"] = false
lvim.keys.visual_block_mode["K"] = false

lvim.builtin.which_key.mappings["w"] = {}
lvim.builtin.which_key.mappings["T"] = {}
lvim.builtin.which_key.mappings["D"] = {}
lvim.builtin.which_key.mappings["h"] = {}
lvim.builtin.which_key.mappings["m"] = {}
lvim.builtin.which_key.mappings["b"] = {}

-- leader 键
lvim.leader = "space"

-- 保存文件
keymap("", "<C-s>", ":w<cr>")

-- 删除整行
keymap("", "D", "Vd")

-- -- 设置 jj、jk 为 ESC,避免频繁按 esc
-- map("i", "jj", "<esc>", opt)
keymap("i", "jk", "<esc>")

-- 大小写转换
-- map("n", "<esc>", "~", opt)

-- what?
-- map("n", "<cmd>lua vim.lsp.buf.hover()<cr>", opt)

----------------------------------------------------------------
-- 取消撤销
keymap("n", "U", "<c-r>")

-- error 管理
keymap("n", "<c-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>") -- pre error
keymap("n", "<c-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>") -- next error

-- 查看文档
keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

-- 重命名
keymap("n", "R", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)

keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
keymap("n", "gr", "<cmd>Telescope lsp_references<cr>")

-- gd 跳转定义
-- gf 跳转函数头
-- gm 重命名

-- 交换 : ;

cmd("nnoremap ; :")
cmd("nnoremap : ;")

cmd("inoremap ; :")
cmd("inoremap : ;")

-- cmd("xnoremap ; :")
-- cmd("xnoremap : ;")

-- cmd("vnoremap ; :")
-- cmd("vnoremap : ;")

cmd("nnoremap <Enter> o<ESC>") -- Insert New Line quickly

cmd("xnoremap p P")

cmd("silent!")

-- cmd("nnoremap # *")
-- cmd("nnoremap * #")

-- 当你在编辑 /a/b/c/d/e.txt 文件时，由于该文件父级目录的缺失会导致该文件无法写入磁盘。此时你只需要在 cmd 中输入上面定义的命令 :MakeDirectory 即可递归的创建一系列的缺失目录
create_cmd("MakeDirectory", function()
	---@diagnostic disable-next-line: missing-parameter
	local path = vim.fn.expand("%")
	local dir = vim.fn.fnamemodify(path, ":p:h")
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	else
		vim.notify("Directory already exists", "WARN", { title = "Nvim" })
	end
end, { desc = "Create directory if it doesn't exist" })

-- 如果你安装了诸如 neotree 或 nvim-tree 这种大纲性质的插件并且它们被打开时，那么你可能希望在当前缓冲区删除的时候不会影响到现有的窗口布局。上面的自动命令 BUfferDelete 很好的完成了这件事。所以，再见 bufdelete.nvim 插件，该命令灵感来源于 NvChad 的早期版本。
create_cmd("BufferDelete", function()
	---@diagnostic disable-next-line: missing-parameter
	local file_exists = vim.fn.filereadable(vim.fn.expand("%p"))
	local modified = vim.api.nvim_buf_get_option(0, "modified")
	if file_exists == 0 and modified then
		local user_choice = vim.fn.input("The file is not saved, whether to force delete? Press enter or input [y/n]:")
		if user_choice == "y" or string.len(user_choice) == 0 then
			vim.cmd("bd!")
		end
		return
	end
	local force = not vim.bo.buflisted or vim.bo.buftype == "nofile"
	vim.cmd(force and "bd!" or string.format("bp | bd! %s", vim.api.nvim_get_current_buf()))
end, { desc = "Delete the current Buffer while maintaining the window layout" })

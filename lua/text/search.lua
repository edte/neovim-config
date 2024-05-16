-------------------------------------------------keymap------------------------------------------------------------

-- 按 esc 消除上一次的高亮
keymap("n", "<esc>", ":noh<cr>")

-- 跳转搜索，类似于 acejump
-- map("", "f", ":HopPattern<CR>", opt)

--------------------------------------------------------------------------------------------------------

-- telescope

--  隐藏文件和目录中的文件和文本搜索
local telescope = try_require("telescope")
local telescopeConfig = try_require("telescope.config")

if telescope == nil then
	return
end

if telescopeConfig == nil then
	return
end

telescope.load_extension("project")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
		preview = {
			filesize_limit = 0.1, -- MB
		},
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
})

-- 查找文件
-- keymap('n', 'f', '<Space>sf')
-- keymap("n", "f", "<cmd>Telescope git_files<cr>")

-- 查找代码
-- keymap('n', 't', '<Space>st')
keymap("n", "t", "<cmd>Telescope live_grep<cr>")

-- 打开最近打开文件
keymap("n", "e", "<cmd>Telescope oldfiles<cr>")

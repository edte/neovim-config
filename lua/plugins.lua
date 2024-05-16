-- --=================================================vim plugins install=======================================================
--
lvim.plugins = {
	--------------------------------------------ui相关------------------------------------------------------------------------------------------------
	-- 符号树状视图,按 S
	{
		"simrat39/symbols-outline.nvim",
		opts = {},
		config = function()
			local r = try_require("components.tree")
			if r ~= nil then
				r.symbolsConfig()
			end
		end,
	},

	-- 类似 VS Code 的 winbar
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- 用lua编写的平滑滚动neovim插件
	{
		"karb94/neoscroll.nvim",
		config = function()
			try_require("neoscroll").setup({})
		end,
	},

	-- 键入时出现 LSP 签名提示
	{
		"ray-x/lsp_signature.nvim",
		event = "bufread",
		config = function()
			try_require("lsp_signature").on_attach()
		end,
	},

	-- 显示代码上下文,包含函数签名
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			local r = try_require("text.jump")
			if r ~= nil then
				r.contextConfig()
			end
		end,
	},

	-------------------------------------------------------vim 基础功能增强-------------------------------------------------------------------------------------
	-- 查看 Vim 标记并与之交互的用户体验更好。
	{
		"chentoast/marks.nvim",
		config = function()
			local r = try_require("text.mark")
			if r ~= nil then
				r.marksConfig()
			end
		end,
	},

	-- 使用“.”启用重复支持的插件映射
	{
		"tpope/vim-repeat",
	},

	-- 增强 Neovim 中宏的使用。
	{
		"chrisgrieser/nvim-recorder",
		keys = {
			-- these must match the keys in the mapping config below
			{ "q", desc = " Start Recording" },
			{ "Q", desc = " Play Recording" },
		},
		config = function()
			local r = try_require("text.record")
			if r ~= nil then
				r.recoderConfig()
			end
		end,
	},

	-- 块移动
	{
		"fedepujol/move.nvim",
		config = function()
			try_require("move").setup({
				line = {
					enable = true, -- Enables line movement
					indent = true, -- Toggles indentation
				},
				block = {
					enable = true, -- Enables block movement
					indent = true, -- Toggles indentation
				},
				word = {
					enable = true, -- Enables word movement
				},
				char = {
					enable = false, -- Enables char movement
				},
			})
			-- local opts = { noremap = true, silent = true }
			-- -- Visual-mode commands
			-- vim.keymap.set("v", "<S-j>", ":MoveBlock(1)<CR>", opts)
			-- vim.keymap.set("v", "<S-k>", ":MoveBlock(-1)<CR>", opts)
			-- vim.keymap.set("v", "<S-h>", ":MoveHBlock(-1)<CR>", opts)
			-- vim.keymap.set("v", "<S-l>", ":MoveHBlock(1)<CR>", opts)
		end,
	},

	-- 扩展递增/递减 ctrl+x/a
	{
		"monaqa/dial.nvim",
		config = function()
			local r = try_require("text.number")
			if r ~= nil then
				r.numberConfig()
			end
		end,
	},

	-- vim/neovim 的多光标插件
	-- 使用 Ctrl-D 选择单词
	-- 使用 Ctrl-Down/Ctrl-Up 垂直创建光标
	-- 使用 Shift-箭头一次选择一个字符
	-- 按 n/N 获取下一个/上一个出现的情况
	-- 按 [/] 选择下一个/上一个光标
	-- 按 q 跳过当前并获取下一个出现的位置
	-- 按 Q 删除当前光标/选择
	-- 使用 i,a,I,A 启动插入模式
	{
		"mg979/vim-visual-multi",
		branch = "master",
		init = function()
			vim.g.VM_maps = {
				["Find Under"] = "<C-d>",
			}
		end,
	},

	-- 不是天空中的 UFO，而是 Neovim 中的超级折叠。 za
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		config = function()
			local r = try_require("text.fold")
			if r ~= nil then
				r.foldConfig()
			end
		end,
	},

	-- vim match-up：% 更好的导航和突出显示匹配单词现代 matchit 和 matchparen。支持 vim 和 neovim + tree-sitter。
	{
		"andymass/vim-matchup",
		init = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},

	-- 语法感知文本对象、选择、移动、交换和查看支持。
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			local r = try_require("text.jump")
			if r ~= nil then
				r.textConfig()
			end
		end,
	},

	-- 文本对象增强
	{
		"RRethy/nvim-treesitter-textsubjects",
		lazy = true,
		event = { "User FileOpened" },
		after = "nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			local r = try_require("text.jump")
			if r ~= nil then
				r.textsubjectsConfig()
			end
		end,
	},

	-- "重构"模块，用于nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter-refactor",
	},

	{
		"chrisgrieser/nvim-various-textobjs",
		lazy = true,
		event = { "User FileOpened" },
		config = function()
			try_require("various-textobjs").setup({
				useDefaultKeymaps = true,
				lookForwardLines = 10,
			})
			-- example: `an` for outer subword, `in` for inner subword
			vim.keymap.set({ "o", "x" }, "aS", function()
				try_require("various-textobjs").subword(false)
			end)
			vim.keymap.set({ "o", "x" }, "iS", function()
				try_require("various-textobjs").subword(true)
			end)
		end,
	},

	-- 单选项卡界面可轻松循环浏览任何 git rev 的所有修改文件的差异。
	{
		"sindrets/diffview.nvim",
		event = "bufread",
	},

	-- 展示颜色
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			local r = try_require("text.color")
			if r ~= nil then
				r.colorConfig()
			end
		end,
	},

	-- 一个 Neovim 插件，用于将 vscode 风格的 TailwindCSS 补全添加到 nvim-cmp
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		-- optionally, override the default options:
		config = function()
			try_require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},

	--HACK:
	--TODO:
	--FIX:
	--NOTE:
	--WARNING:
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		config = function()
			try_require("todo-comments").setup({})

			local telescope = try_require("telescope")
			if telescope == nil then
				return
			end
			telescope.setup({
				extensions = {
					["todo-comments"] = {},
				},
			})
			telescope.load_extension("todo-comments")

			del_cmd("TodoQuickFix")
			del_cmd("TodoTelescope")
			del_cmd("TodoTrouble")
			del_cmd("TodoLocList")

			cmd("command! -nargs=* Todo Telescope todo-comments todo <args>")
		end,
	},

	-- 长按j k 加速
	{
		"rainbowhxch/accelerated-jk.nvim",
		config = function()
			vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
			vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
		end,
	},

	-- 轻松添加/更改/删除周围的分隔符对。用Lua ❤️ 编写。
	--add:    ys{motion}{char},
	--delete: ds{char},
	--change: cs{target}{replacement},

	--     Old text                    Command         New text
	-- --------------------------------------------------------------------------------
	--     surr*ound_words             ysiw)           (surround_words)
	--     *make strings               ys$"            "make strings"
	--     [delete ar*ound me!]        ds]             delete around me!
	--     remove <b>HTML t*ags</b>    dst             remove HTML tags
	--     'change quot*es'            cs'"            "change quotes"
	--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
	--     delete(functi*on calls)     dsf             function calls

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			try_require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	-- gx 打开 URL
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1 -- disable netrw gx
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true, -- default settings

		-- you can specify also another config if you want
		config = function()
			try_require("gx").setup({
				open_browser_app = "open", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
				open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
				handlers = {
					plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
					github = true, -- open github issues
					brewfile = true, -- open Homebrew formulaes and casks
					package_json = true, -- open dependencies from package.json
					search = true, -- search the web/selection on the web if nothing else is found
				},
				handler_options = {
					search_engine = "google", -- you can select between google, bing, duckduckgo, and ecosia
					search_engine = "https://search.brave.com/search?q=", -- or you can pass in a custom search engine
				},
			})
		end,
	},

	-- 用于对齐线的 NeoVim 的最小插件
	-- 用于无lsp和null的一些文本
	{
		"Vonr/align.nvim",
		branch = "v2",
		lazy = true,
		init = function()
			local r = try_require("text.align")
			if r ~= nil then
				r.aliginConfig()
			end
		end,
	},

	------------------------------------------------------代码相关-----------------------------------------------------------------------------------------------

	--lsp 配置
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"SmiteshP/nvim-navbuddy",
				dependencies = {
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
				opts = {
					lsp = { auto_attach = true },
				},
			},
		},

		config = function()
			local r = try_require("code.lsp")
			if r ~= nil then
				r.lspConfig()
			end
		end,
	},

	-------------------------------------------------------代码补全相关------------------------------------------------------------------------------------------

	-- Clanalphagd 针对 neovim 的 LSP 客户端的不合规范的功能。使用 https://sr.ht/~p00f/clangd_extensions.nvim 代替
	{ "p00f/clangd_extensions.nvim" },
	{ "lukas-reineke/cmp-under-comparator" },
	{
		"ray-x/cmp-treesitter",
	},

	-- 使用treesitter自动关闭并自动重命名html标签
	{ "windwp/nvim-ts-autotag" },

	-- wilder.nvim 插件，用于命令行补全，和 noice.nvim 冲突
	{
		"gelguy/wilder.nvim",
		event = "CmdlineEnter", -- 懒加载：首次进入cmdline时载入
		config = try_require("components.wilder").wilderFunc,
	},

	-- TabNine ai 补全
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		dependencies = "hrsh7th/nvim-cmp",
	},
	-- 单词补全
	{
		"uga-rosa/cmp-dictionary",
	},

	{
		"hrsh7th/cmp-calc",
	},
	{
		"hrsh7th/cmp-emoji",
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			try_require("crates").setup()
		end,
	},
	{
		"hrsh7th/cmp-nvim-lua",
	},

	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
	},

	{
		"hrsh7th/cmp-omni",
	},

	-- -- 语言字典补全
	-- {
	--     'skywind3000/vim-dict'
	-- },

	-- {
	--     "f3fora/cmp-spell",
	--     config = function()
	--         vim.opt.spell = true
	--         vim.opt.spelllang:append "en_us"
	--     end,
	-- },

	-- {
	--     'andersevenrud/cmp-tmux'
	-- },
	-- {
	--     'petertriho/cmp-git'
	-- },

	-- { 'tzachar/cmp-ai',        dependencies = 'nvim-lua/plenary.nvim' },
	-- { 'hrsh7th/nvim-cmp',      dependencies = { 'tzachar/cmp-ai' } },

	-- {
	--     'tzachar/cmp-fuzzy-path',
	--     dependencies = { 'tzachar/fuzzy.nvim' },
	-- },
	-- {
	--     'tzachar/cmp-fuzzy-buffer',
	--     dependencies = { 'tzachar/fuzzy.nvim' },
	-- },

	-- 计算器
	-- {
	--     'hrsh7th/cmp-calc',
	--     config = function()
	--         require 'cmp'.setup {
	--             sources = {
	--                 { name = 'calc' },
	--             },
	--         }
	--     end
	-- },

	---------------------------------------------其他---------------------------------------------------------------------------------------------------------
	-- fzf 搜索
	-- 第一个别删
	{ "junegunn/fzf" },
	{ "junegunn/fzf.vim" },

	-- 将当前工作目录更改为项目的根目录。
	-- {
	--     "ahmedkhalf/lsp-rooter.nvim",
	--     event = "bufread",
	--     config = function()
	--         require("lsp-rooter").setup()
	--     end,
	-- },

	-- 提供 project 支持
	{
		"nvim-telescope/telescope-project.nvim",
	},

	-------------------------------------------------------------语言相关---------------------------------------------------------------------------------------

	-- jce 高亮
	{ "edte/jce-highlight" },

	-- go 接口插件
	{
		"edolphin-ydf/goimpl.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			local r = try_require("code.go")
			if r ~= nil then
				r.implConfig()
			end
		end,
	},

	-- go 插件
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			local r = try_require("code.go")
			if r ~= nil then
				r.goConfig()
			end
		end,

		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},

	-- 中文排版自动规范化的 Vim 插件
	-- { "hotoo/pangu.vim" },

	{
		"luozhiya/fittencode.nvim",
		config = function()
			vim.opt.updatetime = 200
			require("fittencode").setup({
				completion_mode = "source",
			})
		end,
	},
	-- Neovim 中人类可读的内联 cron 表达式
	{
		"fabridamicelli/cronex.nvim",
		opts = {},
		config = function()
			local r = try_require("text.cron")
			if r ~= nil then
				r.cronConfig()
			end
		end,
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}

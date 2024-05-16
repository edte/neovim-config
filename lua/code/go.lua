local M = {}

M.goConfig = function()
	local go = try_require("go")
	if go == nil then
		return
	end
	go.setup()
	-- gn生成返回值
	keymap("", "gn", "<Cmd>GoGenReturn<cr>")
	-- gf填充struct
	keymap("", "gt", "<Cmd>GoFillStruct<cr>")

	create_cmd("GoAddTagEmpty", function(input)
		vim.api.nvim_command(":GoAddTag json -add-options json=")
	end, { nargs = "*" })
end

M.implConfig = function()
	local tele = try_require("telescope")
	if tele == nil then
		return
	end

	tele.load_extension("goimpl")

	-- 实现go接口
	keymap("n", "<leader>mm", [[<cmd>lua try_require'telescope'.extensions.goimpl.goimpl{}<CR>]])

	-- 实现go接口
	keymap("n", "gI", "<cmd>lua try_require'telescope'.extensions.goimpl.goimpl{}<CR>")
end

return M

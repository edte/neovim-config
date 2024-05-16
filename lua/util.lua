-- 使用 pcall 和 require 尝试加载包
function try_require(package_name)
	local status, plugin = pcall(require, package_name)
	if not status then
		-- 如果加载失败，打印错误信息
		print("require " .. plugin)
		return nil
	else
		-- 如果加载成功，返回包
		return plugin
	end
end

local opt = {
	noremap = true,
	silent = true,
}

function keymap(mode, lhs, rhs)
	vim.api.nvim_set_keymap(mode, lhs, rhs, opt)
end

create_cmd = vim.api.nvim_create_user_command

cmd = vim.cmd

autocmd = vim.api.nvim_create_autocmd

del_cmd = vim.api.nvim_del_user_command

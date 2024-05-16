-- 记录当前输入法
Current_input_method = vim.fn.system("im-select")

-- 切换到英文输入法
function Switch_to_English_input_method()
	Current_input_method = vim.fn.system("im-select")
	if Current_input_method ~= "com.apple.keylayout.ABC\n" then
		vim.fn.system("im-select com.apple.keylayout.ABC")
	end
end

-- 设置输入法
function Set_input_method()
	if Current_input_method ~= "com.apple.keylayout.ABC\n" then
		vim.fn.system("im-select " .. string.gsub(Current_input_method, "\n", ""))
	end
end

-- 进入normal模式时切换为英文输入法
vim.cmd([[
augroup input_method
  autocmd!
  autocmd InsertEnter * :lua Set_input_method()
  autocmd InsertLeave * :lua Switch_to_English_input_method()
augroup END
]])

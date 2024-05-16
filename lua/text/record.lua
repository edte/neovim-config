local M = {}

-- 延迟加载
M.recoderConfig = function()
	local recoder = try_require("recorder")
	if recoder == nil then
		return
	end

	recoder.setup({
		mapping = {
			startStopRecording = "q",
			playMacro = "Q",
		},
	})
end

return M

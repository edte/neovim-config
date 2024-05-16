-- 参数提示
-- keymap("n", "J", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
-- keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>")

keymap("n", "gd", '<cmd>Telescope lsp_definitions<cr>')
keymap("n", "gr", '<cmd>Telescope lsp_references<cr>')

-- 查看文档
keymap("n", "K", '<cmd>lua vim.lsp.buf.hover()<cr>')

-- error 管理
keymap("n", "<c-p>", "<cmd>lua vim.diagnostic.goto_prev()<cr>") -- pre error
keymap("n", "<c-n>", "<cmd>lua vim.diagnostic.goto_next()<cr>") -- next error
-- keymap("n", "<c-e>", "<cmd>Trouble<cr>")                             -- show error

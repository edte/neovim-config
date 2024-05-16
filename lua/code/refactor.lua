try_require 'nvim-treesitter.configs'.setup {
    refactor = {
        -- 高亮显示光标下当前符号的定义和用法。
        highlight_definitions = {
            enable = true,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = true,
        },

        -- 强调块从目前的范围在哪里的光标。
        -- highlight_current_scope = { enable = true },

        -- 重命名当前作用域（和当前文件）内光标下的符号。
        smart_rename = {
            enable = true,
            -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
            keymaps = {
                smart_rename = "gm",
                -- smart_rename = false,
            },
        },

        -- 为光标下的符号提供 "转到定义"，并列出当前文件中的定义。
        -- 如果 nvim-treesitter 无法解析变量，则使用 vim.lsp.buf.definition 代替下面配置中的 goto_definition_lsp_fallback。
        -- goto_next_usage/goto_previous_usage 将转到光标下标识符的下一个用法。
        navigation = {
            enable = true,
            -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
            keymaps = {
                -- goto_definition = "gm",
                -- list_definitions = "gnD",
                -- list_definitions_toc = "gO",
                -- goto_next_usage = "<c-n>",
                -- goto_previous_usage = "<c-p>",
            },
        },


    },
}

-- 重命名
-- map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)

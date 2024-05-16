-- -- 进入 buffer 时，如果缺失了 parser,则自动下载
lvim.builtin.treesitter.auto_install                    = true

-- --
lvim.lsp.installer.setup.automatic_servers_installation = true

lvim.builtin.treesitter.highlight.enabled               = true
lvim.builtin.treesitter.ensure_installed                = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
    "go",
    "cpp",
    "vue",
}

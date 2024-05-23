require 'nvim-treesitter.install'.prefer_git = true


require 'nvim-treesitter.configs'.setup {
    sync_install = false,
    ignore_install = {},
    ensure_installed = {},
    modules = {},
    auto_install = true,

    highlight = {
        enable = true,
    },
}

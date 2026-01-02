require 'nvim-treesitter'.install { 'rust' }

require 'nvim-treesitter'.setup {
    sync_install = false,
    ignore_install = {},
    ensure_installed = {},
    modules = {},
    auto_install = true,

    highlight = {
        enable = true,
    },
}

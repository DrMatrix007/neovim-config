local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)



    -- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

require("nvim-tree").setup {
    on_attach = my_on_attach,
}

-- custom mappings
vim.keymap.set('n', '<leader>e', function() vim.cmd("NvimTreeToggle") end, { desc = "Toggle nvim tree" })
vim.keymap.set('n', '<leader>o', function()
    print(vim.bo.filetype)
    if vim.bo.filetype == "NvimTree" then
        vim.cmd.wincmd "p"
    else
        vim.cmd "NvimTreeFocus"
    end
end, { desc = "Toggle focus nvim tree" })

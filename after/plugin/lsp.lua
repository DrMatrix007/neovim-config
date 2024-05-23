require("mason").setup()
require("mason-lspconfig").setup()
local lsp = require 'lsp-zero'

lsp.preset('recommended')




local cmp = require('cmp')
local luasnip = require('luasnip')


local function has_words_before()
    local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup({
    on_attach = function()
    end,
    sources = {
        { name = 'nvim_lsp' },
    },
    view = {
        entries = {
            -- vertical_positioning = 'auto'
        }
    },
    window = {
        documentation = cmp.config.window.bordered(),
        completion = cmp.config.window.bordered(),
    },
    mapping = {
        ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable,
        ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
        ["<CR>"] = cmp.mapping.confirm { select = false },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})


local function on_attach(client, _)
    vim.keymap.set("n", "<leader>ld", function()
        vim.diagnostic.open_float()
    end, { desc = "Open Diagnostic" })

    vim.keymap.set("n", "<leader>lD", function() require("telescope.builtin").diagnostics() end,
        { desc = "All Diagnostics" })

    vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP information" })
    if client.supports_method "textDocument/codeAction" then
        vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "Code action" })
    end
    if client.supports_method "textDocument/formatting" then
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, { desc = "Format" })
    end
end






require('lspconfig').rust_analyzer.setup {
    --filetypes = { "rust" },
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true
            },
            check = {
                command = "clippy"
            }
        },
    }
}

require('lspconfig').lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

require("lspconfig").html.setup{}

require("lspconfig").tsserver.setup{}

require("lspconfig").svelte.setup{}


require("lspconfig").jsonls.setup{}

require("lspconfig").prismals.setup{}
--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
--vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
--vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),

    callback = function(ev)
        vim.keymap.set('n', '<space>ld', vim.diagnostic.open_float, { desc = "Open Diagnostic" })
        vim.keymap.set('n', '<space>lD', function() require("telescope.builtin").diagnostics() end, { desc = "All Diagnostics" })

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local buffer = ev.buf
        vim.keymap.set('n', '<leader>ljc', vim.lsp.buf.declaration, { buffer = buffer, desc = "Jmp declaration" })
        vim.keymap.set('n', '<leader>ljf', vim.lsp.buf.definition, { buffer = buffer, desc = "Jmp definition" })
        vim.keymap.set('n', '<leader>lH', vim.lsp.buf.hover, { buffer = buffer, desc = "Hover" })
        --vim.keymap.set('n', '<leader>', vim.lsp.buf.implementation, {buffer = buffer,desc = ""})
        vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help, { buffer = buffer, desc = "Signature help" })
        --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, {buffer = buffer,desc = ""})
        --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, {buffer = buffer,desc = ""})
        --vim.keymap.set('n', '<space>wl', function()
        --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        --end, {buffer = buffer,desc = ""})
        vim.keymap.set('n', '<leader>lt', vim.lsp.buf.type_definition, { buffer = buffer, desc = "Type definition" })
        vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, { buffer = buffer, desc = "Rename" })
        vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, { buffer = buffer, desc = "Code Action" })
        vim.keymap.set('n', '<leader>lR', vim.lsp.buf.references, { buffer = buffer, desc = "References" })
        vim.keymap.set('n', '<leader>lf', function()
            vim.lsp.buf.format { async = true }
        end, { buffer = buffer, desc = "Format Document" })
    end,
})

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
    on_attach = function ()
    end,
    sources = {
        {name = 'nvim_lsp'},
    },
        window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
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


local function on_attach(client,bufnr)
    

    vim.keymap.set("n","<leader>ld",function ()
        vim.diagnostic.open_float()
    end,{desc = "Open Diagnostic"})

    vim.keymap.set("n","<leader>lD",function() require("telescope.builtin").diagnostics() end,{desc = "All Diagnostics"})

    vim.keymap.set("n","<leader>li", "<cmd>LspInfo<cr>", {desc = "LSP information"})
    if client.supports_method "textDocument/codeAction" then
        vim.keymap.set("n","<leader>la",  function() vim.lsp.buf.code_action() end,{desc = "Code action"})
    end
     if client.supports_method "textDocument/formatting" then
        vim.keymap.set("n","<leader>lf",  function() vim.lsp.buf.format() end,{desc = "Format"})
     end
end






require('lspconfig').rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"rust"},
  settings = {
    ["rust-analyzer"] = {
      cargo= {
        allFeatures=true
      },
      check= {
        command = "clippy"
      }
    },
  }
}

require('lspconfig').lua_ls.setup({
	settings = {
		Lua  ={
			diagnostics = {
				globals = {'vim'}
			}
		}
	}
})

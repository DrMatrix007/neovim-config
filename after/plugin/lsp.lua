local lsp_zero = require('lsp-zero')


lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
    print("started lsp: " .. client.name)

	vim.keymap.set('n', '<space>ld', vim.diagnostic.open_float, { desc = "Open Diagnostic" })
	vim.keymap.set('n', '<space>lD', function() require("telescope.builtin").diagnostics() end,
		{ desc = "All Diagnostics" })

	-- Enable completion triggered by <c-x><c-o>
	vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

	-- Buffer local mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local buffer = bufnr
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

	vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
end)

require("neodev").setup({})

require('mason').setup({})


require'lspconfig'.rust_analyzer.setup {
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
require('mason-lspconfig').setup({
	ensure_installed = {},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
})

local cmp = require('cmp')

cmp.setup({
	sources = {
		{ name = 'nvim_lsp' },
	},
	mapping = {
		['<cr>'] = cmp.mapping.confirm({ select = false }),
		['<C-e>'] = cmp.mapping.abort(),
		['<Up>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
		['<Down>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
		['<C-Tab>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item({ behavior = 'insert' })
			else
				cmp.complete()
			end
		end),
		['<C-Space>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item({ behavior = 'insert' })
			else
				cmp.complete()
			end
		end),
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})

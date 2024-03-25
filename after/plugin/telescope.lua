local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "find files"})
vim.keymap.set('n', '<leader>fw', function()
	builtin.grep_string({search=vim.fn.input("Grep > ") })
end,{desc = "find words"})
--vim.keymap.set('n', '<leader>gff', builtin.git_files, {})


vim.g.mapleader = " "

--vim.keymap.set("n","<leader>e",vim.cmd.Ex)

vim.keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Move Beginning of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "Move End of line" })
vim.keymap.set("n", "<C-b>", "^", { desc = "Move Beginning of line" })
vim.keymap.set("n", "<C-e>", "i<End><ESC>", { desc = "Move End of line" })
vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move Left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move Right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move Down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move Up" })


vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Switch Window left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Switch Window right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Switch Window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Switch Window up" })

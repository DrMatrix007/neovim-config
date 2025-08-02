
vim.opt.nu = true
vim.opt.relativenumber= true

vim.opt.tabstop = 4
vim.softabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false;

vim.opt.swapfile = false;
vim.opt.backup = false;
if os.getenv("HOME") ~= nil then
    vim.opt.undodir = os.getenv("HOME") .. "/.neovim/undodir"
end
vim.opt.undofile = true

vim.opt.hlsearch = false;
vim.opt.incsearch = true;

vim.opt.scrolloff = 8;
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.clipboard:append("unnamedplus")



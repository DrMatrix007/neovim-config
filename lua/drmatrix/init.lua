require("drmatrix.remap")
require("drmatrix.set")
vim.cmd[[colorscheme tokyonight]]
print("drmatrix")

require("tokyonight").setup({
	style = "night",
	transparent = true,
	styles= {
		sidebars = "transparent",
		floats = "transparent",
	}
})
function ColorBack(color)
	color = color or "tokyonight"
	vim.cmd.colorscheme(color)

	--vim.api.nvim_set_hl(0,"Normal", {bg="none"});
	--vim.api.nvim_set_hl(0,"NormalFloat", {bg="none"});

end

ColorBack();


vim.opt.clipboard = "unnamedplus"

--setup treesitter
local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if ok then
	treesitter.setup({
		ensure_installed = { "typescript", "css", "javascript", "svelte" },
		highlight = { enable = true },
	})
end

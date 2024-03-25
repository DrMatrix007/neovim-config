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



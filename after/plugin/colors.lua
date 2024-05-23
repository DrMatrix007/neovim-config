function ColorNvim(color) 
	color = color or 'onedark'
	vim.cmd.colorscheme(color)
end

ColorNvim()


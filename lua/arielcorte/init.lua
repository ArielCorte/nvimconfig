require("arielcorte.set")
require("arielcorte.remap")

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup("ThePrimeagen", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

local FormatAutoGroup = augroup("FormatAutoGroup", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = ThePrimeagenGroup,
	pattern = "*",
	command = "%s/\\s\\+$//e",
})

-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25

autocmd({ "BufWritePost" }, {
	group = FormatAutoGroup,
	pattern = "*",
	command = "FormatWrite",
})

autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

vim.opt_local.makeprg = "make config=debug_arm64"

local project_root = vim.fn.getcwd()

vim.keymap.set("n", "<leader>bb", "<cmd>make<CR>", {
	buffer = true,
	desc = "Build debug (ARM64)",
})

vim.keymap.set("n", "<leader>br", function()
	local binary = project_root .. "/bin/Debug/" .. vim.fn.fnamemodify(project_root, ":t")
	vim.cmd("terminal " .. binary)
end, {
	buffer = true,
	desc = "Run game binary",
})

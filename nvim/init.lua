require("config.lazy")
vim.opt.number = true
vim.opt.wrap = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.clipboard = "unnamedplus"
vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true
vim.opt.termguicolors = true

vim.cmd.colorscheme("kanagawa-wave")
vim.diagnostic.config({ virtual_text = true })

-- Neovim
vim.keymap.set("n", "<Esc>", ":noh<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "q", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>qq", ":qa<CR>", { desc = "Quit neovim" })

-- nvim-tree
vim.keymap.set("n", "<leader>fe", ":NvimTreeFindFile<CR>", { desc = "Find current file in NvimTree" })
vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = "Focus NvimTree" })

-- window navigation
vim.keymap.set({ "n", "i", "v", "t" }, "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })
vim.keymap.set({ "n", "i", "v", "t" }, "<C-j>", "<C-w><C-j>", { desc = "Move to bottom window" })
vim.keymap.set({ "n", "i", "v", "t" }, "<C-k>", "<C-w><C-k>", { desc = "Move to top window" })
vim.keymap.set({ "n", "i", "v", "t" }, "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })
vim.keymap.set("t", "<C-h>", "<C-\\><C-w><C-h>", { desc = "Move to left window" })
vim.keymap.set("t", "<C-j>", "<C-\\><C-w><C-j>", { desc = "Move to bottom window" })
vim.keymap.set("t", "<C-k>", "<C-\\><C-w><C-k>", { desc = "Move to top window" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-w><C-l>", { desc = "Move to right window" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { desc = "Rename variable" })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

--Terminal
local function toggle_terminal()
    for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
        local buffer_name = vim.api.nvim_buf_get_name(buffer)
        if (string.sub(buffer_name, 1, 7) == "term://") then
            local window_id = vim.fn.getbufinfo(buffer)[1].windows[1]
            if (window_id ~= nil) then
                if (vim.fn.win_getid() == window_id) then
                    vim.cmd.close()
                    return
                else
                    vim.fn.win_gotoid(window_id)
                    return
                end
            else
                vim.cmd.sbuffer(buffer)
                vim.cmd.resize(10)
                return
            end
        end
    end
    vim.cmd.split("term://zsh")
    vim.cmd.resize(10)
end

vim.keymap.set({ "n", "i", "v", "t" }, "<C-`>", toggle_terminal, { desc = "Open terminal window" })

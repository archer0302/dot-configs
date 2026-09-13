-- Git: gitsigns (inline hunks) + diffview (branch/PR review)

vim.pack.add({
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/sindrets/diffview.nvim',
})

require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end
    -- Hunk navigation
    map('n', ']c', function() gs.nav_hunk('next') end, 'Next git hunk')
    map('n', '[c', function() gs.nav_hunk('prev') end, 'Prev git hunk')
    -- Hunk actions
    map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
    map('n', '<leader>gs', gs.stage_hunk, 'Stage hunk')
    map('n', '<leader>gr', gs.reset_hunk, 'Reset hunk')
    map('n', '<leader>gb', function() gs.blame_line({ full = true }) end, 'Blame line')
  end,
})

-- Diffview: review the working tree, a branch/PR range, or file history
vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<CR>', { silent = true, desc = 'Diffview: working tree' })
vim.keymap.set('n', '<leader>gm', ':DiffviewOpen main...HEAD<CR>', { silent = true, desc = 'Diffview: branch vs main' })
vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory %<CR>', { silent = true, desc = 'Diffview: file history' })
vim.keymap.set('n', '<leader>gc', ':DiffviewClose<CR>', { silent = true, desc = 'Diffview: close' })

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- for zig remap
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- FIXME: IF NOT USE REMOVE IT
--
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
--vim.keymap.set("n", "<leader>f", function()
--    require("conform").format({ bufnr = 0 })
--end)


vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/ppp_p/packer.lua<CR>");

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)


-- Golang keymap error
vim.keymap.set(
    "n",
    "<leader>ea",
    "oassert.NoError(err, \"\")<Esc>F\";a"
)

vim.keymap.set(
    "n",
    "<leader>ef",
    "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj"
)

vim.keymap.set(
    "n",
    "<leader>el",
    "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
)

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Emacs windows key binding
-- C-x 1 -> keep only current window
vim.keymap.set('n', '<C-x>1', '<C-w>o', { noremap = true })
-- C-x 0 -> close current window
vim.keymap.set('n', '<C-x>0', '<C-w>c', { noremap = true })
-- C-x 2 -> horizontal split
vim.keymap.set('n', '<C-x>2', '<C-w>s', { noremap = true })
-- C-x 3 -> vertical split
vim.keymap.set('n', '<C-x>3', '<C-w>v', { noremap = true })

-- Explicit bindings for clarity
vim.keymap.set('n', '<C-x>o', '<C-w>w', { noremap = true }) -- next window
vim.keymap.set('n', '<C-x>O', '<C-w>W', { noremap = true }) -- previous window

-- Swap buffers between current and next/previous window
local function transpose_buffers(direction)
  local wins = vim.api.nvim_tabpage_list_wins(0)  -- all windows in current tab
  if #wins < 2 then
    return
  end

  local cur_win = vim.api.nvim_get_current_win()
  local cur_buf = vim.api.nvim_win_get_buf(cur_win)

  -- find index of current window
  local cur_idx = nil
  for i, w in ipairs(wins) do
    if w == cur_win then
      cur_idx = i
      break
    end
  end

  if not cur_idx then return end

  -- choose target window index
  local target_idx
  if direction == "next" then
    target_idx = (cur_idx % #wins) + 1
  else
    target_idx = (cur_idx - 2 + #wins) % #wins + 1
  end

  local target_win = wins[target_idx]
  local target_buf = vim.api.nvim_win_get_buf(target_win)

  -- swap buffers
  vim.api.nvim_win_set_buf(cur_win, target_buf)
  vim.api.nvim_win_set_buf(target_win, cur_buf)

  -- move focus to target window
  vim.api.nvim_set_current_win(target_win)
end

-- Keymaps (Emacs style)
vim.keymap.set("n", "<C-x>4t", function() transpose_buffers("next") end, { noremap = true })
vim.keymap.set("n", "<C-x>4T", function() transpose_buffers("prev") end, { noremap = true })

-- Insert datetime
vim.keymap.set("n", "<leader>D", function()
  --vim.cmd("normal! a" .. os.date("(%Y%m%d-%H%M%S)"))
  -- Local time not utc
  -- vim.api.nvim_put({ os.date("(%Y%m%d-%H%M%S)") }, "c", true, true)
  vim.api.nvim_put({ os.date("!(%Y%m%d-%H%M%S)") }, "c", true, true) -- UTC
end, { noremap = true, silent = true })

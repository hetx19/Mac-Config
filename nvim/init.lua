-- ================================
-- 🔹 Competitive Programming Neovim Setup
-- ================================

vim.g.mapleader = " "

-- Safely require your modules
pcall(require, "het.core")
pcall(require, "het.lazy")
pcall(require, "het.lsp")

-- Load CP module
pcall(function()
    require("het.cp").setup()
end)

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

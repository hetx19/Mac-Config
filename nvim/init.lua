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

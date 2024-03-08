-- return {
--   "github/copilot.vim",
--   event = { "BufReadPre", "BufNewFile" },
-- }
--
return {
  "zbirenbaum/copilot.lua",
  event = { "InsertEnter" },
  cmd = "Copilot",
  build = ":Copilot auth",
  opts = {
    suggestion = { enabled = true, auto_trigger = true },
    panel = { enabled = false },
    -- filetypes = {
    --   markdown = true,
    --   help = true,
    -- },
  },

  config = function()
    require("copilot").setup({})
  end,
}

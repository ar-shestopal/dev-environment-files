-- return {
--   "github/copilot.vim",
--   event = { "BufReadPre", "BufNewFile" },
-- }
--
return {
  "zbirenbaum/copilot.lua",
  event = { "InsertEnter", "BufReadPre", "BufNewFile" },
  cmd = "Copilot",
  build = ":Copilot auth",
  opts = {
    panel = { enabled = false },
    -- filetypes = {
    --   markdown = true,
    --   help = true,
    -- },
  },

  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
      },
    })
  end,
}

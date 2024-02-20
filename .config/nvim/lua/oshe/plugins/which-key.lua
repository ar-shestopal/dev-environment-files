return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function(_, _)
    local wk = require("which-key")
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    wk.setup()

    wk.register({
      ["<leader>"] = {
        -- Harpoon
        h = {
          name = "harpoon",
          a = { mark.add_file, "Add file to harpoon" },
          l = { ui.toggle_quick_menu, "Toggle quick menu" },
          r = { mark.rm_file, "Remove file from harpoon" },
          c = { mark.clear_all, "Clear all harpoon marks" },
        },
      },
    })
  end,
}

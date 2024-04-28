return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },

      file_ignore_patterns = {},
    })

    telescope.load_extension("fzf")

    -- Custom file finder to include files with line numbers
    local function find_files_with_line_numbers(opts)
      local entries = {}

      -- Run a custom command to list files
      local command = "find . -type f"
      local filelist = vim.fn.systemlist(command)

      for _, file in ipairs(filelist) do
        -- Check if the file name contains a line number
        local file, line_number = file:match("^(.-):(%d+)$")
        if file then
          -- Add file with line number to the list of entries
          table.insert(entries, {
            value = file,
            ordinal = file,
            display = string.format("%s:%s", file, line_number),
            filename = file,
            lnum = tonumber(line_number),
          })
        else
          -- Add regular file to the list of entries
          table.insert(entries, {
            value = file,
            ordinal = file,
            display = file,
            filename = file,
          })
        end
      end

      -- Return the list of entries
      return entries
    end

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local builtin = require("telescope.builtin")

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<C-p>", "<cmd> Telescope git_files<cr>", { desc = "Find git files" })
    keymap.set("n", "<leader>ps", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)

    -- Custom entry maker to parse file paths with line numbers
    local function make_file_entry(entry) end

    keymap.set("n", "<leader>ft", function()
      builtin.find_files({
        entry_maker = function(entry)
          local file, line_number = entry:match("^(.-):(%d+)$")
          if file then
            return {
              ordinal = file,
              display = string.format("%s:%s", file, line_number),
              filename = file,
              lnum = tonumber(line_number),
            }
          else
            return {
              ordinal = entry,
              display = entry,
              filename = entry,
              lnum = 10,
            }
          end
        end,
      })
    end)
    -- local builtin = require('telescope.builtin')
    -- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    -- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    -- vim.keymap.set('n', '<leader>ps', function()
    -- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
    -- end)
    -- vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end,
}

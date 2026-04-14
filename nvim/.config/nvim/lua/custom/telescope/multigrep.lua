local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require("telescope.config").values

local M = {}

local cached_glob = ""

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, "  ")
      local search = pieces[1]

      if not search or search == "" then
        return nil
      end

      local glob = pieces[2]
      if glob and glob ~= "" then
        cached_glob = glob
      end

      local args = { "rg", "-e", search }
      if glob and glob ~= "" then
        table.insert(args, "-g")
        table.insert(args, glob)
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden" },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  local default_text = cached_glob ~= "" and ("  " .. cached_glob) or ""

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "Search  |  Glob",
      default_text = default_text,
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty {},
      attach_mappings = function()
        vim.schedule(function()
          local keys = vim.api.nvim_replace_termcodes("<Home>", true, false, true)
          vim.api.nvim_feedkeys(keys, "n", false)
        end)
        return true
      end,
    })
    :find()
end

M.live_multigrep = live_multigrep

return M

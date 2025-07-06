local M = {}

local Job = require 'plenary.job'

local notify = require 'notify'

local function fetch_quote(callback)
  Job:new({
    command = 'curl',
    args = { '-s', 'https://zenquotes.io/api/random' },
    on_exit = function(j, return_val)
      vim.schedule(function()
        if return_val ~= 0 then
          callback(nil)
          return
        end

        local result = table.concat(j:result(), '')
        local success, data = pcall(vim.fn.json_decode, result)

        if success and data and data[1] then
          callback(data[1].q .. ' - ' .. data[1].a)
        else
          callback(nil)
        end
      end)
    end,
  }):start()
end

local function show_inspiration()
  fetch_quote(function(quote)
    if quote then
      notify(quote, vim.log.levels.INFO, {
        title = 'Inpiration',
        timeout = 9000,
        max_width = math.floor(vim.o.columns * 0.9),
        render = 'wrapped-compact',
      })
    else
      notify('Failed to fetch quote', vim.log.levels.ERROR)
    end
  end)
end

local function setup_user_commands()
  vim.api.nvim_create_user_command('Insp', function()
    show_inspiration()
  end, {})
end

M.setup = function()
  setup_user_commands()
end

return M

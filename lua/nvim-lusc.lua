local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local assert = _tl_compat and _tl_compat.assert or assert
local lusc = require("lusc")

local VimSchedulerAdapter = {}



function VimSchedulerAdapter.new()
   return setmetatable(
   {
      _impl = lusc.DefaultScheduler.new(),
   },
   { __index = VimSchedulerAdapter })
end

function VimSchedulerAdapter:schedule(delay_seconds, callback)
   self._impl:schedule(delay_seconds, vim.schedule_wrap(callback))
end

function VimSchedulerAdapter:dispose()
   self._impl:dispose()
end

local nvim_lusc = {}


function nvim_lusc.setup()
   assert(not lusc.has_started())

   lusc.start({
      scheduler_factory = function()
         return VimSchedulerAdapter.new()
      end,
      on_completed = function(err)
         if err ~= nil then
            vim.notify("Lusc completed with errors. Details: " .. tostring(err))
         end
      end,
   })

   vim.api.nvim_create_autocmd('VimLeavePre', {
      pattern = '*',
      callback = function()
         if lusc.has_started() then
            vim.fn.input("Lusc failed to shut down gracefully.  lusc.stop should be called first instead.  Press enter to continue closing...")
         end
      end,
   })
end

return nvim_lusc

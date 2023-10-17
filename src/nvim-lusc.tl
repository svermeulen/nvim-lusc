
local lusc <const> = require("lusc")

local record VimSchedulerAdapter
   _impl: lusc.DefaultScheduler
end

function VimSchedulerAdapter.new():VimSchedulerAdapter
   return setmetatable(
      {
         _impl = lusc.DefaultScheduler.new(),
      } as VimSchedulerAdapter,
      { __index = VimSchedulerAdapter } as metatable<VimSchedulerAdapter>)
end

function VimSchedulerAdapter:schedule(delay_seconds:number, callback:function())
   self._impl:schedule(delay_seconds, vim.schedule_wrap(callback))
end

function VimSchedulerAdapter:dispose()
   self._impl:dispose()
end

local record nvim_lusc
end

function nvim_lusc.setup()
   assert(not lusc.has_started())

   lusc.start({
      scheduler_factory = function():lusc.Scheduler
         return VimSchedulerAdapter.new() as lusc.Scheduler
      end,
      on_completed = function(err:ErrorGroup)
         if err ~= nil then
            vim.notify("Lusc completed with errors. Details: " .. tostring(err))
         end
      end,
   })

   vim.api.nvim_create_autocmd('VimLeavePre', {
      pattern = '*', 
      callback = function()
         if lusc.has_started then
            vim.fn.input("Lusc failed to shut down gracefully.  lusc.stop should be called first instead.  Press enter to continue closing...")
         end
      end,
   })
end

return nvim_lusc


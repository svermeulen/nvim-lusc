
local lusc <const> = require("lusc")
local lusc_util <const> = require("lusc.internal.util")

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
   record Opts
      enable_logging: boolean
      log_handler: function(string)
      generate_debug_names:boolean
      on_completed: function(err:ErrorGroup)
      warn_on_unsafe_quit: boolean
   end
end

function nvim_lusc.setup(opts:nvim_lusc.Opts)
   assert(not lusc.has_started())

   opts = opts or {}

   if opts.warn_on_unsafe_quit == nil then
      opts.warn_on_unsafe_quit = true
   end

   local on_completed:function(err:ErrorGroup)

   if opts.enable_logging then
      local log_handler = opts.log_handler

      if log_handler == nil then
         log_handler = function(msg:string)
            vim.cmd("echom " .. msg)
         end
      end

      lusc_util.set_log_handler(log_handler)
   end

   if opts.on_completed then
      on_completed = opts.on_completed
   else
      on_completed = function(err:ErrorGroup)
         if err ~= nil then
            vim.notify("Lusc completed with errors. Details: " .. tostring(err))
         end
      end
   end

   lusc.start({
      scheduler_factory = function():lusc.Scheduler
         return VimSchedulerAdapter.new() as lusc.Scheduler
      end,
      generate_debug_names = opts.generate_debug_names,
      on_completed =  on_completed,
   })

   if opts.warn_on_unsafe_quit then
      vim.api.nvim_create_autocmd('VimLeavePre', {
         pattern = '*', 
         callback = function()
            if lusc.has_started() and lusc.has_jobs_running() then
               lusc.cancel_all()
               lusc.stop {
                  on_completed = function()
                     vim.cmd("Lusc cancelled all jobs successfully")
                  end,
               }
               vim.fn.input("Lusc failed to shut down gracefully (there are jobs still running).  To fix, call lusc.stop() instead or use set warn_on_unsafe_quit option to just suppress this warning. See docs for more details.  Press enter to continue...")
            end
         end,
      })
   end
end

return nvim_lusc


local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local assert = _tl_compat and _tl_compat.assert or assert
local lusc = require("lusc")
local lusc_util = require("lusc.internal.util")

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

local nvim_lusc = {Opts = {}, }









function nvim_lusc.setup(opts)
   assert(not lusc.has_started())

   opts = opts or {}

   if opts.wait_for_cancel_on_quit == nil then
      opts.wait_for_cancel_on_quit = true
   end

   local on_completed

   if opts.enable_logging then
      local log_handler = opts.log_handler

      if log_handler == nil then
         log_handler = function(msg)
            vim.cmd("echom " .. msg)
         end
      end

      lusc_util.set_log_handler(log_handler)
   end

   if opts.on_completed then
      on_completed = opts.on_completed
   else
      on_completed = function(err)
         if err ~= nil then
            vim.notify("Lusc completed with errors. Details: " .. tostring(err))
         end
      end
   end

   lusc.start({
      scheduler_factory = function()
         return VimSchedulerAdapter.new()
      end,
      generate_debug_names = opts.generate_debug_names,
      on_completed = on_completed,
   })

   if opts.wait_for_cancel_on_quit then
      vim.api.nvim_create_autocmd('VimLeavePre', {
         pattern = '*',
         callback = function()
            if lusc.has_started() and lusc.has_jobs_running() then
               lusc.stop({
                  move_on_after = 0,
                  on_completed = function()
                     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, false, true), "t")
                  end,
               })
               vim.fn.input("Waiting for all Lusc jobs to cancel... Press enter to quit immediately")
            end
         end,
      })
   end
end

return nvim_lusc

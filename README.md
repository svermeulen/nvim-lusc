
# nvim-lusc

## Structured Async/Concurrency for Neovim

This library brings the concept of [Structured Concurrency](https://en.wikipedia.org/wiki/Structured_concurrency) to Lua in Neovim.  The name is an abbrevriation of this (**LU**a **S**tructured **C**oncurrency).

This programming paradigm was first popularized by the python library [Trio](https://github.com/python-trio/trio) and Lusc almost exactly mirrors the Trio API except in Lua.  So if you are already familiar with Trio then you should be able to immediately understand and use the Lusc API.

If you aren't familiar with Trio - then in short, Structured Concurrency makes asynchronous tasks an order of magnitude easier to manage.  It achieves this by making the structure of code match the hierarchical structure of the async operations, which results in many benefits.  For more details, you might check out the [trio docs](https://trio.readthedocs.io/en/stable/reference-core.html), or [these articles](https://gist.github.com/belm0/4c6d11f47ccd31a231cde04616d6bb22) (which lusc was based on)

Note also that this is just the neovim integration of the [Lusc](https://github.com/svermeulen/lusc) library.  [Lusc](https://github.com/svermeulen/lusc) can also be used directly for pure Lua projects that exist outside of Neovim.

Installation
---

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'svermeulen/nvim-lusc'
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use { 'svermeulen/nvim-lusc' }
```

Setup
---

```lua
require('nvim-lusc').setup()
```

Example
---

After adding the following to your `init.lua`, if you hit `<space>t` you should see an async countdown.

```lua
local lusc = require'lusc'

-- <space>t to run this test
vim.keymap.set('n', '<space>t', function()
  lusc.schedule(function()
    for i=5,1,-1 do
      vim.cmd("echom " .. tostring(i))
      lusc.await_sleep(1)
    end
  end)
end)
```

Of course, this is just a simple example.  For details on other features (eg. channels, cancellation, events, cancel scopes, shielding, nurseries, etc etc) I recommend reading the [lusc docs](https://github.com/svermeulen/lusc) or the [Trio docs](https://github.com/python-trio/trio) (since, even though Trio is a python library, lusc tries to exactly mimic its API in lua)

Options
---

The following is equivalent to `require('nvim-lusc').setup()` since these are the defaults:

```lua
require('nvim-lusc').setup {
  wait_for_cancel_on_quit = true,
  on_completed = function(err)
    if err ~= nil then
      vim.notify("Lusc completed with errors. Details: " .. tostring(err))
    end
  end,
  enable_logging = false,
  log_handler = function(msg) vim.cmd("echom " .. msg) end,
  generate_debug_names = false, -- Adds extra debugging info when logging is enabled
}
```

Graceful Shutdown
---

One problem with running tasks asynchronously is that they might be in the middle of an operation when the user decides to quit.  Lusc solves this problem by blocking on vim exit until the jobs are successfully cancelled.

Usually this happens quickly enough that it doesn't add noticeable time to vim exit.  However, jobs can also be `shielded` which prevents them from being cancelled immediately, and this can cause vim exit to block. To see what this looks like, try changing our countdown map above to use the `shielded` flag like this instead:

```lua
-- <space>t to run this test
vim.keymap.set('n', '<space>t', function()
  lusc.schedule(function()
    lusc.cancel_scope(function()
      for i=5,1,-1 do
        vim.cmd("echom " .. tostring(i))
        lusc.await_sleep(1)
      end
    end, { shielded = true })
  end)
end)
```

If you then hit `<space>t` again, and then immediately quit with `:qa`, then you should see this prompt:

`Waiting for all Lusc jobs to cancel... Press enter to quit immediately`

So in these cases, where some jobs are blocking via shielded flag, you can either press enter to stop waiting for your async tasks, or just wait, and neovim should close automatically when it completes.

You might also want to have explicit control over when lusc tasks are stopped/cancelled.  If so, you can disable the above behvaiour by setting `wait_for_cancel_on_quit` flag to false then explicitly calling `lusc.stop` yourself.


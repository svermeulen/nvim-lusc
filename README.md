
# nvim-lusc

## Structured Async/Concurrency for Neovim

This library brings the concepts of [Structured Concurrency](https://en.wikipedia.org/wiki/Structured_concurrency) to Lua in Neovim.  The name is an abbrevriation of this (**LU**a **S**tructured **C**oncurrency).

This programming paradigm was first popularized by the python library [Trio](https://github.com/python-trio/trio) and Lusc almost exactly mirrors the Trio API except in Lua.  So if you are already familiar with Trio then you should be able to immediately understand and use the Lusc API.

If you aren't familiar with Trio - then in short, Structured Concurrency makes asynchronous tasks an order of magnitude easier to manage.  It achieves this by making the structure of code match the hierarchical structure of the async operations, which results in many benefits.  For more details, you might check out the [trio docs](https://trio.readthedocs.io/en/stable/reference-core.html), or [these articles](https://gist.github.com/belm0/4c6d11f47ccd31a231cde04616d6bb22) (which lusc was based on)

Note also that this is just the neovim integration of the [Lusc](https://github.com/svermeulen/lusc) library.  Lusc can be used directly for pure Lua projects that exist outside of Neovim.

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

After adding the following to your init.lua, if you hit `<space>t` you should see an async countdown.

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

Of course, this is just a simple example.  For details on other features (eg. channels, cancellation, events, cancel scopes, shielding, nurseries, etc etc) I recommend reading the docs from the [lusc docs](https://github.com/svermeulen/lusc), or the [Trio docs](https://github.com/python-trio/trio) (since, even though Trio is a python library, lusc tries to exactly mimic its API in lua)

Graceful Shutdown
---

One problem with running tasks asynchronously is that they might be in the middle of an operation when the user decides to quit.  Ideally we allow these jobs to be cancelled so that they clean up any resources they are using.  By default, nvim-lusc will warn the user when this happens.  So for example, if you use the code from the previous Example section, and run `<space>t`, then quit neovim before it completes the countdown, you should see this warning:



Extra Configuration
---

The following will is equivalent to `require('nvim-lusc').setup()` since these are the defaults:

```lua
require('nvim-lusc').setup {
  warn_on_unsafe_quit = true,
  on_completed = function(err)
    if err ~= nil then
      vim.notify("Lusc completed with errors. Details: " .. tostring(err))
    end
  end,
  enable_logging = false,
  log_handler = function(msg) vim.cmd("echom " .. msg) end,
  generate_debug_names = false,
}
```

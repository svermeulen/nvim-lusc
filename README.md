
# nvim-lusc - Structured Async/Concurrency for Neovim

This library brings the concepts of [Structured Concurrency](https://en.wikipedia.org/wiki/Structured_concurrency) to Lua in Neovim.  The name is an abbrevriation of this (**LU**a **S**tructured **C**oncurrency).

This programming paradigm was first popularized by the python library [Trio](https://github.com/python-trio/trio) and Lusc almost exactly mirrors the Trio API except in Lua.  So if you are already familiar with Trio then you should be able to immediately understand and use the Lusc API.

If you aren't familiar with Trio - then in short, Structured Concurrency makes asynchronous tasks an order of magnitude easier to manage.  It achieves this by making the structure of code match the hierarchical structure of the async operations, which results in many benefits.  For more details, you might check out the [trio docs](https://trio.readthedocs.io/en/stable/reference-core.html), or [these articles](https://gist.github.com/belm0/4c6d11f47ccd31a231cde04616d6bb22) (which lusc was based on)

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

### VimL

```vim
lua << END
require('nvim-lusc').setup()
END
```

### Lua

```lua
require('nvim-lusc').setup()
```

Example
---

```lua
local lusc = require'lusc'

TBD
```


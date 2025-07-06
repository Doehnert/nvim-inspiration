# nvim-inspiration

A Neovim plugin that shows inspirational quotes using zenquotes.io API.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
require('lazy').setup({
  {
    'Doehnert/nvim-inspiration',
    dependencies = { 'nvim-lua/plenary.nvim', 'rcarriga/nvim-notify' },
    config = function()
      require('plugins.inspiration').setup()
    end,
  },
})
```

## Usage

Call `:Insp` to show a random inspirational quote.

require('ayu').setup(
{
    mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    overrides = {
      Comment = {
        fg = "#0ecf00"
      },
      Normal = {
        fg = "#000000",
        bg = "#ffffff"
      },
      NormalNC = {
        fg = "#444444",
        bg = "#f4f4f4"
      },
      CocMenuSel = {
        fg = "#fafafa",
        bg = "#13354a"
      },
      LineNr = {
        fg = "#a2a2a2"
      },
      -- Highlight position of error black on red
      CocErrorHighlight = {
        fg = "#000000",
        bg = "#ff0000"
      },
      TabLineFill = {
        fg = "#303137",
        bg = "#c0c0c0"
      },
      StatusLine = {
        fg = "#494b53",
        bg = "#c0c0c0"
      },
      StatusLineNC = {
        fg = "#494b53",
        bg = "#c0c0c0"
      },
      CocFloating = {
        bg = "#e0e0e0"
      },
      CursorLine = {
        bg = "#dfe0e1"
      }

    }, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})

function LMBackgroundLight()
  vim.o.background = 'light'

  vim.cmd.colorscheme('ayu')
end

function LMBackgroundDark()
  vim.cmd.colorscheme('one')

  vim.o.background = 'dark'
end

if not vim.g['config_already_loaded'] then
  vim.g['config_already_loaded'] = true

  LMBackgroundLight()
end

vim.keymap.set('n', '<F6>', ':lua LMBackgroundDark()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<F7>', ':lua LMBackgroundLight()<CR>', { noremap = true, silent = true })

-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.g.python_host_prog = "$HOME/.pyenv/versions/neovim2/bin/python"
vim.g.python3_host_prog = "$HOME/.pyenv/versions/neovim3/bin/python"


lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "sainnhe/sonokai"
  },
}

vim.cmd [[
  if has('termguicolors')
    set termguicolors
  endif

  let g:sonokai_style = 'andromeda'
  let g:sonokai_better_performance = 1

  colorscheme sonokai
]]

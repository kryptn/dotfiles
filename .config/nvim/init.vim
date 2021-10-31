if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tomasr/molokai'
Plug 'sainnhe/sonokai'

Plug 'itchyny/lightline.vim'
Plug 'luochen1990/rainbow'
Plug 'nvim-lua/plenary.nvim'
Plug 'sharkdp/fd'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'lewis6991/spellsitter.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'yamatsum/nvim-cursorline'

call plug#end()

syntax enable
colorscheme molokai

set number
set linespace=3
set guifont=Fira\ Code:h12
set cursorline
set mouse=a
set number relativenumber
set nu rnu

let g:rainbow_active = 1

source ~/.config/nvim/coc.vim

let g:lightline = {
      \ 'colorscheme':'sonokai',
      \ }

let g:sonoai_style = 'shusia'                                                                                
let g:sonokai_enable_italic = 1                                                                         
let g:sonokai_disable_italic_comment = 1

let g:coc_global_extensions = [
      \ 'coc-json', 
      \ 'coc-git', 
      \ 'coc-rust-analyzer',
      \ 'coc-go',
      \ 'coc-pyright',
      \ 'coc-toml',
      \ 'coc-yaml',
      \ 'coc-yank',
      \ ]

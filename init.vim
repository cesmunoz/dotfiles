call plug#begin("~/.config/nvim/plugged")
  " Plugin Section
  Plug 'morhetz/gruvbox'
  Plug 'preservim/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'Xuyuanp/nerdtree-git-plugin' 
  Plug 'ryanoasis/vim-devicons'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Everything afther this line will be the config section

let mapleader="<space>"

if (has("termguicolors"))
 set termguicolors
endif
set background=dark
colorscheme gruvbox

let NERDTreeShowHidden=1

set number
set encoding=utf-8
set numberwidth=2
set textwidth=80

command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co - exclude-standard', 'find %s -type f']
nmap <C-P> :GFiles<CR>

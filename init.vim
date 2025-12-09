call plug#begin()
 
" List your plugins here
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" follow latest release and install jsregexp.
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'} " Replace <CurrentMajor> by the latest released major (first number of latest release)
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'stevearc/conform.nvim'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'stevearc/oil.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'sainnhe/everforest'
Plug 'airblade/vim-gitgutter'
Plug 'mbbill/undotree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'itchyny/lightline.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/tagbar'

" Plug 'yaegassy/coc-astro', {'do': 'yarn install --frozen-lockfile'}
" Plug 'wuelnerdotexe/vim-astro'

" SQL stuff
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

 
call plug#end()

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set spell
set guifont=JetBrains\ Mono:h16
set smartindent
set scrolloff=8
" Set leader key
let g:mapleader = " "
map j gj
map k gk

" stack: make jump list behave like tag stak
" view: make sure vim view does not center on the cursor after jumping back
set jumpoptions="stack,view"
" Enable relative line numbers
set relativenumber
" turn hybrid line numbers on
:set nu rnu
" Insert mode mapping for 'jj' to escape
inoremap jj <Esc>
" Visual mode mapping to delete and paste without overwriting the clipboard
xnoremap <leader>p "_dP
" Normal and visual mode mappings to yank to the system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
" Normal mode mapping to yank entire line to the system clipboard
nnoremap <leader>Y "+Y
" Normal and visual mode mappings to delete without overwriting the clipboard
nnoremap <leader>d "_d
vnoremap <leader>d "_d
" Normal mode mappings to scroll half page and recenter
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
" Normal mode mappings for quick line insertion above and below
nnoremap <leader>o o<Esc>k
nnoremap <leader>O O<Esc>j
" Normal mode mapping to copy the current file's directory path to the clipboard
nnoremap <leader>lp :let @*=expand("%:p:h")<CR>
" Visual mode mapping to move selected lines up or down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Keymap to close the current buffer
nnoremap <leader>bd :bd<CR>
" Keymap to go to the previous buffer
nnoremap [b :bp<CR>
" Keymap to go to the next buffer
nnoremap ]b :bn<CR>
" Keymap to append a semicolon in insert mode and return to normal mode
inoremap ;; <C-o>A;<Esc>
" Open quickfix at bottom of all windows
noremap <leader>qq :botright copen<cr>
" Close Quickfix
noremap <leader>Q :cclose<cr>
" Clear Quickfix
noremap <leader>qc :cexpr[]<cr>
nmap <silent><nowait> [q :cprev<Cr>
nmap <silent><nowait> ]q :cnext<Cr>
" Open location list at bottom of all windows
noremap <leader>ll :botright lopen<cr>
" Close location list
noremap <leader>L :lclose<cr>
" Clear location list
noremap <leader>lc :lexpr[]<cr>
nmap <silent><nowait> [l :lprev<Cr>
nmap <silent><nowait> ]l :lnext<Cr>
" Folding
" nnoremap zs :setlocal foldmethod=syntax<CR>
function! ToggleFugitiveFolds()
    if &l:foldmethod == 'syntax'
        setlocal foldmethod=manual
        normal! zE
        echo "Folds: manual (all folds cleared)"
    else
        setlocal foldmethod=syntax
        echo "Folds: syntax"
    endif
endfunction

nnoremap zs :call ToggleFugitiveFolds()<CR>

" Alias for open new tab
command Tn tabnew
command Tc tabclose

" Git mappings
command! Gcc call feedkeys(':Git commit -m ""' . "\<Left>")
command! Gcr call feedkeys(':Git commit -m "refactor"' . "\<Left>")
command! Gca :Git commit --amend
" See https://dpwright.com/posts/2018/04/06/graphical-log-with-vimfugitive/
command -nargs=* Glg Git! log --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=local <args>
command -nargs=* Glgr Git! log --graph --pretty=format:'%h - (%ad)%d %s <%an>' --abbrev-commit --date=relative <args>

" Configuring lightline
" coc-git integration
let g:lightline = {
            \ 'active': {
            \   'left': [
            \     [ 'mode', 'paste' ],
            \     [ 'ctrlpmark', 'git', 'diagnostic', 'cocstatus', 'filename', 'method' ]
            \   ],
            \   'right':[
            \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
            \     [ 'blame' ]
            \   ],
            \ },
            \ 'component_function': {
            \   'blame': 'LightlineGitBlame',
            \ },
            \ 'colorscheme' : 'everforest'
            \ }

" Configuring Undotree
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

" Configuring vim-dadbod-ui
autocmd FileType sql setlocal omnifunc=vim_dadbod_completion#omni

" Undotree mappings
nnoremap <leader>u :UndotreeToggle<CR>

" fzf mappings
nnoremap <leader>ff :Files<Cr>
nnoremap <leader>fg :GFiles<Cr>
nnoremap <leader>fm :Marks<Cr>
nnoremap <leader>fr :RG<Cr>
nnoremap <leader>fb :Buffers<Cr>
nnoremap <leader>ft :Tags<Cr>
nnoremap <leader>fc :Commits<Cr>
 
" Mappings for vim-go
autocmd BufEnter *.go nmap <leader>gg  <Plug>(go-test)

" Mappings for tagbar
nmap <leader>t :TagbarToggle<CR>

" THEME
" Important!!
if has('termguicolors')
    set termguicolors
endif
 
" For dark version.
set background=dark
 
" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'medium'
 
" For better performance
let g:everforest_better_performance = 1

colorscheme everforest


lua require('config')

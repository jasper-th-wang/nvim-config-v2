call plug#begin()
 
" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'sainnhe/everforest'
Plug 'airblade/vim-gitgutter'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'itchyny/lightline.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/tagbar'

" SQL stuff
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

" Personal machine only plugins
if filereadable(expand('~/.vim/.vim-personal-machine'))
    Plug 'yaegassy/coc-astro', {'do': 'yarn install --frozen-lockfile'}
    Plug 'wuelnerdotexe/vim-astro'
endif

 
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
let mapleader = " "
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

" to trigger html formatter for Golang template
au! BufNewFile,BufRead *.tmpl set filetype=html

" Configuring Coc
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-tsserver', 'coc-prettier', 'coc-css', 'coc-html', 'coc-emmet', 'coc-eslint', 'coc-yaml', 'coc-vimlsp', 'coc-pairs', 'coc-snippets', 'coc-db', 'coc-java']

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

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

" This is to import settings only pertain to my personal machine.
" NOTE: because on my personal machine, this vimrc is symlinked to $USER directory,
" that's why the pathing reference to '.vim-personal-machine' will be reached.
" In other scenario, like public machines, I tend to copy this vimrc file,
" and place it in my $USER directory, hence '.vim-personal-machine' will not be
" reached.
if filereadable(expand('~/.vim/.vim-personal-machine'))
    let g:coc_global_extensions += ['coc-docker', 'coc-go', 'coc-golines', 'coc-pyright']
    let g:astro_typescript = 'enable'
endif

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
 
" coc mappings
" https://raw.githubusercontent.com/neoclide/coc.nvim/master/doc/coc-example-config.vim
let g:coc_default_semantic_highlight_groups = 1
 
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
 
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300
 
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes
 
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
 
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
 
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
 
" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
 
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)
 
" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)
 
" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
 
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
 
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
 
" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
 
" Formatting selected code
" xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>mp  <Plug>(coc-format)
 
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end
 
" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
 
" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)
 
" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
 
" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)
 
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
 
" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
 
" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
 
" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')
 
" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
 
" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Configuring NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Configuring ALE
let g:ale_floating_preview = 0
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 0
nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)
let g:ale_pattern_options = {
            \   '\.s$': {'ale_enabled': 0},
            \}
 
" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
 
" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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

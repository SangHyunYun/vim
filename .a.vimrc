syntax enable
set undodir=~/.vimundo/
set hidden
set history=50
set nobackup

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
"set number
set showcmd
set incsearch
:hi Search ctermbg=7
set autowrite
set fileencoding=UTF-8
set fileencodings=ucs-bom,utf-8,default,gb2312

set so=7
set ruler
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=2
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set showtabline=2
set foldcolumn=1
set cursorline
set cursorcolumn
let g:solarized_termcolors=256

let mapleader=","
:nnoremap <leader>ev :vsplit ~/.a.vimrc<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>
:nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
:nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel
:nnoremap W w
:nnoremap w W
:nnoremap B b
:nnoremap b B
:vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>`>
:inoremap jk <esc>
:onoremap p i(
:onoremap r /return<cr>

:noremap <leader><Left> :bp<cr>
:noremap <leader><Right> :bn<cr>
:noremap <leader><Down> :bd<cr>
:noremap <leader><Up> :tabnew<cr>
:noremap <leader>w :w!<cr>
:noremap <leader>q :q!<cr>
:noremap <leader>s :source ~/.vimrc<cr>
:noremap <leader>b :BLines<cr>
:noremap <leader>g :GFiles<cr>
:noremap <leader><tab> >>
:noremap <leader><S-tab> <<
:noremap <leader>= vG=vgg=
:noremap <leader>a :!ag ""
:noremap <leader>A :!ag "" --ignore-dir ""
:noremap <leader>r :!rg -p ""
" -e 여러 개 검사
" -C 앞 뒤로 추가 출력 (default : 2)
" -w 패턴을 한 단어로서 검색
" -a All
" -j Threads 개수를 선택
" -t Type에 맞는 file만 검색 (--type-list로 list확인 가능)
:noremap <leader>h :History<cr>
:noremap <leader>c :cs find c <cword><cr>
" s - > Find this C symbol
" g - > Find this definition
" d - > Find functions called by this function
" c - > Find functions calling this function
" t - > Find assignments to
" e - > Find this egrep pattern
" f - > Find this File

nnoremap <C-p> :Files<Cr>
"nnoremap <C-o> :Rg<Cr>
nnoremap <C-o> :Ag<Cr>
:noremap <C-f> *
nnoremap <C-z> <C-r>
:noremap <F6> :!mkcscope<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <C-Left> :vertical resize +1<CR>
nnoremap <C-Right> :vertical resize -1<CR>
nnoremap <C-Up> :resize +1<CR>
nnoremap <C-Down> :resize -1<CR>

map f <Plug>(easymotion-prefix)

source $VIMRUNTIME/vimrc_example.vim

let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'

set nobackup
set nowritebackup
set wildmenu

"""""""""" wesleyche/SrcExpl
source ~/.se.vimrc


"""""""""" ctags

map <C-F12> :!/usr/local/bin/ctags -R --exclude=.git --exclude=log --exclude=wutils --c++-kinds=+p --fields=+iaS --extra=+q *<CR>
" nnoremap <C-[> <C-T>

"""""""""" TagList
" taglist configuration
let Tlist_Ctags_Cmd ='/usr/local/bin/ctags'
" Taglist plugin mapping
" noremap <silent> <Leader>t :TlistToggle<CR>
:noremap <F1> <c-w><c-p>
:noremap <F2> <c-w><c-w>
:noremap <F3> :TlistToggle<CR>:NERDTreeToggle<CR>:SrcExplToggle<CR><c-w><c-l>
:noremap <F4> :set nu!<CR>
" Taglist plugin config
let Tlist_Use_Right_Window = 1
let Tlist_Inc_Winwidth = 0
let Tlist_WinWidth = 30
" let Tlist_GainFocus_On_ToggleOpen= 1
" let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
" let Tlist_Auto_Open = 1
" let Tlist_File_Fold_Auto_Close = 1
autocmd BufWritePost *.cpp :TlistUpdate
autocmd BufWritePost *.h :TlistUpdate
autocmd BufWritePost *.jce :TlistUpdate

"""""""""" NerdTree (and vimenter events)
" nnoremap <C-n> :NERDTreeToggle<CR>
autocmd vimenter *.cpp NERDTree
autocmd vimenter *.cpp Tlist
autocmd vimenter *.cpp SrcExpl
autocmd VimEnter *.cpp wincmd w

"autocmd BufNew   * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"""""""""" Function for NerdTree + Taglist (auto close when 2 windows)

function! CheckLeftBuffers()
	if tabpagenr('$') == 1
		let i = 1
		while i <= winnr('$')
			" echom getbufvar(winbufnr(i), '&buftype')
			if getbufvar(winbufnr(i), '&buftype') == 'help' ||
												\ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
												\ exists('t:NERDTreeBufName') &&
												\   bufname(winbufnr(i)) == t:NERDTreeBufName ||
												\ bufname(winbufnr(i)) == '__Tag_List__' ||
												\ bufname(winbufnr(i)) == 'Source_Explorer' ||
												\ getwinvar(i, 'SrcExpl') == 1
				let i += 1
			else
				break
			endif
		endwhile
		if i == winnr('$') + 1
						qall
		endif
		unlet i
	endif
endfunction
autocmd BufEnter * call CheckLeftBuffers()


"""""""""" tabline

hi TabLine      ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineFill  ctermfg=Black  ctermbg=Green     cterm=NONE
hi TabLineSel   ctermfg=White  ctermbg=DarkBlue  cterm=NONE


"""""""""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"""""""""" AutoCompletePop 
function! InsertTabWrapper()
	let col=col('.')-1
	if !col||getline('.')[col-1]!~'\k'
		return "\<TAB>"
	else
		if pumvisible()
				return "\<C-N>"
		else
				return "\<C-N>\<C-P>"
		end 
	endif
endfunction

inoremap <TAB> <c-r>=InsertTabWrapper()<cr>
hi Pmenu ctermbg=blue
hi PmenuSel ctermbg=yellow ctermbg=black
hi PmenuSbar ctermbg=blue

"""""""""" cscope 
set csprg=/usr/bin/cscope
set csto=0
set cst
set nocsverb

if filereadable("./cscope.out")
	cs add cscope.out
else
	cs add /usr/src/linux/cscope.out
endif

set csverb

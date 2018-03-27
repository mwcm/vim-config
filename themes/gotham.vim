" mwcm-2018 - gotham custom
" borrowed mostly from rafi's 2017 hybrid custom
" =========================


" these are just our gotham colors
let s:base03 = [ '#0c1014', '0' ]
let s:base02 = [ '#11151c', '8' ]
let s:base01 = [ '#091f2e', '10' ]
let s:base00 = [ '#0a3749', '12' ]
let s:base0  = [ '#1e6479', '11' ]
let s:base1  = [ '#599cab', '14' ]
let s:base2  = [ '#99d1ce', '7' ]
let s:base3  = [ '#d3ebe9', '15' ]

let s:red     = [ '#c23127', '1' ]
let s:orange  = [ '#d26937', '9' ]
let s:yellow  = [ '#edb443', '3' ]
let s:magenta = [ '#888ca6', '13' ]
let s:violet  = [ '#4e5166', '5' ]
let s:blue    = [ '#195466', '4' ]
let s:cyan    = [ '#33859e', '6' ]
let s:green   = [ '#2aa889', '2' ]


" using hybrid status bar now
"status bar settings
"let s:p = { 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {} }

"let s:p.normal.left     = [ [ s:base3, s:blue ],    [ s:base1, s:base01 ] ]
"let s:p.normal.right    = [ [ s:base3, s:blue ],    [ s:base1, s:base01 ] ]
"let s:p.inactive.left   = [ [ s:blue,  s:base02 ],  [ s:blue,  s:base02 ] ]
"let s:p.inactive.right  = [ [ s:blue,  s:base01 ],  [ s:blue,  s:base02 ] ]
"let s:p.insert.left     = [ [ s:base3, s:green ],   [ s:base1, s:base01 ] ]
"let s:p.replace.left    = [ [ s:base3, s:red ],     [ s:base1, s:base01 ] ]
"let s:p.visual.left     = [ [ s:base3, s:violet ],  [ s:base1, s:base01 ] ]
"let s:p.normal.middle   = [ [ s:base1, s:base02 ] ]
"let s:p.inactive.middle = [ [ s:blue,  s:base02 ] ]
"let s:p.tabline.left    = [ [ s:base1, s:base01 ] ]
"let s:p.tabline.tabsel  = [ [ s:base3, s:blue ] ]
"let s:p.tabline.middle  = [ [ s:base1, s:base02 ] ]
"let s:p.tabline.right   = [ [ s:base1, s:base01 ] ]
"let s:p.normal.error    = [ [ s:base3, s:red ] ]
"let s:p.normal.warning  = [ [ s:base3, s:orange ] ]

"let g:lightline#colorscheme#gotham#palette = lightline#colorscheme#flatten(s:p)


" gVim Appearance {{{
" ---------------------------------------------------------
if has('gui_running')
	set guifont=PragmataPro:h16
	" set noantialias
endif
" }}}

" UI elements {{{
" ---------------------------------------------------------
set showbreak=↪
set fillchars=vert:│,fold:─


set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·

" icons:  ▏│ ¦ ╎ ┆ ⋮ ⦙ ┊ 
" }}}

" Tabline {{{
" ---------------------------------------------------------
" TabLineFill: Tab pages line, where there are no labels
hi TabLineFill ctermfg=234 ctermbg=236 guifg=#1C1C1C guibg=#303030 cterm=NONE gui=NONE
" TabLine: Not-active tab page label
hi TabLine     ctermfg=243 ctermbg=236 guifg=#767676 guibg=#303030 cterm=NONE gui=NONE
" TabLineSel: Active tab page label
hi TabLineSel  ctermfg=241 ctermbg=234 guifg=#626262 guibg=#1C1C1C cterm=NONE gui=NONE
" Custom
highlight TabLineSelShade  ctermfg=235 ctermbg=234 guifg=#262626 guibg=#1C1C1C
highlight TabLineAlt       ctermfg=252 ctermbg=238 guifg=#D0D0D0 guibg=#444444
highlight TabLineAltShade  ctermfg=238 ctermbg=236 guifg=#444444 guibg=#303030

function! Tabline() abort "{{{
	" Active project tab
	let s:tabline =
		\ '%#TabLineAlt# %{badge#project()} '.
		\ '%#TabLineAltShade#▛'.
		\ '%#TabLineFill#  '

	let nr = tabpagenr()
	for i in range(tabpagenr('$'))
		if i + 1 == nr
			" Active tab
			let s:tabline .=
				\ '%#TabLineSelShade#░%#TabLineSel#'.
				\ '%'.(i+1).'T%{badge#label('.(i+1).', "▛", "N/A")} '.
				\ '%#TabLineFill#▞ '
		else
			" Normal tab
			let s:tabline .=
				\ '%#TabLine# '.
				\ '%'.(i+1).'T%{badge#label('.(i+1).', "▛", "N/A")} '.
				\ '▘ '
		endif
	endfor
	" Empty space and session indicator
	let s:tabline .=
		\ '%#TabLineFill#%T%=%#TabLine#%{badge#session("['.fnamemodify(v:this_session, ':t:r').']")}'
	return s:tabline
endfunction "}}}

let &tabline='%!Tabline()'
" }}}

" Statusline {{{
let s:stl  = " %7*%{&paste ? '=' : ''}%*"         " Paste symbol
let s:stl .= "%4*%{&readonly ? '' : '#'}%*"       " Modifide symbol
let s:stl .= "%6*%{badge#mode('⚠ ', 'Z')}"        " Read-only symbol
let s:stl .= '%*%n'                               " Buffer number
let s:stl .= "%6*%{badge#modified('+')}%0*"       " Write symbol
let s:stl .= ' %1*%{badge#filename()}%*'          " Filename
let s:stl .= ' %<'                                " Truncate here
let s:stl .= '%( %{badge#branch()} %)'           " Git branch name
let s:stl .= "%4*%(%{badge#trails('⤐ %s')} %)"  " Whitespace
let s:stl .= '%(%{badge#syntax()} %)%*'           " syntax check
let s:stl .= '%='                                 " Align to right
let s:stl .= '%{badge#format()} %4*%*'           " File format
let s:stl .= '%( %{&fenc} %)'                     " File encoding
let s:stl .= '%4*%*%( %{&ft} %)'                 " File type
let s:stl .= '%3*%2* %l/%2c%4p%% '               " Line and column
let s:stl .= '%{badge#indexing()}%*'              " Indexing tags indicator

" Non-active Statusline {{{
let s:stl_nc = " %{badge#mode('⚠ ', 'Z')}%n"   " Readonly & buffer
let s:stl_nc .= "%6*%{badge#modified('+')}%*"  " Write symbol
let s:stl_nc .= ' %{badge#filename()}'         " Relative supername
let s:stl_nc .= '%='                           " Align to right
let s:stl_nc .= '%{&ft} '                      " File type
" }}}

" Highlights: Statusline {{{
highlight StatusLine   ctermfg=236 ctermbg=248 guifg=#30302c guibg=#a8a897
highlight StatusLineNC ctermfg=236 ctermbg=242 guifg=#30302c guibg=#666656

" Filepath color
highlight User1 guifg=#D7D7BC guibg=#30302c ctermfg=251 ctermbg=236
" Line and column information
highlight User2 guifg=#a8a897 guibg=#4e4e43 ctermfg=248 ctermbg=239
" Line and column corner arrow
highlight User3 guifg=#4e4e43 guibg=#30302c ctermfg=239 ctermbg=236
" Buffer # symbol and whitespace or syntax errors
highlight User4 guifg=#666656 guibg=#30302c ctermfg=242 ctermbg=236
" Write symbol
highlight User6 guifg=#cf6a4c guibg=#30302c ctermfg=167 ctermbg=236
" Paste symbol
highlight User7 guifg=#99ad6a guibg=#30302c ctermfg=107 ctermbg=236
" Syntax and whitespace
highlight User8 guifg=#ffb964 guibg=#30302c ctermfg=215 ctermbg=236
" }}}

let s:disable_statusline =
	\ 'denite\|unite\|vimfiler\|tagbar\|nerdtree\|undotree\|gundo\|diff\|peekaboo\|sidemenu'

" Toggle Statusline {{{
augroup statusline
	autocmd!
	autocmd FileType,WinEnter,BufWinEnter,BufReadPost *
		\ if &filetype !~? s:disable_statusline
		\ | let &l:statusline = s:stl
		\ | endif
	autocmd WinLeave *
		\ if &filetype !~? s:disable_statusline
		\ | let &l:statusline = s:stl_nc
		\ | endif
augroup END "}}}

" }}}

" Highlights: General GUI {{{
" ---------------------------------------------------------
" highlight! Error  term=NONE cterm=NONE
" highlight! link WarningMsg  Comment
highlight! link pythonSpaceError  NONE
highlight! link pythonIndentError NONE
" highlight! link mkdLineBreak      NONE
highlight! link ExtraWhitespace  SpellBad
highlight! WarningMsg ctermfg=100 guifg=#CCC566
" }}}

" Plugin: NERDTree icons and highlights {{{
" ---------------------------------------------------------
let g:NERDTreeIndicatorMapCustom = {
	\ 'Modified':  '·',
	\ 'Staged':    '‧',
	\ 'Untracked': '?',
	\ 'Renamed':   '≫',
	\ 'Unmerged':  '≠',
	\ 'Deleted':   '✃',
	\ 'Dirty':     '⁖',
	\ 'Clean':     '✓',
	\ 'Unknown':   '⁇'
	\ }

let g:NERDTreeDirArrowExpandable = '▷'
let g:NERDTreeDirArrowCollapsible = '▼'

highlight! NERDTreeOpenable ctermfg=132 guifg=#B05E87
highlight! def link NERDTreeClosable NERDTreeOpenable

highlight! NERDTreeFile ctermfg=246 guifg=#999999
highlight! NERDTreeExecFile ctermfg=246 guifg=#999999

highlight! clear NERDTreeFlags
highlight! NERDTreeFlags ctermfg=234 guifg=#1d1f21
highlight! NERDTreeCWD ctermfg=240 guifg=#777777

highlight! NERDTreeGitStatusModified ctermfg=1 guifg=#D370A3
highlight! NERDTreeGitStatusStaged ctermfg=10 guifg=#A3D572
highlight! NERDTreeGitStatusUntracked ctermfg=12 guifg=#98CBFE
highlight! def link NERDTreeGitStatusRenamed Title
highlight! def link NERDTreeGitStatusUnmerged Label
highlight! def link NERDTreeGitStatusDirDirty Constant
highlight! def link NERDTreeGitStatusDirClean DiffAdd
highlight! def link NERDTreeGitStatusUnknown Comment

function! s:NERDTreeHighlight()
	for l:name in keys(g:NERDTreeIndicatorMapCustom)
		let l:icon = g:NERDTreeIndicatorMapCustom[l:name]
		if empty(l:icon)
			continue
		endif
		let l:prefix = index(['Dirty', 'Clean'], l:name) > -1 ? 'Dir' : ''
		let l:hiname = escape('NERDTreeGitStatus'.l:prefix.l:name, '~')
		execute 'syntax match '.l:hiname.' #'.l:icon.'# containedin=NERDTreeFlags'
	endfor

	syntax match hideBracketsInNerdTree "\]" contained conceal containedin=NERDTreeFlags
	syntax match hideBracketsInNerdTree "\[" contained conceal containedin=NERDTreeFlags
endfunction

augroup nerdtree-highlights
	autocmd!
	autocmd FileType nerdtree call s:NERDTreeHighlight()
augroup END
"}}}

" Plugin: Tagbar icons {{{
" ---------------------------------------------------------
let g:tagbar_iconchars = ['▷', '◢']
"}}}

" Plugin: Neomake icons {{{
" ---------------------------------------------------------
let g:neomake_error_sign = {'text': '!', 'texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '!', 'texthl': 'WarningSyntax'}
let g:neomake_message_sign = {'text': '⌂', 'texthl': 'NeomakeMessageSign'}
let g:neomake_info_sign = {'text': '⍞', 'texthl': 'NeomakeInfoSign'}
"}}}
highlight! WarningSyntax ctermfg=58 guifg=#7d7629

" Plugin: GitGutter icons {{{
" ---------------------------------------------------------
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'
"}}}

" Plugin: vim-gitgutter {{{
" ---------------------------------------------------------
highlight! GitGutterAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE
highlight! GitGutterChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE
highlight! GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
highlight! GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
" }}}

" Plugin: denite {{{
" ---------------------------------------------------------
highlight! clear WildMenu
highlight! link WildMenu CursorLine
highlight! link deniteSelectedLine Type
highlight! link deniteMatchedChar Function
highlight! link deniteMatchedRange Underlined
highlight! link deniteMode Comment
highlight! link deniteSource_QuickfixPosition qfLineNr
" }}}

" Plugin: vim-operator-flashy {{{
" ---------------------------------------------------------
highlight! link Flashy DiffText
" }}}

" Plugin: vim-bookmarks {{{
let g:bookmark_sign = '⚐'
highlight! BookmarkSign            ctermfg=12 guifg=#4EA9D7
highlight! BookmarkAnnotationSign  ctermfg=11 guifg=#EACF49
" }}}

" Plugin: vim-choosewin {{{
" ---------------------------------------------------------
let g:choosewin_label = 'SDFJKLZXCV'
let g:choosewin_overlay_enable = 1
let g:choosewin_statusline_replace = 1
let g:choosewin_overlay_clear_multibyte = 0
let g:choosewin_blink_on_land = 0

let g:choosewin_color_label = {
	\ 'cterm': [ 236, 2 ], 'gui': [ '#555555', '#000000' ] }
let g:choosewin_color_label_current = {
	\ 'cterm': [ 234, 220 ], 'gui': [ '#333333', '#000000' ] }
let g:choosewin_color_other = {
	\ 'cterm': [ 235, 235 ], 'gui': [ '#333333' ] }
let g:choosewin_color_overlay = {
	\ 'cterm': [ 2, 10 ], 'gui': [ '#88A2A4' ] }
let g:choosewin_color_overlay_current = {
	\ 'cterm': [ 72, 64 ], 'gui': [ '#7BB292' ] }
" }}}

" vim: set foldmethod=marker ts=2 sw=0 tw=80 noet :

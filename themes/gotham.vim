" mwcm - gotham
" mostly copied from rafi-2017
" +
" https://github.com/whatyouhide/vim-gotham/blob/master/colors/gotham.vim
" =========================

" Bootstrap ===================================================================

hi clear
if exists('syntax_on') | syntax reset | endif
set background=dark
let g:colors_name = 'gotham'


" Helper functions =============================================================

" Execute the 'highlight' command with a List of arguments.
function! s:Highlight(args)
  exec 'highlight ' . join(a:args, ' ')
endfunction

function! s:AddGroundValues(accumulator, ground, color)
  let new_list = a:accumulator
  for [where, value] in items(a:color)
    call add(new_list, where . a:ground . '=' . value)
  endfor

  return new_list
endfunction

function! s:Col(group, fg_name, ...)
  " ... = optional bg_name

  let pieces = [a:group]

  if a:fg_name !=# ''
    let pieces = s:AddGroundValues(pieces, 'fg', s:colors[a:fg_name])
  endif

  if a:0 > 0 && a:1 !=# ''
    let pieces = s:AddGroundValues(pieces, 'bg', s:colors[a:1])
  endif

  call s:Clear(a:group)
  call s:Highlight(pieces)
endfunction

function! s:Attr(group, attr)
  let l:attrs = [a:group, 'term=' . a:attr, 'cterm=' . a:attr, 'gui=' . a:attr]
  call s:Highlight(l:attrs)
endfunction

function! s:Clear(group)
  exec 'highlight clear ' . a:group
endfunction


" Colors ======================================================================

" Let's store all the colors in a dictionary.
let s:colors = {}

" Base colors.
let s:colors.base0 = { 'gui': '#0c1014', 'cterm': 0 }
let s:colors.base1 = { 'gui': '#11151c', 'cterm': 8 }
let s:colors.base2 = { 'gui': '#091f2e', 'cterm': 10 }
let s:colors.base3 = { 'gui': '#0a3749', 'cterm': 12 }
let s:colors.base4 = { 'gui': '#1e6479', 'cterm': 11 }
let s:colors.base5 = { 'gui': '#599cab', 'cterm': 14 }
let s:colors.base6 = { 'gui': '#99d1ce', 'cterm': 7 }
let s:colors.base7 = { 'gui': '#d3ebe9', 'cterm': 15 }

" Other colors.
let s:colors.red     = { 'gui': '#c23127', 'cterm': 1  }
let s:colors.orange  = { 'gui': '#d26937', 'cterm': 9  }
let s:colors.yellow  = { 'gui': '#edb443', 'cterm': 3  }
let s:colors.magenta = { 'gui': '#888ca6', 'cterm': 13 }
let s:colors.violet  = { 'gui': '#4e5166', 'cterm': 5  }
let s:colors.blue    = { 'gui': '#195466', 'cterm': 4  }
let s:colors.cyan    = { 'gui': '#33859E', 'cterm': 6  }
let s:colors.green   = { 'gui': '#2aa889', 'cterm': 2  }

" Neovim :terminal colors.
let g:terminal_color_0  = get(s:colors.base0, 'gui')
let g:terminal_color_8  = g:terminal_color_0
let g:terminal_color_1  = get(s:colors.red, 'gui')
let g:terminal_color_9  = g:terminal_color_1
let g:terminal_color_2  = get(s:colors.green, 'gui')
let g:terminal_color_10 = g:terminal_color_2
let g:terminal_color_3  = get(s:colors.yellow, 'gui')
let g:terminal_color_11 = g:terminal_color_3
let g:terminal_color_4  = get(s:colors.blue, 'gui')
let g:terminal_color_12 = g:terminal_color_4
let g:terminal_color_5  = get(s:colors.violet, 'gui')
let g:terminal_color_13 = g:terminal_color_5
let g:terminal_color_6  = get(s:colors.cyan, 'gui')
let g:terminal_color_14 = g:terminal_color_6
let g:terminal_color_7  = get(s:colors.base6, 'gui')
let g:terminal_color_15 = g:terminal_color_7


" Native highlighting ==========================================================

let s:background = 'base0'
let s:linenr_background = 'base1'

" Everything starts here.
call s:Col('Normal', 'base6', s:background)

" Line, cursor and so on.
call s:Col('Cursor', 'base1', 'base6')
call s:Col('CursorLine', '', 'base1')
call s:Col('CursorColumn', '', 'base1')

" Sign column, line numbers.
call s:Col('LineNr', 'blue', s:linenr_background)
call s:Col('CursorLineNr', 'base5', s:linenr_background)
call s:Col('SignColumn', '', s:linenr_background)
call s:Col('ColorColumn', '', s:linenr_background)

" Visual selection.
call s:Col('Visual', '', 'base3')

" Easy-to-guess code elements.
call s:Col('Comment', 'blue')
call s:Col('String', 'green')
call s:Col('Number', 'orange')
call s:Col('Statement', 'base5')
call s:Col('Special', 'orange')
call s:Col('Identifier', 'base5')

" Constants, Ruby symbols.
call s:Col('Constant', 'magenta')

" Some HTML tags (<title>, some <h*>s)
call s:Col('Title', 'orange')

" <a> tags.
call s:Col('Underlined', 'yellow')
call s:Attr('Underlined', 'underline')

" Types, HTML attributes, Ruby constants (and class names).
call s:Col('Type', 'orange')

" Stuff like 'require' in Ruby.
call s:Col('PreProc', 'red')

" Tildes on the bottom of the page.
call s:Col('NonText', 'blue')

" Concealed stuff.
call s:Col('Conceal', 'cyan', s:background)

" TODO and similar tags.
call s:Col('Todo', 'magenta', s:background)

" The column separating vertical splits.
call s:Col('VertSplit', 'blue', s:linenr_background)
call s:Col('StatusLineNC', 'blue', 'base2')

" Matching parenthesis.
call s:Col('MatchParen', 'base6', 'orange')

" Special keys, e.g. some of the chars in 'listchars'. See ':h listchars'.
call s:Col('SpecialKey', 'base3')

" Folds.
call s:Col('Folded', 'base6', 'blue')
call s:Col('FoldColumn', 'base5', 'base3')

" Searching.
call s:Col('Search', 'base2', 'yellow')
call s:Attr('IncSearch', 'reverse')

" Popup menu.
call s:Col('Pmenu', 'base6', 'base2')
call s:Col('PmenuSel', 'base7', 'blue')
call s:Col('PmenuSbar', '', 'base2')
call s:Col('PmenuThumb', '', 'blue')

" Command line stuff.
call s:Col('ErrorMsg', 'red', 'base1')
call s:Col('Error', 'red', 'base1')
call s:Col('ModeMsg', 'blue')
call s:Col('WarningMsg', 'red')

" Wild menu.
" StatusLine determines the color of the non-active entries in the wild menu.
call s:Col('StatusLine', 'base5', 'base2')
call s:Col('WildMenu', 'base7', 'cyan')

" The 'Hit ENTER to continue prompt'.
call s:Col('Question', 'green')

" Spelling.
call s:Col('SpellBad', 'base7', 'red')
call s:Col('SpellCap', 'base7', 'blue')
call s:Col('SpellLocal', 'yellow')
call s:Col('SpellRare', 'base7', 'violet')

" Diffing.
call s:Col('DiffAdd', 'base7', 'green')
call s:Col('DiffChange', 'base7', 'blue')
call s:Col('DiffDelete', 'base7', 'red')
call s:Col('DiffText', 'base7', 'cyan')
call s:Col('DiffAdded', 'green')
call s:Col('DiffChanged', 'blue')
call s:Col('DiffRemoved', 'red')
call s:Col('DiffSubname', 'blue')

" Directories (e.g. netrw).
call s:Col('Directory', 'cyan')


" Programming languages and filetypes ==========================================

" Ruby.
call s:Col('rubyDefine', 'blue')
call s:Col('rubyStringDelimiter', 'green')

" HTML (and often Markdown).
call s:Col('htmlArg', 'blue')
call s:Col('htmlItalic', 'magenta')
call s:Col('htmlBold', 'cyan', '')

" Python
call s:Col('pythonStatement', 'blue')


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

" Popup menu.
" ---------------------------------------------------------
call s:Col('Pmenu', 'base6', 'base1')
call s:Col('PmenuSel', 'base7', 'blue')
call s:Col('PmenuSbar', '', 'base2')
call s:Col('PmenuThumb', '', 'blue')

" Tabline {{{
" ---------------------------------------------------------
"

" TODO: SHOULD ACTIVE TABLINE + STATUSLINE FONT COLOR BE WHITE INSTEAD OF base6?


" TabLineFill: Tab pages line, where there are no labels
call s:Col('TablineFill', 'base4', 'base3')

" TabLine: Not-active tab page label
call s:Col('Tabline', 'base5', 'base3')

" TabLineSel: Active tab page label
call s:Col('TablineSel', 'base7', 'base4')

" Custom
call s:Col('TablineSelShade', 'base6', 'base4')
call s:Col('TabLineAlt',      'base7', 'base4')
call s:Col('TablineAltShade', 'cyan', 'base3')


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
"highlight StatusLine   ctermfg=4 ctermbg=248 guifg=#30302c guibg=#a8a897
"highlight StatusLineNC ctermfg=236 ctermbg=242 guifg=#30302c guibg=#666656
call s:Col('StatusLine', 'base7', 'base3')
call s:Col('StatusLineNC', 'base5', 'base3')

" Filepath color
call s:Col('User1', 'base7', 'base3')
" Line and column information
call s:Col('User2', 'base7', 'base4')
" Line and column corner arrow
call s:Col('User3', 'base7', 'base3')
" Buffer # symbol and whitespace or syntax errors
call s:Col('User4', 'base7', 'base3')
" Write symbol
call s:Col('User6', 'base7', 'base3')
" Paste symbol
call s:Col('User7', 'base7', 'base3')
" Syntax and whitespace
call s:Col('User8', 'base7', 'base3')
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
"

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
let g:gitgutter_max_signs=9999
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

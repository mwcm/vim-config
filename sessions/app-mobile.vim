let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Projects/app-mobile/src/categories/RideshareNavigator/views/DriveNavigator/DriveMain
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 DriveButton.js
badd +0 DriveMain.js
argglobal
silent! argdel *
$argadd DriveButton.js
edit DriveButton.js
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=1 winminwidth=1 winheight=1 winwidth=1
wincmd =
argglobal
let s:l = 158 - ((59 * winheight(0) + 31) / 63)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
158
normal! 030|
wincmd w
argglobal
if bufexists('DriveMain.js') | buffer DriveMain.js | else | edit DriveMain.js | endif
let s:l = 43 - ((42 * winheight(0) + 31) / 63)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
43
normal! 018|
wincmd w
wincmd =
tabnext 1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=30 winminheight=1 winminwidth=1 shortmess=aoOTIcF
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :

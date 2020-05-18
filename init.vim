execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/vimrc'
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ }
let g:LanguageClient_rootMarkers = {
    \ 'javascript': ['jsconfig.json'],
    \ }

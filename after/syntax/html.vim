autocmd FileType html :setlocal sw=2 ts=2 sts=2

" HTML 5 tags
syn keyword htmlTagName contained article aside audio bb canvas command datagrid
syn keyword htmlTagName contained datalist details dialog embed figure footer
syn keyword htmlTagName contained header hgroup keygen mark meter nav output
syn keyword htmlTagName contained progress time ruby rt rp section time video

" HTML 5 arguments
syn keyword htmlArg contained autofocus placeholder min max step
syn keyword htmlArg contained contenteditable contextmenu draggable hidden item
syn keyword htmlArg contained itemprop list subject spellcheck
" this doesn't work because default syntax file alredy define a 'data' attribute
syn match htmlArg "\<\(data-[\-a-zA-Z0-9_]\+\)=" contained

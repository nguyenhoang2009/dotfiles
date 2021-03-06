"function! s:on_lsp_buffer_enabled() abort
"    " use omnifunc if you are fine with it.
"    setlocal omnifunc=lsp#complete
"    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"    " some mappings to use, tweak as you wish.
"    nmap <buffer> gd <plug>(lsp-definition)
"    nmap <buffer> gr <plug>(lsp-references)
"    nmap <buffer> gi <plug>(lsp-implementation)
"    nmap <buffer> gt <plug>(lsp-type-definition)
"    nmap <buffer> <leader>rn <plug>(lsp-rename)
"    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
"    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
"    nmap <buffer> K <plug>(lsp-hover)
"endfunction
"
"augroup lsp_install
"    au!
"    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
"augroup END
"
"
"" whether to enable diagnostics for vim-lsp (we may want to use ALE for other
"" plugins for that.
"let g:lsp_diagnostics_enabled = 1
"
"" show diagnostic signs
"let g:lsp_signs_enabled = 1
"let g:lsp_signs_error = {'text': '✗'}
"let g:lsp_signs_warning = {'text': '!'}
"let g:lsp_highlights_enabled = 0
"
"" Do not use virtual text, they are far too obtrusive.
"let g:lsp_virtual_text_enabled = 0
"" echo a diagnostic message at cursor position
"let g:lsp_diagnostics_echo_cursor = 0
"" show diagnostic in floating window
"let g:lsp_diagnostics_float_cursor = 1
"" whether to enable highlight a symbol and its references
"let g:lsp_highlight_references_enabled = 1
"let g:lsp_preview_max_width = 80

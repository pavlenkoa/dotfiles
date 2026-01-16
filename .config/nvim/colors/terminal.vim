" Terminal colorscheme
" Uses dunno's color palette

hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "terminal"
set background=dark

" Palette (from dunno):
" purple:  #a076f5 (comments)
" orange:  #f57b1b (strings, constants)
" pink:    #f556b0 (statements, types)
" cyan:    #65e0e0 (functions, special)
" blue:    #0985ba (identifiers)
" white:   #dadada (text)

" Editor UI
hi Normal       guifg=#dadada ctermfg=253 guibg=NONE ctermbg=NONE
hi LineNr       guifg=#585858 ctermfg=240 guibg=NONE
hi CursorLineNr guifg=#ffff00 ctermfg=226 gui=bold cterm=bold
hi CursorLine   guibg=#303030 ctermbg=236 cterm=NONE
hi Visual       guifg=#000000 guibg=#8787af ctermfg=0 ctermbg=103
hi Search       guifg=#444444 guibg=#ffff5f ctermfg=238 ctermbg=227
hi IncSearch    guifg=#444444 guibg=#ffff5f ctermfg=238 ctermbg=227 gui=bold cterm=bold
hi MatchParen   guifg=#c6c6c6 guibg=#4e4e4e ctermfg=251 ctermbg=239
hi VertSplit    guifg=#5f8787 guibg=#1c1c1c ctermfg=66 ctermbg=234
hi StatusLine   guifg=#eeeeee guibg=#080808 ctermfg=255 ctermbg=232
hi StatusLineNC guifg=#d0d0d0 guibg=#444444 ctermfg=252 ctermbg=238
hi Pmenu        guifg=#c6c6c6 guibg=#303030 ctermfg=251 ctermbg=236
hi PmenuSel     guifg=#c6c6c6 guibg=#303030 ctermfg=251 ctermbg=236 gui=reverse cterm=reverse
hi SignColumn   guifg=#008700 guibg=NONE ctermfg=28 ctermbg=NONE
hi Folded       guifg=#d787ff guibg=#5f005f ctermfg=177 ctermbg=53
hi WildMenu     guifg=#1c1c1c guibg=#afd700 ctermfg=234 ctermbg=148
hi Title        guifg=#a076f5 ctermfg=141

" Syntax highlighting
hi Comment      guifg=#a076f5 ctermfg=141 gui=NONE cterm=NONE
hi String       guifg=#f57b1b ctermfg=208
hi Character    guifg=#f57b1b ctermfg=208
hi Number       guifg=#f57b1b ctermfg=208
hi Float        guifg=#f57b1b ctermfg=208
hi Boolean      guifg=#008700 ctermfg=28
hi Constant     guifg=#f57b1b ctermfg=208

hi Identifier   guifg=#0985ba ctermfg=31 gui=NONE cterm=NONE
hi Function     guifg=#65e0e0 ctermfg=80

hi Statement    guifg=#f556b0 ctermfg=206 gui=NONE cterm=NONE
hi Keyword      guifg=#dadada ctermfg=253
hi Conditional  guifg=#f556b0 ctermfg=206
hi Repeat       guifg=#f556b0 ctermfg=206
hi Operator     guifg=#65e0e0 ctermfg=80
hi Exception    guifg=#f556b0 ctermfg=206

hi PreProc      guifg=#dadada ctermfg=253
hi Include      guifg=#dadada ctermfg=253
hi Define       guifg=#dadada ctermfg=253
hi Macro        guifg=#65e0e0 ctermfg=80

hi Type         guifg=#f556b0 ctermfg=206 gui=NONE cterm=NONE
hi StorageClass guifg=#f556b0 ctermfg=206
hi Structure    guifg=#f556b0 ctermfg=206
hi Typedef      guifg=#f556b0 ctermfg=206

hi Special      guifg=#65e0e0 ctermfg=80
hi Delimiter    guifg=#65e0e0 ctermfg=80
hi SpecialComment guifg=#a076f5 ctermfg=141

hi Error        guifg=#af005f guibg=#5f0000 ctermfg=125 ctermbg=52
hi Todo         guifg=#000000 guibg=#d70087 ctermfg=0 ctermbg=162 gui=bold cterm=bold

" Diff
hi DiffAdd      guifg=#87d700 guibg=#005f00 ctermfg=112 ctermbg=22
hi DiffDelete   guifg=#af005f guibg=#5f0000 ctermfg=125 ctermbg=52
hi DiffChange   guifg=#d0d0d0 guibg=#005f5f ctermfg=252 ctermbg=23
hi DiffText     guifg=#5fffff guibg=#008787 ctermfg=87 ctermbg=30

" Shell specific
hi shFunction   guifg=#f57b1b ctermfg=208
hi shStatement  guifg=#65e0e0 ctermfg=80
hi shConditional guifg=#f556b0 ctermfg=206
hi shLoop       guifg=#f556b0 ctermfg=206
hi shVariable   guifg=#0985ba ctermfg=31
hi shDeref      guifg=#0985ba ctermfg=31
hi shShellVariables guifg=#0985ba ctermfg=31
hi shSet        guifg=#65e0e0 ctermfg=80
hi shSetList    guifg=#dadada ctermfg=253
hi shCommandSub guifg=#65e0e0 ctermfg=80
hi shOption     guifg=#f57b1b ctermfg=208

" Zsh specific
hi zshVariable  guifg=#0985ba ctermfg=31
hi zshVariableDef guifg=#0985ba ctermfg=31
hi zshDeref     guifg=#0985ba ctermfg=31
hi zshFunction  guifg=#f57b1b ctermfg=208
hi zshKeyword   guifg=#f556b0 ctermfg=206

" Git signs
hi GitSignsAdd    guifg=#008700 ctermfg=28 guibg=NONE ctermbg=NONE
hi GitSignsChange guifg=#f57b1b ctermfg=208 guibg=NONE ctermbg=NONE
hi GitSignsDelete guifg=#f556b0 ctermfg=206 guibg=NONE ctermbg=NONE

" Treesitter
hi link @comment Comment
hi link @string String
hi link @number Number
hi link @boolean Boolean
hi link @function Function
hi link @keyword Keyword
hi link @type Type
hi link @variable Identifier
hi link @constant Constant
hi link @operator Operator
hi link @property Identifier

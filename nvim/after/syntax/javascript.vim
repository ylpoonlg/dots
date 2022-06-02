syn keyword javaScriptKeyword function for while if do
syn match javaScriptFunction "\h\w*\s*("he=e-1

hi link javaScriptFunction   Function
hi link javaScriptKeyword    Keyword
hi link javaScriptIdentifier Type
hi link javaScriptBraces     Identifier

set tabstop=2 shiftwidth=2

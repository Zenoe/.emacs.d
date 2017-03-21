$0 ¡ú the position the cursor (after the snippte is inserted). You don't need to put a $0 if you don't need to.
$n ¡ú a field, where the n is a integer starting with 1. (Example: $1, $2, ¡­). Pressing tab will move cursor to these stops for user to fill in. Multiple occurrence of the same $n means typing in one field will automatically fill the other.
${n:default_text} ¡ú same as $n, but provides a default text.
$& ¡ú means indent the line according to the mode's indentation rule.
`¡­` ¡ú (backtick) is used to enclose elisp code. The lisp code will be evaluated in the same buffer the snippet is being expanded.
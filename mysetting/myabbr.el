(define-abbrev-table 'global-abbrev-table '(

    ;; math/unicode symbols
    ;; ("8in" "âˆ?)
    ;; ("8nin" "âˆ?)
    ;; ("8inf" "âˆ?)
    ;; ("8luv" "â™?)
    ;; ("8smly" "â˜?)

    ;; email
    ("8me" "2004lzy156@163.com")
    ("8ge" "gauss.cn@gmail.com")

    ;; computing tech
    ("8ms" "Microsoft")
    ("8win" "Windows")

    ;; normal english words

    ;; signature
    ("8lz" "linzhengyuan")

    ;; emacs regex
    ("8d" "\\([0-9]+?\\)")
    ("8str" "\\([^\"]+?\\)\"")

    ;; shell commands
    ;; ("8ditto" "ditto -ck --sequesterRsrc --keepParent src dest")
    ;; ("8im" "convert -quality 85% ")

    ;; ("8f0" "find . -type f -size 0 -exec rm {} ';'")
    ;; ("8rsync" "rsync -z -r -v -t --exclude=\"*~\" --exclude=\".DS_Store\" --exclude=\".bash_history\" --exclude=\"**/xx_xahlee_info/*\"  --exclude=\"*/_curves_robert_yates/*.png\" --exclude=\"logs/*\"  --exclude=\"xlogs/*\" --delete --rsh=\"ssh -l xah\" ~/web/ xah@example.com:~/")
    ))

;; stop asking whether to save newly added abbrev when quitting emacs
(setq save-abbrevs nil)

;; turn on abbrev mode globally
(setq-default abbrev-mode t)
;; (define-abbrev-table 'python-mode-abbrev-table
;;   '(
;;     ("isettings" "from django.conf import settings")
;;     ("irequestcontext" "from django.template import RequestContext")
;;     ("imodel" "from django.db import models")
;;     ("iform" "from django import forms")
;;     )
;;   )

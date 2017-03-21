;; php
(setq load-path (cons "/home/cjones/geben-0.26" load-path))

(setq load-path (cons "~/.emacs.d/private/mysetting/geben-0.26" load-path))
(autoload 'geben "geben" "DBGp protocol frontend, a script debugger" t)

;; Debug a simple PHP script.
;; Change the session key my-php-54 to any session key text you like
(defun my-php-debug ()
  "Run current PHP script for debugging with geben"
  (interactive)
  (call-interactively 'geben)
  (shell-command
   ;; (concat "XDEBUG_CONFIG='idekey=my-php-54' '\"d:\\Program Files\\Apache Software Foundation\\php-5.4.45\\php\" '"
   (concat "XDEBUG_CONFIG='idekey=my-php-54' php "
           (convert-cygwin-path buffer-file-name) " &"))
  " &")


(global-set-key [f5] 'my-php-debug)

(provide 'myphp)
;; php-end

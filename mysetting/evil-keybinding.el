;; (evil-leader/set-key "jn" 'avy-goto-line-below)
;; (evil-leader/set-key "jp" 'avy-goto-line-above)
;; (evil-leader/set-key "jw" 'avy-goto-word-1-below)
;; (evil-leader/set-key "jb" 'avy-goto-word-1-above)
;; (evil-leader/set-key "jc" 'avy-goto-char)
(nvmap "gl" 'evil-last-non-blank)
(nvmap "gy" 'paste-next-line)

(define-key evil-normal-state-map (kbd "RET")
  (lambda(count)
    (interactive "p")
    (if (= count 1)
        (evil-open-below())
      (evil-open-above()))
    (evil-normal-state)))

 ;; (kbd "S-RET") can not bind to shift-return

(defun cancel-selection ()
  (interactive) ;; with this would cause:  Emacs Lisp error ¡°Wrong type argument: commandp¡±
  (exchange-point-and-mark )
  (evil-normal-state)
  )
;; gv: repeate last selection

(defun switch-to-scratch-buffer ()
  "Switch to the `*scratch*' buffer. Create it first if needed."
  (interactive)
  (let ((exists (get-buffer "*scratch*")))
    (switch-to-buffer (get-buffer-create "*scratch*"))
    ))

(global-set-key (kbd "C-x C-e") 'eval-current-line)
(define-key evil-normal-state-map (kbd ", TAB") 'back-to-previous-buffer)
;; (define-key evil-normal-state-map (kbd ", SPC") 'recentf-open-most-recent-file-3)
(define-key evil-insert-state-map (kbd "M-SPC") 'surround-next-text)
;; (bind-key "C-x C-e" 'eval-current-line)
;; (unbind-key "C-x z")
;; (bind-key "C-x C-z" 'repeat)
;; (bind-key "C-x C-e" 'eval-current-line)

;;http://emacs.stackexchange.com/questions/14553/how-call-the-eval-sexp-function-with-the-right-argument
(defun eval-current-line (arg)
  (interactive "P")
  (evil-set-marker ?8) ;;The number 8 is just abritrary
  (line-end-position)
  ;; (sp-end-of-sexp)
  (eval-last-sexp arg)
  (evil-goto-mark ?8))

(defun surround-next-text ()
  (interactive)
  (insert "(")
  (move-end-of-line 1)
  (insert ")")
  )

;; (defun copy-current-line ()
;;   (interactive )
;; (message (trim-string (buffer-substring-no-properties
;;        (line-beginning-position)
;;        (line-end-position))
;;        ))
;; ;; (message (trim-string (thing-at-point 'line)))
;; )

(defun paste-next-line ()
  "trim text in kill-ring and paste in the next line with proper indentation"
  (interactive)
  (evil-open-below())
  (insert (trim-string (car kill-ring)))
  (evil-normal-state)
    ;; (yank)
 )

;; (defun was-yanked ()
;;   "When called after a yank, store last yanked value in let-bound yanked."
;;   "http://stackoverflow.com/questions/22960031/save-yanked-text-to-string-in-emacs "
;;   (interactive)
;;   (let (yanked)
;;     (and (eq last-command 'yank)
;;          (setq yanked (car kill-ring)))))

(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
(replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string))
)
(global-set-key (kbd "C-0") 'set-mark-command)
(global-unset-key (kbd "C-@"))

;; (defun set-selective-display-dlw (&optional level)
;; "Fold text indented same of more than the cursor.
;; If level is set, set the indent level to LEVEL.
;; If 'selective-display' is already set to LEVEL, clicking
;; F5 again will unset 'selective-display' by setting it to 0."
;;   (interactive "P")
;;   (if (eq selective-display (1+ (current-column)))
;;       (set-selective-display 0)
;;     (set-selective-display (or level (1+ (current-column))))))
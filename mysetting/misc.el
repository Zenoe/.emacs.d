;; font
(set-frame-font "Inconsolata-12")
(setq ring-bell-function 'ignore)
(setq neo-autorefresh nil)
;; (cond ((eq system-type 'darwin)  ( (lambda () (
;;                                                (set-face-attribute 'default nil :font
;;                                                                    (format "%s:pixelsize=%d" (car fonts) 12))
;;                                                ))))
;;             ((eq system-type 'gnu/linux)  (lambda () ()))
;;             ((eq system-type 'windows-nt)  ((lambda () (let ((fonts '("Consolas"  "Microsoft Yahei")))
;;                                                          (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;                                                            (set-fontset-font (frame-parameter nil 'font) charset
;;                                                                              (font-spec :family (car (cdr fonts)))))
;;                                                         )))))
;; font end

(eval-after-load 'evil-commands
  '(progn
    (evil-define-motion evil-goto-curdef ()
      :jump t  ;; may means to push a marker before jumping, so that it's possible to back to last position
      :type exclusive
      (interactive)
      (if (bounds-of-thing-at-point 'defun)
          (save-restriction
            (narrow-to-defun)
            (evil-goto-definition))
        (evil-goto-definition)))

    (defun space-paste ()
      (interactive)
      (forward-char)
      (insert " ")
      (yank)
      )
    (fset 'evil-visual-update-x-selection 'ignore)
    (define-key evil-normal-state-map "gh" 'evil-goto-curdef)
    (define-key evil-normal-state-map "gp" 'space-paste)
))

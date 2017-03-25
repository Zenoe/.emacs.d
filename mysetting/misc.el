;; font
(set-frame-font "Inconsolata-12")
(cond ((eq system-type 'darwin)  ( (lambda () (
                                               (set-face-attribute 'default nil :font
                                                                   (format "%s:pixelsize=%d" (car fonts) 12))
                                               ))))
            ((eq system-type 'gnu/linux)  (lambda () ()))
            ((eq system-type 'windows-nt)  ((lambda () (let ((fonts '("Consolas"  "Microsoft Yahei")))
                                                         (dolist (charset '(kana han symbol cjk-misc bopomofo))
                                                           (set-fontset-font (frame-parameter nil 'font) charset
                                                                             (font-spec :family (car (cdr fonts)))))
                                                        )))))
;; font end
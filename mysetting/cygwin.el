;; (global-set-key [f12] 'open-buffer-path)
(global-set-key [f12] 'explorer-buffer)

(when (string-equal system-type "cygwin")
  (setq file-name-coding-system 'gbk)
  (setq slime-to-lisp-filename-function 
        (lambda (x)
          (let ((prefix (substring x 0 3)))
            (if (string-equal prefix "/c/")
                (substring x 2)
              (concatenate 'string "/cygwin64" x)
              ))))
  (setq slime-from-lisp-filename-function
        (lambda (y)
          (let ((prefix "C:/cygwin64/"))
            (if (string-equal (substring y 0 (length prefix)) prefix)
                (substring y (- (length prefix) 1))
              (concatenate 'string "/c/" (substring y 3))))))

  ;; (setq slime-path "C:/cygwin64/home/ab/.emacs.d/elpa/slime-20160419.858/")
  ;; (setq slime-backend "/C\:/cygwin64/home/ab/.emacs.d/elpa/slime-20160419.858/swank-loader.lisp")
)


;; shell
;; shell-file-name is the variable that controls which shell Emacs uses when it wants to run a shell command.
;; explicit-shell-file-name is the variable that controls which shell M-x shell starts up.
;; (defun shell-cygwin ()
;;   "Run cygwin bash in shell mode."
;;   (interactive)
;;   ;; (let ((explicit-shell-file-name "/cygdrive/d/cygwin/bin/bash"))
;;   (let ((explicit-shell-file-name "/cygdrive/d/portable/.babun/cygwin/bin/bash"))
;;     ;; (let ((explicit-shell-file-name "D:/cygwin/bin/mintty"))
;;     (call-interactively 'shell)))

;; (defun convert-cygwin-path(cygwin-path)
;;   (let ((path nil))
;;     (setq path ( replace-regexp-in-string "/cygdrive/\\([a-zA-Z]\\)\/" "\\1:/" cygwin-path ))
;;     (setq path ( replace-regexp-in-string "/" "\\\\" path t t ))
;;     ))


(defun explorer-buffer ()
  (interactive)
  (cond
    ((string-equal system-type "cygwin") (cygwin-explore) )
    ((string-equal system-type "windows-nt") (win-explore))
    ((string-equal system-type "darwin") (shell-command "open ."))
   ))

(defun cygwin-explore ()
  "Find the current buffer in Windows explorer.exe"
  (cond
   ;; In buffers with file names
   ((buffer-file-name)
    (shell-command (concat "cygstart explorer.exe /e,/select, \"$(cygpath -w \"" buffer-file-name "\")\"")))
   ;; In dired-mode
   ((eq major-mode 'dired-mode)
    (shell-command (concat "cygstart explorer.exe /e, \"$(cygpath -w \"" (dired-current-directory) "\")\"")))
   ;; fallback to default-directory
   (t
    (shell-command (concat "cygstart explorer.exe /e, \"$(cygpath -w \"" default-directory "\")\"")))
   ))

;; (when (string-equal system-type "windows-nt")
;;   (setq file-name-coding-system 'gbk)
;;   (setenv "PATH" (mapconcat 'identity mypaths ";") )
;;   (setenv "PATH" (concat (getenv "PATH") ":" (expand-file-name "~/mybin")))
;;   (setenv "PATH" (concat (getenv "PATH") ";" "D:/portable/ispell"))
;;   (add-to-list 'exec-path "D:/portable/ispell")
;;   (add-to-list 'exec-path "D:/cygwin/usr/bin")
;;   (setq exec-path (list "D:/cygwin/usr/local/bin" "D:/cygwin/usr/bin"))
;;   (setq exec-path (append mypaths (list "." exec-directory)) )
;;   )

;; could be put into lambda
(defun win-explore ()
  (let ((path nil))
  ;; (message-box "%s" ( replace-regexp-in-string "/cygdrive/\([a-z]\)/" "\1" ( convert-standard-filename dired-directory ) t t))
    (if ( equal major-mode 'dired-mode )
        ( setq path (convert-standard-filename dired-directory) )
      (setq path (convert-standard-filename buffer-file-name)))
;; (defun convert-cygwin-path(cygwin-path)
;;   (let ((path nil))
;;     (setq path ( replace-regexp-in-string "/cygdrive/\\([a-zA-Z]\\)\/" "\\1:/" cygwin-path ))
;;     (setq path ( replace-regexp-in-string "/" "\\\\" path t t ))
;;     ))

;;    (setq path (convert-cygwin-path path))
  (shell-command (concat "explorer " (if (equal major-mode 'dired-mode)
                                         (concat "/e,"  path)
                                       (concat "/e,/select," path))))
  ))

(require 'dired)

(define-key dired-mode-map "\C-c\C-w" 'dired-copy-paste-do-cut)
(define-key dired-mode-map "\C-c\C-c" 'dired-copy-paste-do-copy)
(define-key dired-mode-map "\C-c\C-y" 'dired-copy-paste-do-paste)
(define-key dired-mode-map "\C-i" 'ivy-switch-buffer)


(defvar dired-copy-paste-func nil)
(defvar dired-copy-paste-stored-file-list nil)


(defun dired-copy-paste-do-cut ()
  "In dired-mode, cut a file/dir on current line or all marked file/dir(s)."
  (interactive)
  (setq dired-copy-paste-stored-file-list (dired-get-marked-files)
        dired-copy-paste-func 'rename-file)
  (message
   (format "%S is/are cut."dired-copy-paste-stored-file-list)))


(defun dired-copy-paste-do-copy ()
  "In dired-mode, copy a file/dir on current line or all marked file/dir(s)."
  (interactive)
  (setq dired-copy-paste-stored-file-list (dired-get-marked-files)
        dired-copy-paste-func 'copy-file)
  (message
   (format "%S is/are copied."dired-copy-paste-stored-file-list)))


(defun dired-copy-paste-do-paste ()
  "In dired-mode, paste cut/copied file/dir(s) into current directory."
  (interactive)
  (let ((stored-file-list nil))
    (dolist (stored-file dired-copy-paste-stored-file-list)
      (condition-case nil
          (progn
            (funcall dired-copy-paste-func stored-file (dired-current-directory) 1)
            (push stored-file stored-file-list))
        (error nil)))
    (if (eq dired-copy-paste-func 'rename-file)
        (setq dired-copy-paste-stored-file-list nil
              dired-copy-paste-func nil))
    (revert-buffer)
    (message
     (format "%d file/dir(s) pasted into current directory." (length stored-file-list)))))

(defun counsel-goto-dir-buffer ()
  "Goto dir bufer"
  (interactive)
  ;; (let* ((collection (append (mapcar 'derived-mode-p buffer-list))))

  (let ((blist (ibuffer-list-buffers)))
(let ((recent-dirs  (diredp-remove-if #'diredp-root-directory-p
                                                 (diredp-delete-dups
                                                  (mapcar (lambda (f/d)
                                                            (if (file-directory-p f/d) f/d (file-name-directory f/d)))
                                                          blist)))))
    (ivy-read "dir:" recent-dirs :action 'dired))
    )
)


  ;; (let ((list (buffer-list)))
  ;; (let* ((collection (append (mapcar (lambda (x) (if (derived-mode-p x)
  ;;                                                    x
  ;;                                                  nil)) list))))
  ;;   (ivy-read "directories:" list :action 'dired))))


(provide 'dired-copy-paste)
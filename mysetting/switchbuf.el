;; buffer switching

;; (global-set-key [f3] 'helm-dired-buffer)
(global-set-key [f9] 'wicked/toggle-shell)
(global-set-key [f8] 'wicked/toggle-dired)
;; (global-set-key [f7] 'wicked/toggle-w3m)

(global-set-key (kbd "<f7>") 'xah-previous-user-buffer)
(global-set-key (kbd "<S-f7>") 'xah-next-user-buffer)

(toggle-frame-maximized)

;; (defun helm-dired-buffer()
;;   (interactive)
;;   (let ((blist (buffer-list))(rlist))
;;     (while blist
;;       ;; (if ( equal ( buffer-name ( car blist ) ) "index.php" )
;;       (if (with-current-buffer (car blist)
;;             ( derived-mode-p 'dired-mode ))
;;           ;; ( setq rlist ( append rlist ( list (cdr blist) ) ) )
;;           ( setq rlist ( append rlist ( list ( buffer-name ( car blist ) ) ) ) )
;;         )
;;       (setq blist (cdr blist))
;;       )

;;     (setq some-helm-source
;;           '((name . "HELM Dired")
;;             ;; (candidates . recentf-list)
;;             (candidates . rlist)
;;             (action . (lambda (candidate)
;;                         ;; (message-box "%s" candidate)
;;                         (switch-to-buffer (get-buffer candidate)))))
;;           )
;;     ;; ( message-box "%s" tlist )
;;     (helm :sources '(some-helm-source))))

;; (defun wicked/toggle-w3m ()
;;   "Switch to a w3m buffer or return to the previous buffer."
;;   (interactive)
;;   (if (derived-mode-p 'w3m-mode)
;;       ;; Currently in a w3m buffer
;;       ;; Bury buffers until you reach a non-w3m one
;;       (while (derived-mode-p 'w3m-mode)
;; 	(bury-buffer))
;;     ;; Not in w3m
;;     ;; Find the first w3m buffer
;;     (let ((list (buffer-list)))
;;       (while list
;; 	(if (with-current-buffer (car list)
;; 	      (derived-mode-p 'w3m-mode))
;; 	    (progn
;; 	      (switch-to-buffer (car list))
;; 	      (setq list nil))
;; 	  (setq list (cdr list))))
;;       (unless (derived-mode-p 'w3m-mode)
;; 	(call-interactively 'w3m)))))

(defun wicked/toggle-shell ()
  "Switch to a shell buffer or return to the previous buffer."
  (interactive)
  (if (derived-mode-p 'shell-mode)
      ;; Currently in a shell buffer
      ;; Bury buffers until you reach a non-shell one
      (while (derived-mode-p 'shell-mode)
        (bury-buffer))
    ;; Not in shell
    ;; Find the first shell buffer
    (let ((list (buffer-list)))
      (while list
        (if (with-current-buffer (car list)
              (derived-mode-p 'shell-mode))
            (progn
              (switch-to-buffer (car list))
              (setq list nil))
          (setq list (cdr list))))
      (unless (derived-mode-p 'shell-mode)
        (call-interactively 'shell)))))

(defun wicked/toggle-dired ()
  "Switch to a dired buffer or return to the previous buffer."
  (interactive)
  (if (derived-mode-p 'dired-mode)
      ;; Currently in a dired buffer
      ;; Bury buffers until you reach a non-dired one
      (while (derived-mode-p 'dired-mode)
        (bury-buffer))
    ;; Not in dired
    ;; Find the first dired buffer
    (let ((list (buffer-list)))
      (while list
        (if (with-current-buffer (car list)
              (derived-mode-p 'dired-mode))
            (progn
              (switch-to-buffer (car list))
              (setq list nil))
          (setq list (cdr list))))
      (unless (derived-mode-p 'dired-mode)
        (call-interactively 'dired)))))

;; (defun dired-recent (buffer)
;;   "Open Dired in BUFFER, showing the recently used directories."
;;   (interactive "BDired buffer name: ")
;;   (let ((dirs  (delete-dups
;;                 (mapcar (lambda (f/d)
;;                           (if (file-directory-p f/d)
;;                               f/d
;;                             (file-name-directory f/d)))
;;                         recentf-list))))
;;     (dired (cons (generate-new-buffer-name buffer) dirs))))


(defun xah-user-buffer-q ()
  "Return t if current buffer is a user buffer, else nil.
Typically, if buffer name starts with *, it's not considered a user buffer.
This function is used by buffer switching command and close buffer command, so that next buffer shown is a user buffer.
You can override this function to get your idea of “user buffer”.
version 2016-06-18"
  (interactive)
  (if (string-equal "*" (substring (buffer-name) 0 1))
      nil
    (if (string-equal major-mode "dired-mode")
        nil
      t
      )))

(defun xah-next-user-buffer ()
  "Switch to the next user buffer.
“user buffer” is determined by `xah-user-buffer-q'.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (xah-user-buffer-q))
          (progn (next-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))

(defun xah-previous-user-buffer ()
  "Switch to the previous user buffer.
“user buffer” is determined by `xah-user-buffer-q'.
URL `http://ergoemacs.org/emacs/elisp_next_prev_user_buffer.html'
Version 2016-06-19"
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (< i 20)
      (if (not (xah-user-buffer-q))
          (progn (previous-buffer)
                 (setq i (1+ i)))
        (progn (setq i 100))))))

(defun kill-other-buffer ()
  (interactive)
  (let ((ob nil))
    (setq ob (window-buffer (next-window)))
    (if (eq ob (current-buffer))
        (setq ob (window-buffer (previous-window))))
    (kill-buffer ob)
    (message "other window: %s" ob))
  )
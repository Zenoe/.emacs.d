;; (setq url-proxy-services '( ("http" . "127.0.0.1:1080") ))
;; (setq url-proxy-services '(("https" . "127.0.0.1:1080")))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; (global-set-key (kbd "C-q") 'quoted-insert)
(prefer-coding-system 'utf-8)
(setq bidi-display-reordering nil)
(defvar myset-folder "~/.emacs.d/mysetting/")
(load-file ( concat myset-folder "evil-keybinding.el" ))
(load-file ( concat myset-folder "cygwin.el" ))
(load-file ( concat myset-folder "switchbuf.el"))
(load-file ( concat myset-folder "misc.el"))
(load-file ( concat myset-folder "lookup.el"))
(load-file ( concat myset-folder "dired-misc.el"))
;; (load-file ( concat myset-folder "vs2010.el"))
;; (autoload 'my-php-debug "myphp" "php debug" t nil)

;; external exe
(when (string-equal system-type "windows-nt")

 ;; (message-box "%s" "windows-nt" t t)
  (add-to-list 'exec-path "d:/portable/ggtag/bin" )
  (add-to-list 'exec-path "c:/Program Files/LLVM/bin")
  (add-to-list 'exec-path "c:/Python27")
  (add-to-list 'exec-path "d:/portable/TOOL")

  ;; (add-to-list 'exec-path "D:/portable/.babun/cygwin/bin")
  (setenv "PATH"
  (concat
    "c:/Program Files/LLVM/bin" ";"
    "d:/portable/ggtag/bin" ";"
    "d:/portable/.babun/cygwin/bin" ";"
    "c:/Python27" ";"
   (getenv "PATH")
   ))
  ;; warning: devil!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ;; warning: this is a dangrous devil, load and load again makes environment variable path become empyt (overflows I think)
  ;; the hook below would cause load-vs32-env everytime when each h/c/cpp file is loaded
;; (add-hook 'c-mode-common-hook 'load-vs32-evn)
  )

(defun load-vs32-evn ()
  (interactive)
  (load-file ( concat myset-folder "vc10-86.el")))

(defun load-vs64-evn ()
  (interactive)
  (load-file ( concat myset-folder "vc10-64.el")))

(setq kill-buffer-query-functions (delq 'process-kill-buffer-query-function kill-buffer-query-functions))

;; (message-box "%s" (getenv "LIBPATH") t t)
;;python

;; (setq pdb-path '/lib/python2.7/pdb.py
;;       gud-pdb-command-name (symbol-name pdb-path))
;; (defadvice pdb (before gud-query-cmdline activate)
;;   "Provide a better default command line when called interactively."
;;   (interactive
;;    (list (gud-query-cmdline pdb-path
;;                             (file-name-nondirectory buffer-file-name)))))


;; emacs' path & exec-path http://ergoemacs.org/emacs/emacs_env_var_paths.html

;; slime
;; COMPLETELY NON-PORTABLE

;; slime end
;; scheme not worked
;; (setq scheme-program-name "csi -:c")
;; (add-to-list 'load-path "~/.emacs.d/elpa/slime-20160521.915")
;; (require 'slime)
;; (slime-setup '(slime-fancy slime-banner))
;; (add-to-list 'load-path "/usr/local/lib/chicken/8/")   ; Where Eggs are installed
;; (autoload 'chicken-slime "chicken-slime" "SWANK backend for Chicken" t)
;; (add-hook 'scheme-mode-hook
;;           (lambda ()
;;             (slime-mode t)))

;; shell
;; shell-file-name is the variable that controls which shell Emacs uses when it wants to run a shell command.
;; explicit-shell-file-name is the variable that controls which shell M-x shell starts up.

;;(require 'org-ac)
;; (put 'upcase-region 'disabled nil)
;; (setq org-startup-indented t)
;; the following cause err: Symbol's value as variable is void: org-directory
;; (setq org-default-notes-file (concat org-directory "/notes.org"));; Org Capture
;; (setq org-capture-templates
;;       '(("t" "Todo" entry (file+headline (concat org-directory "/gtd.org") "Tasks")
;;          "* TODO %?\n %i\n")
;;         ("l" "Link" plain (file (concat org-directory "/links.org"))
;;          "- %?\n %x\n")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ffip find in project
(eval-after-load 'find-file-in-project
  '(progn
     (setq-default ffip-project-file (nconc '(".eproject") ffip-project-file))))

;; lisp
(add-hook 'emacs-lisp-mode-hook
          (lambda () (local-set-key (kbd "C-c C-o") 'imenu)))


(setq help-window-select t)

(add-hook 'occur-hook
          '(lambda ()
             (switch-to-buffer-other-window "*Occur*")
             (next-line)))

(global-set-key (kbd "C-;") 'kill-this-buffer)
(global-set-key (kbd "C-M-;") 'kill-buffer-and-window)

(defun xah-open-in-external-app ()
  "Open the current file or dired marked files in external app.
The app is chosen from your OS's preference.
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2016-10-15"
  (interactive)
  (let* (
         (-file-list
          (if (string-equal major-mode "dired-mode")
              (dired-get-marked-files)
            (list (buffer-file-name))))
         (-do-it-p (if (<= (length -file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when -do-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda (-fpath)
           (w32-shell-execute "open" (replace-regexp-in-string "/" "\\" -fpath t t))) -file-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda (-fpath)
           (shell-command
            (concat "open " (shell-quote-argument -fpath))))  -file-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda (-fpath) (let ((process-connection-type nil))
                            (start-process "" nil "xdg-open" -fpath))) -file-list))))))

;; dired

;;(setq dired-dwim-target t) already t
;; Now, go to dired, then call split-window-below, then go to another dired dir. Now, when you press C to copy, the other dir in the split pane will be default destination. Same for dired-do-rename 【R】 and others.

(eval-after-load 'dired
  '(progn
     ;; without requiring 'dired ==> Symbol's value as variable is void: dired-mode-map
     (define-key dired-mode-map (kbd "C-,") 'xah-open-in-external-app)
     ;; (define-key dired-mode-map (kbd "j") 'ido-find-file)
     (setq dired-recursive-copies (quote always)) ; “always” means no asking
     (setq dired-recursive-deletes (quote top)) ; “top” means ask once
     (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
)
)

;; window management
(progn
  (require 'windmove)
  ;; use Shift+arrow_keys to move cursor around split panes
  (windmove-default-keybindings)
  ;; when cursor is on edge, move to the other side, as in a torus space
  (setq windmove-wrap-around t )
)

;; ivy
;; (defun ivy-dired-action (_file_name)
;; "a custom action for ivy, not work though"
;;   (dired-jump (_file_name)))

(eval-after-load 'ivy
  '(progn
     (setq ivy-wrap t)
     (ivy-set-actions
      t
      '(("d"
         (lambda (x) (dired-jump t x)) "dir-jump"
         )))))

;; http://stackoverflow.com/questions/2641211/emacs-interactively-search-open-buffers
;; (require 'cl)
;; (defcustom search-all-buffers-ignored-files (list (rx-to-string '(and bos (or ".bash_history" "TAGS") eos)))
;;   "Files to ignore when searching buffers via \\[search-all-buffers]."
;;   :type 'editable-list)

(require 'grep)
(defun search-all-buffers (regexp prefix)
  "Searches file-visiting buffers for occurence of REGEXP.  With
prefix > 1 (i.e., if you type C-u \\[search-all-buffers]),
searches all buffers."
  (interactive (list (grep-read-regexp)
                     current-prefix-arg))
  (message "Regexp is %s; prefix is %s" regexp prefix)
  (multi-occur
   (if (member prefix '(4 (4)))
       (buffer-list)
     (remove-if
      (lambda (b) (some (lambda (rx) (string-match rx  (file-name-nondirectory (buffer-file-name b)))) search-all-buffers-ignored-files))
      (remove-if-not 'buffer-file-name (buffer-list))))

   regexp))

;; gtags
;; (defun gtags-root-dir ()
;; "Returns GTAGS root directory or nil if doesn't exist."
;; (with-temp-buffer
;;     (if (zerop (call-process "global" nil t nil "-pr"))
;;         (buffer-substring (point-min) (1- (point-max)))
;;     nil)))

;; (defun gtags-update-single(filename)  
;;       "Update Gtags database for changes in a single file"
;;       (interactive)
;;       (start-process "update-gtags" "update-gtags" "bash" "-c" (concat "cd " (gtags-root-dir) " ; gtags --single-update " filename )))

;; (defun gtags-update-current-file()
;;     (interactive)
;;     (defvar filename)
;;     (setq filename (replace-regexp-in-string (gtags-root-dir) "." (buffer-file-name (current-buffer))))
;;     (gtags-update-single filename)
;;     (message "Gtags updated for %s" filename))
(defun ggtags-find-def()
  "find definition of what is input manually"
  (interactive)
  (let ((keyword (counsel-read-keyword ": "))
         )
    (ggtags-find-tag 'definition (shell-quote-argument keyword))))

(nvmap :prefix ","
       "gd" 'ggtags-find-def
       "gw" 'my-lookup-wikipedia
       "go" 'my-lookup-google
       )
(provide 'zenoe-misc)

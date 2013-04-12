;; add my local elisp folder
(setq load-path (cons "~/elisp" load-path))

;; add my local configuration folder
(setq load-path (cons "~/.emacs.d" load-path))

;; load subfiles
(require 'init-org)
(require 'init-gnus)

;; magit
(require 'magit)

;;
;; gnus
;;
;; enable gnus manual
(add-to-list 'Info-default-directory-list "~/ngnus-0.11/texi/"))


;;(require 'init-bbdb)

;; turn off scroll bars
(toggle-scroll-bar -1)

(load "~/elisp/nxhtml/autostart.el")
(setq
 nxhtml-global-minor-mode t
 mumamo-chunk-coloring 'submode-colored
 nxhtml-skip-welcome t
 indent-region-mode t
 rng-nxml-auto-validate-flag nil
 nxml-degraded t)
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))


;; add emacs-rails subfolder
;; (setq load-path (cons "~/elisp/emacs-rails" load-path))
;; (require 'rails)

;; turn off menubar
(menu-bar-mode -1)
;; turn off toolbar
(tool-bar-mode -1)
;; turn off startup screen
(setq inhibit-startup-message t)

;; minimap
;;(require 'minimap)

;; turn off the bell
(setq visible-bell t)

;; set default style
;; oh man this is so goooood
(setq c-default-style "bsd")
(setq-default c-basic-offset 2)

;; matching parenthesis
(require 'paren)
(show-paren-mode 1)

;;(require 'org-install)
;;(require 'remember)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(face-font-family-alternatives (quote (("twlgmono" "bitstream" "freemono" "dejavu" "courier" "fixed") ("dejavu" "helv" "helvetica" "arial" "fixed"))))
 '(org-agenda-files (quote ("~/Dropbox/gtd/todo.org")))
 '(org-default-notes-file "~/Dropbox/gtd/notes.org")
 '(speedbar-default-position (quote left))
 '(sql-ms-program "isql"))

(scroll-bar-mode -1)
;; turn on font coloring
(global-font-lock-mode 1)

;; turn on cua mode (IBM style keys for cut/paste)
(global-unset-key "\C-xc")
(cua-mode t)

(setq frame-title-format "%b")
(setq column-number-mode t)          ; number my columns for error handling
(setq-default truncate-lines t)      ; lines shouldn't wrap, just
                                     ; indicate continued lines
(setq inhibit-startup-message   t)   ; Don't want any startup message
(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving
(setq search-highlight           t) ; Highlight search object
(setq query-replace-highlight    t) ; Highlight query object
(setq mouse-sel-retain-highlight t) ; Keep mouse high-lightening
(setq require-final-newline t)      ; last lines should end in a
                                    ; carriage return

;; Use "y or n" answers instead of full words "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;;(require 'pabbrev)

;; Kills all the buffers except scratch
;; obtained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun nuke-all-buffers ()
  "kill all buffers, leaving *scratch* only"
  (interactive)
  (mapcar (lambda (x) (kill-buffer x))
          (buffer-list))
  (delete-other-windows))

;; return a backup file path of a give file path
;; with full directory mirroring from a root dir
;; non-existant dir will be created
(defun my-backup-file-name (fpath)
  "Return a new file path of a given file path.
If the new path's directories does not exist, create them."
  (let (backup-root bpath)
    (setq backup-root "~/.emacs.d/emacs-backup")
    (setq bpath (concat backup-root fpath "~"))
    (make-directory (file-name-directory bpath) bpath)
    bpath
    )
  )

(setq make-backup-file-name-function 'my-backup-file-name)
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))


  (add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-pylint-init))
  )


;;(require 'sym-comp)
;;(autoload 'comint-mode "comint")

;; ido helps complete things like filenames
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)


(global-set-key "\C-ck" 'call-last-kbd-macro)

;; PYTHON
;; python mode
(require 'python)
;; pymacs
(autoload 'pymacs-load "pymacs" nil t)

(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")


;; DATES AND TIMES
(defvar insert-time-format "%T"
  "*Format for \\[insert-time] (c.f. 'format-time-string' for how to format).")

(defvar insert-date-format "%Y-%m-%d"
  "*Format for \\[insert-date] (c.f. 'format-time-string' for how to format).")

(defun insert-time ()
  "Insert the current time according to the variable \"insert-time-format\"."
  (interactive "*")
  (insert (format-time-string insert-time-format
                              (current-time))))

(defun insert-date ()
  "Insert the current date according to the variable \"insert-date-format\"."
  (interactive "*")
  (insert (format-time-string insert-date-format
                              (current-time))))

(defun insert-time-and-date ()
  "Insert the current date according to the variable \"insert-date-format\", then a space, then the current time according to the variable \"insert-time-format\"."
  (interactive "*")
  (progn
    (insert-date)
    (insert " ")
    (insert-time)))

(global-set-key "\C-r" 'replace-string)

;; some random binds
(global-set-key [ f5] 'shell)
(global-set-key [ f6] 'replace-string)
(global-set-key [ f7] 'setnu-mode)
(global-set-key [S-insert] 'cua-paste)
(global-unset-key [insert])
(global-unset-key "\C-xf")

(global-set-key "\C-x\C-b" 'buffer-menu)

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.mdt" . markdown-mode) auto-mode-alist))


;; ruby mode
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts." t)
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rake$" . ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode)) interpreter-mode-alist))



;; sass mode
(autoload 'sass-mode "sass-mode" "Sass editing mode." t)
(setq auto-mode-alist (cons '("\\.sass$" . sass-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("sass" . sass-mode) interpreter-mode-alist))

;; yaml mode
(autoload 'yaml-mode "yaml-mode" "Yaml editing mode." t)
(setq auto-mode-alist (cons '("\\.yml$" . yaml-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("yaml" . yaml-mode) interpreter-mode-alist))

;; php mode
(autoload 'php-mode "php-mode" "Php editing mode." t)
(setq auto-mode-alist (cons '("\\.php$" . php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.module$" . php-mode) auto-mode-alist))

(setq interpreter-mode-alist (cons '("php" . php-mode) interpreter-mode-alist))
(setq auto-mode-alist (cons '("\\.phtml$" . php-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("phtml" . php-mode) interpreter-mode-alist))


;; save a list of open files in ~/.emacs.desktop
;; save the desktop file automatically if it already exists
(setq desktop-save 'if-exists)
(desktop-save-mode 1)



;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 80)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))

(global-set-key "\C-cq" 'hippie-expand)


;; set up some special words to show up very vibrantly
(make-face 'special-words)
(set-face-attribute 'special-words nil
                    :foreground "White" :background "Firebrick")

(let ((prog-modes '( c-mode c++-mode java-mode ada-mode sh-mode tcl-mode
                            cperl-mode php-mode python-mode ruby-mode lisp-mode ))
      (pattern "\\<\\(IMPORTANT\\|FIXME\\|TODO\\|NOTE\\|HACK\\|WTF\\):"))
  (mapcar(lambda (mode)
           (font-lock-add-keywords mode `((,pattern 1 'special-words prepend))))
         prog-modes))





(add-hook 'python-mode-hook 'fold-hook)
;; this gets called by outline to determine the level. Just use the length of the whitespace
(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "\t ")
      (current-column))))
                                        ; this gets called after python mode is enabled
(defun fold-hook ()
                                        ; outline uses this regexp to find headers. I match lines with no
                                        ; indent and indented "class" and "def" lines.
  (setq outline-regexp "[^ \t]\\|[ \t]*\\(def\\|class\\) ")
                                        ; enable our level computation
  (setq outline-level 'py-outline-level)
  (setq outline-minor-mode-prefix "\C-co")
                                        ; turn on outline mode
  (outline-minor-mode t)
  (setq version-control t)
  (setq kept-old-versions 20)
  (setq kept-new-versions 20)
  (setq trim-versions-without-asking t)
  (fill-minor-mode t))

;; (autoload 'pc-mode "pc-mode")
;; (pc-mode 1)




;; set default colors
(setq default-frame-alist
      '((foreground-color . "Black")
        (background-color . "White")
        (cursor-color . "FireBrick")))

(cond ((fboundp 'global-font-lock-mode)
       ;; Customize face attributes
       (setq font-lock-face-attributes
             ;; Symbol-for-Face Foreground Background Bold Italic Underline
             '((font-lock-comment-face       "DarkGreen" nil nil t)
               (font-lock-string-face        "Sienna" nil nil nil)
               (font-lock-keyword-face       "RoyalBlue" nil t nil)
               (font-lock-function-name-face "Blue" nil nil nil)
               (font-lock-variable-name-face "Black" nil t nil)
               (font-lock-type-face          "DarkBlue" nil t nil)))
       ;; Load the font-lock package.
       (require 'font-lock)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)))

;; full screen toggle set to F11
(defun switch-full-screen ()
  (interactive)
  (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))
(global-set-key [f11] 'switch-full-screen)


;; opens the projects folder
(defun projects()
  (interactive "*")
  (find-file "~/Projects"))

;; opens the knowledge folder
(defun knowledge()
  (interactive "*")
  (find-file "~/Projects/knowledge"))

;; opens the modules/fwk folder
(defun fwk()
  (interactive "*")
  (find-file "~/Projects/knowledge/sites/all/modules/fwk"))


(defun find-init ()
  (interactive)
  (find-file "~/emacs.d/init.el"))

(defun reformat-line()
  (interactive)
  (move-beginning-of-line 1)
  (indent-for-tab-command)
  (move-beginning-of-line 2))
(global-set-key [ f8] 'reformat-line)

(setq auto-insert-directory (expand-file-name "~/.emacs_templates/"))
(setq auto-insert-query t)
(define-auto-insert "\\.rb\\'" "autoinsert.rb")
(define-auto-insert "\\.py\\'" "autoinsert.py")
(define-auto-insert "\\.html\\'" "autoinsert.html")
(add-hook 'find-file-hooks 'auto-insert)

(defun update-template()
  (interactive)
  (goto-line 1)
  (while (search-forward "FFFF" nil t)
    (save-restriction
      (narrow-to-region (match-beginning 0) (match-end 0))
      (replace-match (downcase (file-name-nondirectory buffer-file-name)))))
  (while (search-forward "DDDD" nil t)
    (save-restriction
      (narrow-to-region (match-beginning 0) (match-end 0))
      (replace-match "")
      (insert-date))))

;;recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 200)
(setq recentf-max-menu-items 30)
(global-set-key [(meta f12)] 'recentf-open-files)



;; haml mode
(autoload 'haml-mode "haml-mode" "Haml editing mode." t)
(setq auto-mode-alist (cons '("\\.haml$" . haml-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("haml" . haml-mode) interpreter-mode-alist))
;;(require 'haml-mode)

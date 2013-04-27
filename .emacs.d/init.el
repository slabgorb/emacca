

;; start server for fast startups
(server-start)

;; Add my local configuration folder
(setq load-path (cons "~/.emacs.d" load-path))

(require 'org-install)
(require 'remember)
(require 'init-org)
(require 'init-gnus)
(require 'init-bbdb)
(require 'setnu+)
(require 'scss-mode)
(setq scss-compile-at-save nil)
;;(require 'frame-restore)
(require 'minimap)
;;(require 'newlisp)
(require 'column-marker)
;;(require 'rdebug)
(require 'dired+)
(require 'centered-cursor-mode)
(require 'buff-menu+)

;; have some coffee
(add-to-list 'load-path "~/.emacs.d/coffee-mode")
(require 'coffee-mode)
;; set to two spaces
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2))

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

;; (setq load-path (cons "~/.emacs.d/jquery-doc" load-path))
;; (require 'jquery-doc)
;; (add-hook 'js2-mode-hook 'jquery-doc-setup)


(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
   "Major mode for editing comma-separated value files." t)

;; etask task tracking
(add-to-list 'load-path "~/.emacs.d/etask/")
(require 'etask)

(defun check-calendar-holidays (date)  )

(setq tex-command "pdftex")
(setq tex-dvi-view-command "~/bin/latex-view.sh '*'")
(add-to-list 'load-path "~/.emacs.d/cucumber.el")
;; optional configurations
;; default language if .feature doesn't have "# language: fi"
;(setq feature-default-language "fi")
;; point to cucumber languages.yml or gherkin i18n.yml to use
;; exactly the same localization your cucumber uses
;(setq feature-default-i18n-file "/path/to/gherkin/gem/i18n.yml")
;; and load feature-mode
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))


(setq load-path (cons "~/.emacs.d/magit-0.8.2" load-path))
(require 'magit)

(add-to-list 'load-path "~/.emacs.d/mo-git-blame")
(autoload 'mo-git-blame-file "mo-git-blame" nil t)
(autoload 'mo-git-blame-current "mo-git-blame" nil t)

(require 'flymake)

;; add emacs-rails subfolder
(setq load-path (cons "~/.emacs.d/emacs-rails" load-path))
(require 'rails)
(add-hook 'rails-mode-hook
          '(lambda ()
             (define-key ruby-mode-map [TAB]
               'indent-line)))

;; settings
(one-buffer-one-frame-mode 0)           ; turn off one buffer per frame
(menu-bar-mode 1)                       ; turn on menubar
(tool-bar-mode -1)                       ; turn off toolbar
(setq inhibit-startup-message t)        ; turn off startup screen
(setq visible-bell t)                   ; turn off the bell
(setq column-number-mode t)             ; number my columns for error handling
(setq-default truncate-lines t)         ; lines shouldn't wrap, just
                                        ; indicate continued lines
(setq make-backup-files         nil)    ; Don't want any backup files
(setq auto-save-list-file-name  nil)    ; Don't want any .saves files
(setq auto-save-default         nil)    ; Don't want any auto saving
(setq search-highlight           t)     ; Highlight search object
(setq query-replace-highlight    t)     ; Highlight query object
(setq mouse-sel-retain-highlight t)     ; Keep mouse high-lightening
(setq require-final-newline t)          ; last lines should end in a
                                        ; carriage return


;; Use "y or n" answers instead of full words "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; ;; load nxhtml
;; (load "~/.emacs.d/nxhtml/autostart.el")
;; (setq
;;  nxhtml-global-minor-mode t
;;  mumamo-chunk-coloring 'submode-colored
;;  nxhtml-skip-welcome t
;;  indent-region-mode t
;;  rng-nxml-auto-validate-flag nil
;;  nxml-degraded t)



;; set default style
(setq c-default-style "bsd")
(setq-default c-basic-offset 2)

;; matching parenthesis
(require 'paren)
(show-paren-mode 1)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(face-font-family-alternatives (quote (("twlgmono" "bitstream" "freemono" "dejavu" "courier" "fixed") ("dejavu" "helv" "helvetica" "arial" "fixed"))))
 '(org-agenda-files (quote ("~/Dropbox/gtd/todo.org")))
 '(org-default-notes-file "~/Dropbox/gtd/notes.org")
 '(speedbar-default-position (quote right))
 '(sql-ms-program "isql"))

;; turn on font coloring
(global-font-lock-mode 1)

;; turn on cua mode (IBM style keys for cut/paste)
(global-unset-key "\C-xc")
(cua-mode t)

(setq frame-title-format "%b")


;;(require 'pabbrev)

;; Kills all the buffers except scratch
;; obtained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun nuke-all-buffers ()
  "kill all buffers, leaving *scratch* only"
  (interactive)
  (mapcar (lambda (x) (kill-buffer x))
          (buffer-list))
  (delete-other-windows))

;; opens the FWK project
(defun fwk-open()
  (interactive)
  (find-file "~/Projects/knowledge/sites/all/modules/fwk"))

;; opens the development folder
(defun projects()
  (interactive "*")
  (find-file "~/Projects"))
;; opens the catapult folder
(defun catapult()
  (interactive "*")
  (find-file "~/catapult"))




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

;; python flymake
(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "epylint" (list local-file))))


  (add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-pylint-init)))

;; javascript flymake
(require 'flymake-jslint)
(add-hook 'javascript-mode-hook
          (lambda () (flymake-mode 1)))


;;(require 'sym-comp)
;;(autoload 'comint-mode "comint")

;; ido helps complete things like filenames
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-default-buffer-method 'selected-window)
(setq ido-default-file-method 'selected-window)

(autoload 'goto-last-change "goto-last-change"
  "Set point to the position of the last change." t)
(global-set-key "\C-cz" 'goto-last-change)
(global-set-key "\C-ck" 'call-last-kbd-macro)

;; PYTHON
;; python mode
(require 'python)
;; pymacs
(autoload 'pymacs-load "pymacs" nil t)

(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")

(add-to-list 'load-path "~/.emacs.d/ruby-end")
(require 'ruby-end)

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

(defun device-baud-rate() (* 1 100000))

;; some random binds
;;(global-set-key [ f5] 'shell)
;;(global-set-key [ f6] 'replace-string)
;;(global-set-key [ f7] 'setnu-mode)
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
(setq-default c-basic-offset 2)
;; yaml mode
(autoload 'yaml-mode "yaml-mode" "Yaml editing mode." t)
(setq auto-mode-alist (cons '("\\.yml$" . yaml-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("yaml" . yaml-mode) interpreter-mode-alist))

;; php mode
(autoload 'php-mode "php-mode" "Php editing mode." t)
(setq auto-mode-alist (cons '("\\.php$" . php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.module$" . php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.install$" . php-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.inc$" . php-mode) auto-mode-alist))

(setq interpreter-mode-alist (cons '("php" . php-mode) interpreter-mode-alist))
(setq auto-mode-alist (cons '("\\.phtml$" . php-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("phtml" . php-mode) interpreter-mode-alist))

;; newlisp mode
(autoload 'newlisp "newlisp-mode" "NewLisp editing mode." t)

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


;; set up some special words to show up very vibrantly
(make-face 'special-words)
(set-face-attribute 'special-words nil
                    :foreground "White" :background "Firebrick")

(let ((prog-modes '( c-mode c++-mode java-mode ada-mode sh-mode tcl-mode
                            cperl-mode php-mode python-mode ruby-mode lisp-mode ))
      (pattern "\\<\\(IMPORTANT\\|FIXME\\|TODO\\|@todo:\\|NOTE\\|note:\\|HACK\\|WTF\\):"))
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
  (fill-minor-mode t)
                                        ; initially hide all but the headers
                                        ;(hide-body)
  )

(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))


(cond ((fboundp 'global-font-lock-mode)
       ;; ;; Customize face attributes
       ;; (setq font-lock-face-attributes
       ;;       ;; Symbol-for-Face Foreground Background Bold Italic Underline
       ;;       '((font-lock-comment-face       "DarkGreen" nil nil t)
       ;;         (font-lock-string-face        "Sienna" nil nil nil)
       ;;         (font-lock-keyword-face       "RoyalBlue" nil t nil)
       ;;         (font-lock-function-name-face "Red" nil nil nil)
       ;;         (font-lock-variable-name-face "White" nil t nil)
       ;;         (font-lock-type-face          "DarkBlue" nil t nil)))
       ;; Load the font-lock package.
       (require 'font-lock)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)))

(defun reformat-line()
  (interactive)
  (move-beginning-of-line 1)
  (indent-for-tab-command)
  (move-beginning-of-line 2))

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


(defun badchar ()
  "Find the first non-ascii character from point onwards."
  (interactive)
  (let (point)
    (save-excursion
      (setq point
            (catch 'non-ascii
              (while (not (eobp))
                (or (eq (char-charset (following-char))
                        'ascii)
                    (throw 'non-ascii (point)))
                (forward-char 1)))))
    (if point
        (goto-char point)
        (message "No non-ascii characters."))))

;; haml mode
(autoload 'haml-mode "haml-mode" "Haml editing mode." t)
(setq auto-mode-alist (cons '("\\.haml$" . haml-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("haml" . haml-mode) interpreter-mode-alist))
(require 'haml-mode)



(setq mac-function-modifier 'ctrl) ;- Sets the function key as control within emacs?

(cua-mode t)
(tabbar-mode t)


(defun php-doc-paragraph-boundaries ()
  (setq paragraph-separate "^[ \t]*\\(\\(/[/\\*]+\\)\\|\\(\\*+/\\)\\|\\(\\*?\\)\\|\\(\\*?[ \t]*@[[:alpha:]]+\\([ \t]+.*\\)?\\)\\)[ \t]*$")
  (setq paragraph-start (symbol-value 'paragraph-separate)))

(add-hook 'php-mode-user-hook 'php-doc-paragraph-boundaries)


(global-set-key [M-mouse-1] 'mouse-set-point)
(setq mac-option-modifier 'meta) ;- Sets the option key as Meta (this is default)


(defun wicked/php-mode-init ()
   "Set some buffer-local variables."
   (setq case-fold-search t)
   (setq indent-tabs-mode nil)
   (setq fill-column 78)
   (setq c-basic-offset 2)
   (c-set-offset 'arglist-cont 0)
   (c-set-offset 'arglist-intro '+)
   (c-set-offset 'case-label 2)
   (c-set-offset 'arglist-close 0))
 (add-hook 'php-mode-hook 'wicked/php-mode-init)

(defun slabgorb/js-mode-init ()
   "Set some buffer-local variables."
   (setq case-fold-search t)
   (setq indent-tabs-mode nil)
   (setq fill-column 78)
   (setq c-basic-offset 2))
 (add-hook 'js-mode-hook 'slabgorb/js-mode-init)

(global-hl-line-mode 1)

;; Key bindings
(osx-key-mode t)
(define-key osx-key-mode-map "\C-z" 'undo)
;; (global-set-key "\C-cm" 'start-kbd-macro)
;; (global-set-key "\C-cn" 'end-kbd-macro)
;; (global-set-key "\C-ck" 'call-last-kbd-macro)
(global-set-key "\C-cq" 'hippie-expand)
(global-set-key "\C-cb" 'reformat-line)
(global-set-key "\C-cf" 'aquamacs-toggle-full-frame)
(global-set-key "\C-cg" 'magit-status)


;; Highlight currently selected line
(set-face-background 'hl-line "#333333")  ;; Emacs 22 Only
(set-face-foreground 'hl-line "#FFFFFF")  ;; Emacs 22 Only

(defun show-onelevel ()
  "show entry and children in outline mode"
  (interactive)
  (show-entry)
  (show-children))
;;
(defun slabgorb-outline-bindings ()
  "sets shortcut bindings for outline minor mode"
  (interactive)
  (local-set-key [?\C-,] 'hide-sublevels)
  (local-set-key [?\C-.] 'show-all)
  (local-set-key [C-up] 'outline-previous-visible-heading)
  (local-set-key [C-down] 'outline-next-visible-heading)
  (local-set-key [C-left] 'hide-subtree)
  (local-set-key [C-right] 'show-onelevel)
  (local-set-key [M-up] 'outline-backward-same-level)
  (local-set-key [M-down] 'outline-forward-same-level)
  (local-set-key [M-left] 'hide-subtree)
  (local-set-key [M-right] 'show-subtree))
;;
(add-hook 'outline-minor-mode-hook
          'slabgorb-outline-bindings)
;;
(add-hook 'php-mode-user-hook
          '(lambda ()
             (outline-minor-mode)
             (setq outline-regexp " *\\(public funct\\|static funct\\|private funct\\|funct\\|class\\|#head\\)")
             (hide-sublevels 1)))
;;
(add-hook 'python-mode-hook
          '(lambda ()
             (outline-minor-mode)
             (setq outline-regexp " *\\(def \\|clas\\|#hea\\)")
             (hide-sublevels 1)))

(defun flymake-php-init ()
  "Use php to check the syntax of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
         (local (file-relative-name temp (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns
  '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

;; Drupal-type extensions
(add-to-list 'flymake-allowed-file-name-masks '("\\.module$" flymake-php-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.install$" flymake-php-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.inc$" flymake-php-init))
(add-to-list 'flymake-allowed-file-name-masks '("\\.engine$" flymake-php-init))

(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))
(setq debug-on-error nil)               ; turn off debugger because of recursive edit annoyance


;; (defun slabgorb-text-mode()
;;      (set-truncate-lines)
;;      (auto-fill-mode -1))

;; ;; turn off fill mode for text and org
;; (add-hook 'text-mode-hook (slabgorb-text-mode))
;; (add-hook 'org-mode-hook (slabgorb-text-mode))



;; DARKROOM SUPPORT
;; Darkroom hides everything but emacs

; hide mode line, from
; http://dse.livejournal.com/66834.html
; http://webonastick.com
(autoload 'hide-mode-line "hide-mode-line" nil t)

; fullscreen, taken from
; http://www.emacswiki.org/emacs/FullScreen#toc1
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
             (if (equal 'fullboth current-value)
                 (if (boundp 'old-fullscreen) old-fullscreen nil)
               (progn (setq old-fullscreen current-value)
                  'fullboth)))))

; simple darkroom with fullscreen,
; fringe, mode-line, menu-bar and scroll-bar hiding.
(defvar darkroom-enabled nil)

(setq mode-line-format "%*%+ %b %l:%c %I %s")


(defun toggle-darkroom ()
  (interactive)
  (if (not darkroom-enabled)
      (setq darkroom-enabled t)
    (setq darkroom-enabled nil))
  (toggle-fullscreen)
  (hide-mode-line)
  (if darkroom-enabled
      (progn
        (fringe-mode 'both)
        (menu-bar-mode -1)
        (set-fringe-mode 200))
    (progn
      (fringe-mode 'default)
      (menu-bar-mode)
      (set-fringe-mode 8))))

; Activate with F11 - enhanced fullscreen :)
(global-set-key "\C-cd" 'toggle-darkroom)



; espresso mode indentation for js
(autoload 'espresso-mode "espresso")
(autoload 'js2-mode "js2")
(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (espresso--proper-indentation parse-status))
           node)

      (save-excursion

        ;; I like to indent case and labels to half of the tab width
        (back-to-indentation)
        (if (looking-at "case\\s-")
            (setq indentation (+ indentation (/ espresso-indent-level 2))))

        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation (+ 4 indentation))))

      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))

(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))
(defun my-js2-mode-hook ()
  (require 'espresso)
  (setq espresso-indent-level 8
        indent-tabs-mode nil
        c-basic-offset 8)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
  (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
  (define-key js2-mode-map [(meta control \;)]
    '(lambda()
       (interactive)
       (insert "/* -----[ ")
       (save-excursion
         (insert " ]----- */"))
       ))
  (define-key js2-mode-map [(return)] 'newline-and-indent)
  (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map [(control meta q)] 'my-indent-sexp)
  (if (featurep 'js2-highlight-vars)
    (js2-highlight-vars-mode))
  (message "My JS2 hook"))
(add-hook 'js2-mode-hook 'my-js2-mode-hook)


(setq scheme-program-name
    "/Applications/mit-scheme.app/Contents/Resources/mit-scheme")
(load-library "xscheme")

(setq-default tab-width 4)
(scroll-bar-mode -1)



(defmacro defparameter (symbol &optional initvalue docstring)
  `(progn
     (defvar ,symbol nil ,docstring)
     (setq   ,symbol ,initvalue)))

(defparameter th-frame-config-register ?°
  "The register which is used for storing and restoring frame
configurations by `th-save-frame-configuration' and
`th-jump-to-register'.")


(defun th-save-frame-configuration (arg)
  "Stores the current frame configuration in register
`th-frame-config-register'. If a prefix argument is given, you
can choose which register to use."
  (interactive "P")
  (let ((register (if arg
                      (read-char "Which register? ")
                    th-frame-config-register)))
    (frame-configuration-to-register register)
    (message "Frame configuration saved in register '%c'."
             register)))

(defun th-jump-to-register (arg)
  "Jumps to register `th-frame-config-register'. If a prefix
argument is given, you can choose which register to jump to."
  (interactive "P")
  (let ((register (if arg
                      (read-char "Which register? ")
                    th-frame-config-register)))
    (jump-to-register register)
    (message "Jumped to register '%c'."
             register)))

(global-set-key "\C-ch" 'th-save-frame-configuration)
(global-set-key "\C-cj" 'th-jump-to-register)

;; Emacs macro to add a pomodoro item
(fset 'pomodoro
   "[ ]")

;; Emacs macro to add a pomodoro table
;;
;; | G | Organization | [ ] |
;; |   |              |     |
(fset 'pomodoro-table
   [?| ?  ?G ?  ?| ?  ?O ?r ?g ?a ?n ?i ?z ?a ?t ?i ?o ?n ?  ?| ?  ?\[ ?  ?\] ?  ?| tab])


;;; from http://www.cb1.com/~john/

(defun first-line-of-buffer ()
  "Return as a string the first line in the current buffer."
  (save-excursion
    (goto-char (point-min))
    (end-of-line)
    (buffer-substring (point-min) (point))))

(defun count-buffers (&optional display-anyway)
  "Display or return the number of buffers."
  (interactive)
  (let
      (
       (buf-count (length (buffer-list)))
       )
    (if (or (interactive-p) display-anyway)
        (message "%d buffers in this Emacs" buf-count))
    buf-count))

;;; end of John Sturdy code

(setq css-indent-offset 2)

;; from Sridhar Ratnakumar
;; http://stackoverflow.com/questions/3417438/closing-all-other-buffers-in-emacs
(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer
          (delq (current-buffer)
                (remove-if-not 'buffer-file-name (buffer-list)))))
;; from Sridhar Ratnakumar
;; http://stackoverflow.com/questions/3417438/closing-all-other-buffers-in-emacs
(defun kill-all-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer
         (remove-if-not 'buffer-file-name (buffer-list))))


(setq default-frame-alist '((left . 0) (width . 141) (height . 44)))
(add-to-list 'default-frame-alist '(alpha . (100 85)))
(defun transparency-set-initial-value ()
  "Set initial value of alpha parameter for the current frame"
  (interactive)
  (if (equal (frame-parameter nil 'alpha) nil)
      (set-frame-parameter nil 'alpha 100)))

(defun transparency-set-value (numb)
  "Set level of transparency for the current frame"
  (interactive "nEnter transparency level in range 0-100: ")
  (if (> numb 100)
      (message "Error! The maximum value for transparency is 100!")
    (if (< numb 0)
        (message "Error! The minimum value for transparency is 0!")
      (set-frame-parameter nil 'alpha numb))))

(defun transparency-increase ()
  "Increase level of transparency for the current frame"
  (interactive)
  (transparency-set-initial-value)
   (if (> (frame-parameter nil 'alpha) 0)
       (set-frame-parameter nil 'alpha (+ (frame-parameter nil 'alpha) -2))
     (message "This is a minimum value of transparency!")))

(defun transparency-decrease ()
  "Decrease level of transparency for the current frame"
  (interactive)
  (transparency-set-initial-value)
  (if (< (frame-parameter nil 'alpha) 100)
      (set-frame-parameter nil 'alpha (+ (frame-parameter nil 'alpha) +2))
    (message "This is a minimum value of transparency!")))

;; sample keybinding for transparency manipulation
(global-set-key (kbd "C-?") 'transparency-set-value)
;; the two below let for smooth transparency control
(global-set-key (kbd "C->") 'transparency-increase)
(global-set-key (kbd "C-<") 'transparency-decrease)
(add-hook 'yaml-mode-hook '(lambda () (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
(set-cursor-color 'red)

;; allow ssh after tramp
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))


(setq default-cursor-type 'hollow)
(blink-cursor-mode 1)
(require 'color-theme)

;; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)




(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed 'web-mode 'nginx-mode 'with-editor 'scss-mode 'ruby-tools 'ruby-refactor 'ruby-hash-syntax 'ruby-end 'rubocop 'robe  'rails-log-mode 'org  'magit-popup 'magit 'inf-ruby 'helm-robe 'helm-rb 'helm-ag-r 'helm  'groovy-mode 'graphviz-dot-mode  'flymake-ruby 'flymake-jslint 'flymake-easy 'enh-ruby-mode 'dash  'csv-mode 'company 'coffee-mode 'bm  'async 'rainbow-delimiters )

;; activate installed packages
(package-initialize)

;; start server for fast startups
(server-start)


(require 'package)
(package-initialize)

;; Add my local configuration folder
(setq load-path (cons "~/.emacs.d" load-path))

(require 'nginx-mode)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(helm-mode 1)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x g") 'helm-do-grep)
(global-set-key (kbd "C-x j") 'helm-semantic-or-imenu)
(global-set-key (kbd "C-x p") 'helm-occur)

(helm-autoresize-mode t)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)


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


;; set default style
(setq c-default-style "bsd")
(setq-default c-basic-offset 2)

;; matching parenthesis
(require 'paren)
(show-paren-mode 1)


;; turn on font coloring
(global-font-lock-mode 1)

;; turn on cua mode (IBM style keys for cut/paste)
(global-unset-key "\C-xc")
(cua-mode t)

(setq frame-title-format "%b")

;; turn off whitespace in diffs
(setq vc-diff-switches '("-b" "-B" "-u"))
(setq vc-git-diff-switches nil)

;; Kills all the buffers except scratch
;; obtained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun nuke-all-buffers ()
  "kill all buffers, leaving *scratch* only"
  (interactive)
  (mapcar (lambda (x) (kill-buffer x))
          (buffer-list))
  (delete-other-windows))


;; opens the development folder
(defun projects()
  (interactive "*")
  (find-file "~/Projects"))
;; opens the catapult folder
(defun babylon()
  (interactive "*")
  (find-file "~/Projects/Babylon"))




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




(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.mdt" . markdown-mode) auto-mode-alist))


;; ruby mode
(setq auto-mode-alist (cons '("\\.rb$" . enh-ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rake$" . enh-ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . enh-ruby-mode)) interpreter-mode-alist))


(setq interpreter-mode-alist (cons '("sass" . scss-mode) interpreter-mode-alist))
(setq auto-mode-alist (cons '("\\.scss$" . scss-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("scss" . scss-mode) interpreter-mode-alist))
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
                            cperl-mode php-mode python-mode ruby-mode enh-ruby-mode lisp-mode ))
      (pattern "\\<\\(IMPORTANT\\|FIXME\\|TODO\\|@todo:\\|NOTE\\|note:\\|HACK\\|WTF\\):"))
  (mapcar(lambda (mode)
           (font-lock-add-keywords mode `((,pattern 1 'special-words prepend))))
         prog-modes))



(defun reformat-line()
  (interactive)
  (move-beginning-of-line 1)
  (indent-for-tab-command)
  (move-beginning-of-line 2))

(setq auto-insert-directory (expand-file-name "~/.emacs_templates/"))
(setq auto-insert-query t)
(define-auto-insert "\\.rb\\'" "autoinsert.rb")
(define-auto-insert "\\.py\\'" "autoinsert.py")
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

;; yaml mode
  (require 'yaml-mode)
    (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


;; web mode
(setq web-mode-enable-current-column-highlight t)
(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.htm\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (set-face-attribute 'web-mode-symbol-face nil :foreground "Brown")
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
(setq-default indent-tabs-mode nil)


(cua-mode t)
(tabbar-mode t)


(defun php-doc-paragraph-boundaries ()
  (setq paragraph-separate "^[ \t]*\\(\\(/[/\\*]+\\)\\|\\(\\*+/\\)\\|\\(\\*?\\)\\|\\(\\*?[ \t]*@[[:alpha:]]+\\([ \t]+.*\\)?\\)\\)[ \t]*$")
  (setq paragraph-start (symbol-value 'paragraph-separate)))

(add-hook 'php-mode-user-hook 'php-doc-paragraph-boundaries)


(global-set-key [M-mouse-1] 'mouse-set-point)
(setq mac-option-modifier 'meta) ;- Sets the option key as Meta (this is default)



(global-hl-line-mode 1)

;; Key bindings
(osx-key-mode t)
(define-key osx-key-mode-map "\C-z" 'undo)
(global-set-key "\C-cq" 'hippie-expand)
(global-set-key "\C-cb" 'reformat-line)
(global-set-key "\C-cf" 'aquamacs-toggle-full-frame)
(global-set-key "\C-cg" 'magit-status)

(defun show-onelevel ()
  "show entry and children in outline mode"
  (interactive)
  (show-entry)
  (show-children))
;;

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
          (setq indentation (+ 2 indentation))))

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

(setq-default tab-width 2)
(scroll-bar-mode -1)



(defmacro defparameter (symbol &optional initvalue docstring)
  `(progn
     (defvar ,symbol nil ,docstring)
     (setq   ,symbol ,initvalue)))



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
    "Kill all buffers."
    (interactive)
    (mapc 'kill-buffer
         (remove-if-not 'buffer-file-name (buffer-list))))


(setq default-frame-alist '((left . 0) (width . 141) (height . 44)))
(add-to-list 'default-frame-alist '(alpha . (100 85)))

(add-hook 'yaml-mode-hook '(lambda () (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
(set-cursor-color 'red)

;; allow ssh after tramp
(set-default 'tramp-default-proxies-alist (quote ((".*" "\\`root\\'" "/ssh:%h:"))))


(setq default-cursor-type 'hollow)
(blink-cursor-mode 1)
(require 'color-theme)



(global-linum-mode t)

(setq tab-width 2) ; or any other preferred value


(setq js-indent-level 2)


(defun save-macro (name)
    "save a macro. Take a name as argument
     and save the last defined macro under
     this name at the end of your .emacs"
     (interactive "SName of the macro :")  ; ask for the name of the macro
     (kmacro-name-last-macro name)         ; use this name for the macro
     (find-file user-init-file)            ; open ~/.emacs or other user init file
     (goto-char (point-max))               ; go to the end of the .emacs
     (newline)                             ; insert a newline
     (insert-kbd-macro name)               ; copy the macro
     (newline)                             ; insert a newline
     (switch-to-buffer nil))               ; return to the initial buffer


(fset 'fix_colors
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217848 114 101 112 108 97 99 101 45 115 116 114 105 110 103 return 36 119 104 105 116 101 return 36 99 111 108 111 114 95 119 104 105 116 101 return 134217848 up return return 134217788 134217848 114 101 112 108 97 99 115 45 backspace backspace 101 45 115 116 114 tab return 36 99 backspace 98 108 111 97 99 backspace backspace backspace 97 99 107 return 36 99 111 108 111 114 95 98 108 97 99 107 return 134217848 116 101 backspace backspace 114 101 112 108 97 tab 115 116 114 105 110 103 return 95 112 112 114 111 120 return return 134217848 114 101 112 108 97 99 115 45 backspace backspace 101 45 115 116 114 105 110 103 return 95 97 112 112 114 111 99 backspace 120 return return 134217788] 0 "%d")) arg)))

(fset 'insert_imports
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([134217788 64 105 109 112 111 114 116 39 backspace 32 39 118 97 114 105 97 98 108 101 115 39 59 return 64 105 109 112 111 114 116 32 39 109 105 120 105 110 115 59 backspace 39 59 return 24 19] 0 "%d")) arg)))

(set-face-background hl-line-face "#080808")
(desktop-save-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 307 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(default-frame-alist
    (quote
     ((alpha 100 85)
      (left . 0)
      (width . 141)
      (height . 44))))
 '(global-hl-line-mode t)
 '(global-linum-mode t)
 '(ns-tool-bar-display-mode (quote both) t)
 '(ns-tool-bar-size-mode nil t)
 '(visual-line-mode nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-mode-default ((t (:inherit autoface-default :height 180 :family "Anonymous Pro"))) t)
 '(emacs-lisp-mode-default ((t (:inherit prog-mode-default :height 150 :family "Anonymous Pro"))) t)
 '(js-mode-default ((t (:inherit prog-mode-default :height 160 :family "Anonymous Pro"))) t)
 '(ruby-mode-default ((t (:inherit prog-mode-default :height 160 :family "Anonymous Pro"))) t)
 '(sass-mode-default ((t (:inherit haml-mode-default :height 180 :family "Anonymous Pro"))) t)
 '(scss-mode-default ((t (:inherit css-mode-default :height 140 :family "Monaco"))) t)
 '(web-mode-default ((t (:inherit web-mode-prog-mode-default :height 150 :family "Anonymous Pro"))) t)
 '(yaml-mode-default ((t (:inherit autoface-default :height 160 :family "Anonymous Pro"))) t))



;; Make sure the repository is loaded as early as possible
(setq bm-restore-repository-on-load t)
(require 'bm)

;; Loading the repository from file when on start up.
(add-hook' after-init-hook 'bm-repository-load)

;; Restoring bookmarks when on file find.
(add-hook 'find-file-hooks 'bm-buffer-restore)

;; Saving bookmark data on killing a buffer
(add-hook 'kill-buffer-hook 'bm-buffer-save)

;; Saving the repository to file when on exit.
;; kill-buffer-hook is not called when Emacs is killed, so we
;; must save all bookmarks first.
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))

;; Update bookmark repository when saving the file.
(add-hook 'after-save-hook 'bm-buffer-save)

;; Restore bookmarks when buffer is reverted.
(add-hook 'after-revert-hook 'bm-buffer-restore)


(global-set-key (kbd "<left-fringe> <mouse-5>") 'bm-next-mouse)
(global-set-key (kbd "<left-fringe> <mouse-4>") 'bm-previous-mouse)
(global-set-key (kbd "<left-fringe> <mouse-1>") 'bm-toggle-mouse)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)


(add-hook 'after-init-hook 'global-company-mode)



(global-set-key (kbd "<f8>")  #'whitespace-mode)
(global-set-key (kbd "<f9>")  #'whitespace-cleanup)

(defun whitespace-cleanup* ()
  (let* ((modified-before-p (buffer-modified-p)))
    (whitespace-cleanup)
    (if (not modified-before-p)
        (not-modified))))
(defun whitespace-cleanup-on-save ()
  (add-hook 'write-contents-hooks #'whitespace-cleanup*))
(add-hook 'c-mode-common-hook   #'whitespace-cleanup-on-save)
(add-hook 'emacs-lisp-mode-hook #'whitespace-cleanup-on-save)
(add-hook 'python-mode-hook     #'whitespace-cleanup-on-save)
(add-hook 'sh-mode-hook         #'whitespace-cleanup-on-save)
(add-hook 'js-mode-hook         #'whitespace-cleanup-on-save)
(add-hook 'coffee-mode-hook     #'whitespace-cleanup-on-save)
(add-hook 'text-mode-hook       #'whitespace-cleanup-on-save)
(add-hook 'enh-ruby-mode-hook   #'whitespace-cleanup-on-save)
(add-hook 'web-mode-hook        #'whitespace-cleanup-on-save)
(add-hook 'scss-mode-hook        #'whitespace-cleanup-on-save)
(add-hook 'sass-mode-hook        #'whitespace-cleanup-on-save)

(add-hook 'enh-ruby-mode-hook
          (lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'scss-mode-hook
          (lambda () (modify-syntax-entry ?_ "w")))

(global-auto-revert-mode t)
(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
         (buffer (car list)))
    (while buffer
      (when (and (buffer-file-name buffer)
                 (not (buffer-modified-p buffer)))
        (set-buffer buffer)
        (revert-buffer t t t))
      (setq list (cdr list))
      (setq buffer (car list))))
  (message "Refreshed open files"))


 (defun dos2unix (buffer)
      "Automate M-% C-q C-m RET C-q C-j RET"
      (interactive "*b")
      (save-excursion
        (goto-char (point-min))
        (while (search-forward (string ?\C-m) nil t)
          (replace-match (string ?\C-j) nil t))))



;;; I want a key to open the current buffer all over the screen.
(defun all-over-the-screen ()
  (interactive)
  (delete-other-windows)
  (split-window-horizontally)
  (balance-windows)
  (follow-mode t))
(global-set-key (kbd "<f6>") 'all-over-the-screen)

(defun two-the-same (p)
  (interactive)
  (delete-other-windows)
  (split-window-horizontally)
  (balance-windows))
(global-set-key (kbd "<f7>") 'two-the-same)

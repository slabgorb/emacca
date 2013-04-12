;;; init-org.el --- Keith Avery's configuration file for org mode

;; Copyright (C) 2009  Keith Avery

;; Author: Keith Avery <kavery@innova-partners.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-ci" 'org-iswitchb)
(global-set-key "\^xg" 'goto-line)
;;(org-remember-insinuate)
(setq org-directory "~/Dropbox/gtd")
(setq org-default-notes-file (concat org-directory "/todo.org"))
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)

(setq org-remember-templates
      '(("Todo" ?t "** TODO %^{headline} %^G \n   SCHEDULED:%^t\n   :PROPERTIES:\n   :REGARDING:%a\n   :CREATED:%T\n   :END:\n   %?\n   %i " "~/Dropbox/gtd/todo.org" "Inbox")
        ("Catapult" ?c "** TODO %^{headline} %^G \n   SCHEDULED:%^t\n   :PROPERTIES:\n   :REGARDING:%a\n   :CREATED:%T\n   :END:\n   %?\n   %i " "~/Dropbox/gtd/todo.org" "Catapult")
        ("CS" ?s "** TODO %^{headline} %^G \n   SCHEDULED:%^t\n   :PROPERTIES:\n   :REGARDING:%a\n   :CREATED:%T\n   :END:\n   %?\n   %i " "~/Dropbox/gtd/todo.org" "Customer Service")
        ("Note" ?n "** NOTE %? %i\n   \n   :PROPERTIES:\n   REGARDING:%a\n   CREATED:%T\n   :END:\n   " "~/Dropbox/gtd/notes.org" "Inbox")
        ("BetsyTodo" ?b "** TODO %^{headline} %^G \n   SCHEDULED:%^t\n   :PROPERTIES:\n   :REGARDING:%a\n   :CREATED:%T\n   :END:\n   %?\n   %i " "~/Dropbox/gtd/betsy.org" "Inbox")
        ("Idea" ?i "** IDEA %? %i\n   :PROPERTIES:\n   REGARDING:%a\n   :END:\n   " "~/Dropbox/gtd/notes.org" "Ideas")))
;; turn on transient mark mode for org
(transient-mark-mode 1)

;; this should put the note at the beginning of the section instead of the end?
(setq org-reverse-note-order t)

(defun todo ()
  (interactive)
  (find-file "~/Dropbox/gtd/todo.org"))


; Enable habit tracking (and a bunch of other modules)
(setq org-modules (quote (org-bbdb org-bibtex org-crypt org-gnus org-id org-info org-jsinfo org-habit org-inlinetask org-mew org-mhe org-protocol org-wl org-w3m)))
; global STYLE property values for completion
(setq org-global-properties (quote (("STYLE_ALL" . "habit"))))
; position the habit graph on the agenda to the right of the default
(setq org-habit-graph-column 50)
(setq org-clock-sound "/home/kavery/100_japanese-histuff.wav")

(provide 'init-org)
;;; init-remember.el ends here
;; remember


 (defun sacha/org-bbdb-get (path)
   "Return BBDB record for PATH."
   (car (bbdb-search (bbdb-records) path path path)))

 (defun sacha/org-bbdb-export (path desc format)
   "Create the export version of a BBDB link specified by PATH or DESC.
 If exporting to HTML, it will be linked to the person's blog,
 www, or web address. If exporting to LaTeX FORMAT the link will be
 italicised. In all other cases, it is left unchanged."
     (cond
      ((eq format 'html)
       (let* ((record
             (sacha/org-bbdb-get path))
            url)
       (setq url (and record
                      (or (bbdb-record-getprop record 'blog)
                          (bbdb-record-getprop record 'www)
                          (bbdb-record-getprop record 'web))))
       (if url
           (format "<a href=\"%s\">%s</a>"
                   url (or desc path))
         (format "<em>%s</em>"
                 (or desc path)))))
      ((eq format 'latex) (format "\\textit{%s}" (or desc path)))
      (t (or desc path))))

 (defadvice org-bbdb-export (around sacha activate)
   "Override org-bbdb-export."
   (setq ad-return-value (sacha/org-bbdb-export path desc format)))

 ;;;_+ Hippie expansion for BBDB; map M-/ to hippie-expand for most fun
 ;;(add-to-list 'hippie-expand-try-functions-list 'sacha/try-expand-bbdb-annotation)
 (defun sacha/try-expand-bbdb-annotation (old)
   "Expand from BBDB. If OLD is non-nil, cycle through other possibilities."
   (unless old
     ;; First time, so search through BBDB records for the name
     (he-init-string (he-dabbrev-beg) (point))
     (when (> (length he-search-string) 0)
       (setq he-expand-list nil)
       (mapcar
        (lambda (item)
        (let ((name (bbdb-record-name item)))
          (when name
            (setq he-expand-list
                  (cons (org-make-link-string
                       (org-make-link "bbdb:" name)
                       name)
                        he-expand-list)))))
        (bbdb-search (bbdb-records)
                     he-search-string
                     he-search-string
                     he-search-string
                     nil nil))))
   (while (and he-expand-list
               (or (not (car he-expand-list))
                   (he-string-member (car he-expand-list) he-tried-table t)))
     (setq he-expand-list (cdr he-expand-list)))
   (if (null he-expand-list)
       (progn
         (if old (he-reset-string))
         nil)
     (progn
       (he-substitute-string (car he-expand-list) t)
       (setq he-expand-list (cdr he-expand-list))
       t)))


(add-to-list 'org-modules 'org-timer)
(setq org-timer-default-timer 25)
(add-hook 'org-clock-in-hook '(lambda ()
      (if (not org-timer-current-timer)
      (org-timer-set-timer '(16)))))

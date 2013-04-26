;;; init-bbdb.el --- bbdb configuration file

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
;; add the bbdb folder
(setq load-path (cons "~/.emacs.d/bbdb/lisp" load-path))

(require 'bbdb)
(bbdb-initialize)
(setq bbdb-dwim-net-address-allow-redundancy t)
(add-hook 'message-setup-hook 'bbdb-define-all-aliases)
(setq bbdb-default-area-code "914")
(autoload 'bbdb/gnus-lines-and-from "bbdb-gnus")
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)


(setq
    bbdb-offer-save 1                        ;; 1 means save-without-asking
    bbdb-use-pop-up t                        ;; allow popups for addresses
    bbdb-electric-p t                        ;; be disposable with SPC
    bbdb-popup-target-lines  1               ;; very small
    bbdb-dwim-net-address-allow-redundancy t ;; always use full name
    bbdb-quiet-about-name-mismatches 2       ;; show name-mismatches 2 secs
    bbdb-always-add-address t                ;; add new addresses to existing...
                                             ;; ...contacts automatically
    bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx
    bbdb-completion-type nil                 ;; complete on anything
    bbdb-complete-name-allow-cycling t       ;; cycle through matches
                                             ;; this only works partially
    bbbd-message-caching-enabled t           ;; be fast
    bbdb-use-alternate-names t               ;; use AKA
    bbdb-elided-display t                    ;; single-line addresses
    ;; auto-create addresses from mail
    bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook

)

(defun sams-lookup-address-in-gnus ()   ;[Jesper]
  "Complete on entries from the bbdb database or mail aliases list"
  (interactive)
  (let* ((function 'bbdb-complete-name))
    (when (null (expand-abbrev))
      (if (fboundp function)
          (funcall function)
        (message "Sams lib: function bbdb-complete-name not loaded.")))))


(defun sams-bind-alias-tabs-in-gnus ()
  "Setup gnus to complete both entries from the bbdb database and on
mail aliases (eventually defined by gnus), using M-tab"
  (add-hook 'message-setup-hook
            (lambda ()
              (local-set-key "\M-\t" 'sams-lookup-address-in-gnus ))))


(add-hook 'message-setup-hook 'bbdb-define-all-aliases)
(sams-bind-alias-tabs-in-gnus)
(provide 'init-bbdb)
;;; init-bbdb.el ends here

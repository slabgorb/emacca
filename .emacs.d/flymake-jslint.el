;;; flymake-jslint.el --- flymake for javascript

;; Copyright (C) 2010  Keith Avery

;; Author: Keith Avery <kavery@slabmac.local>
;; Keywords: flymake, javascript

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

;; from http://www.emacswiki.org/emacs/FlymakeJavaScript

;;; Code:


(require 'flymake)

(defun flymake-jslint-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "rhino" (list (expand-file-name "~/Projects/jslint.js") local-file))))

(setq flymake-allowed-file-name-masks
      (cons '(".+\\.js$"
              flymake-jslint-init
              flymake-simple-cleanup
              flymake-get-real-file-name)
            flymake-allowed-file-name-masks))

(setq flymake-err-line-patterns
      (cons '("^Lint at line \\([[:digit:]]+\\) character \\([[:digit:]]+\\): \\(.+\\)$"
              nil 1 2 3)
            flymake-err-line-patterns))

(provide 'flymake-jslint)
;;; flymake-jslint.el ends here


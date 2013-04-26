;;; image-dired.el ---

;; Copyright 2008 Joseph Brenner
;;
;; Author: doom@kzsu.stanford.edu
;; Version: $Id: image-dired.el,v 1.9 2008/07/09 20:59:25 doom Exp doom $
;; Keywords:
;; X-URL: not distributed yet

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;;  The image-mode available inside of emacs makes it easy to
;;  view an image quickly,  without launching an external viewer,
;;  however, it has some small practical difficulties with using
;;  it regularly.
;;  This package is intended to fill in some of the gaps.

;;  See the documentation for the variable image-mode-documentation for more information.

;;; Code:

(provide 'image-dired)
(eval-when-compile
  (require 'cl))




;; ========
;; documentation

(defvar image-mode-documentation t
  "This is the documentation for the image-dired.el package.

This package adds some commands to the image-mode keymap
to simplify working with image files from a dired buffer.
With version 22 of GNU emacs, an image display feature was added
so that inside of dired you can hit the return key on an image
file name, it will display the image inside of emacs in
image-mode.  The image-dired package adds some features, so that
once an image is displayed, you can step forward or back through
the other images in the directory by hitting space or
backspace (or if you prefer 'n' and 'p' or 'C-n' and 'C-p').

Hitting return again will then exit you out of image-mode,
returning to dired, with the cursor positioned on the name of the
last displayed image file.

Additionally, the dired commands to mark files or to flag files
for deletion are supported while the image is displayed, bound to
the usual 'm'/'u' and 'd' keys

If you have the dired-external-apps package installed, and you
have enabled the feature to save the file name and path to some
user registers and to the kill-ring, you will find that with the
image-dired feature these features are also automatically
supported.

Usage:

Put the file image-dired.el into your load-path and the following
into your ~/.emacs:

  (require 'image-dired)
  (image-dired-standard-keymap-changes)

If you want the dired-external-apps features, you should also do this:

  (require 'dired-external-apps)
  (setq dired-external-apps-save-to-registers-flag t)

See \\[dired-external-apps-documentation] for more information.
")


;; ========
;;  User Options, Variables

(defvar image-dired-extension-list (list "jpeg" "jpg" "gif" "png" "tiff")
  "List of image file extensions supported by image-mode.")

(defvar image-dired-external-apps-flag
  (not (eq
        (require 'dired-external-apps nil t) nil))
  "This internally used flag shows whether dired-external-apps.el was found.")



;; ========
;; image-mode

;; Additions to image-mode to get it to work more naturally with dired.
;; The goal is to obviate (most) needs for an external image viewer

(defun image-dired-kill-buffer ()
  "Kill the current image-mode buffer without confirmation."
  (interactive)
  (let* ( (mode-name-string mode-name)
          (pattern          "^\\(Image\\)\\[")
          )
    (unless (string-match pattern mode-name-string) ;; too slow? TODO
      (error "This is not an image-mode buffer."))
    (kill-buffer (current-buffer))
    (switch-to-buffer dired-external-apps-last-buffer)   ;; temp comment out, looking for performance hit -- TODO
    (goto-char dired-external-apps-last-point)
    ))


(defun image-dired-next-image ()
  "In an image-mode buffer started from dired, show the next image.
Here the \"next\" image is as defined by the dired sort order.
Non-image files (as determined by file extension) are skipped."
  (interactive)
  (image-dired-kill-buffer)
  (image-dired-skip-to-next-image-file)
  (if image-dired-external-apps-flag
      (dired-external-apps-file-name-to-ring-and-registers-if-enabled))
  (dired-advertised-find-file))


(defun image-dired-skip-to-next-image-file ()
  "In a dired buffer, skip down to the next file with an image extension.
Refuses to move past the end of a list of images."
  (interactive)
  (let ( (filename)
         (extension)
         (last-location (point))
         )
    (catch 'giveup
      (while (not (member extension image-dired-extension-list))
        (dired-next-line 1)
        (setq filename (condition-case nil
                           (dired-get-filename "no-dir")
                         (error nil)
                         ))
        (if (stringp filename)
            (setq extension (downcase (image-dired-get-file-extension filename)))
          (progn
            (goto-char last-location)  ;; no filename here, so jump to last place
            (setq filename nil)
            (throw 'giveup nil)
            )
        )))
    (setq dired-external-apps-last-point (point))
    filename))


(defun image-dired-previous-image ()
  "In an image-mode buffer started from dired, show the previous image.
Here the \"previous\" image is as defined by the dired sort order.
Non-image files (as determined by file extension) are skipped."
  (interactive)
  (image-dired-kill-buffer)
  (image-dired-skip-to-previous-image-file)
  (if image-dired-external-apps-flag
      (dired-external-apps-file-name-to-ring-and-registers-if-enabled))
  (dired-advertised-find-file))


(defun image-dired-skip-to-previous-image-file ()
  "In a dired buffer, skip down to the next file with an image extension.
Refuses to move past the beginning of a list of images."
  (interactive)
  (let ( (filename)
         (extension)
         (last-location (point))
         )
    (catch 'giveup
      (while (not (member extension image-dired-extension-list))
        (dired-previous-line 1)
        (setq filename (condition-case nil
                           (dired-get-filename "no-dir")
                         (error nil)
                         ))
        (if (stringp filename)
            (setq extension (downcase (image-dired-get-file-extension filename)))
          (progn
            (goto-char last-location)  ;; no filename here, so jump to last place
            (setq filename nil)
            (throw 'giveup nil)
            )
        )))
    (setq dired-external-apps-last-point (point))
    filename))

(defun image-dired-get-file-extension (name)
  "Given a file name, return the file extension (string after last \".\").
If there is no \".\" in the given name, the entire string is returned."
  (let* (
         (shortname (file-name-nondirectory name))
         (parts-list (split-string shortname "[.]"))
          (extension (nth (1- (length parts-list)) parts-list))
         )
    extension))

(defun image-dired-flag-file-deletion ()
  "Flag the image file for deletion, then show the next image.
Here the \"next\" image is as defined by the dired sort order.
Non-image files (as determined by file extension) are skipped."
  (interactive)
  (image-dired-kill-buffer)
  (if image-dired-external-apps-flag
      (dired-external-apps-file-name-to-ring-and-registers-if-enabled))
  (dired-flag-file-deletion 1)
  (dired-previous-line 1)
  (image-dired-skip-to-next-image-file)
  (dired-advertised-find-file))


(defun image-dired-dired-mark ()
  "Set the dired-mark for the image file, then show the next image.
Here the \"next\" image is as defined by the dired sort order.
Non-image files (as determined by file extension) are skipped."
  (interactive)
  (image-dired-kill-buffer)
  (if image-dired-external-apps-flag
      (dired-external-apps-file-name-to-ring-and-registers-if-enabled))
  (dired-mark 1)
  (dired-previous-line 1)
  (image-dired-skip-to-next-image-file)
  (dired-advertised-find-file))

(defun image-dired-dired-unmark ()
  "Unmark the previous image file, then show the previous image.
By design this command undoes the effect of a \\[image-dired-dired-mark]
if done immediately afterwards, which is why it effects the previous
file rather than the current one.
Here the \"previous\" image is as defined by the dired sort order.
Non-image files (as determined by file extension) are skipped."
  (interactive)
  (image-dired-kill-buffer)
  (dired-previous-line 1)
  (if image-dired-external-apps-flag
      (dired-external-apps-file-name-to-ring-and-registers-if-enabled))
  (dired-unmark 1)
  (image-dired-skip-to-previous-image-file)
  (dired-advertised-find-file))





(defun image-dired-rotate-image-clockwise ()
  "Rotates the current image clockwise 90 degrees.
Uses the external utility \"jpegtran\".
Saves file path and name to registers 'p' and 'n', and
also pushes the name to the kill-ring.
Changes directory to the location of the file, so that
save-as in the external app will go to the same place.
This works using a shell buffer named \\[dired-external-apps-shell-buffer],
which is where you should look for any error messages."
  (interactive)
  (image-dired-run-jpegtran "-rotate 90"))

(defun image-dired-rotate-image-counterclockwise ()
  "Rotates the current image counter clockwise 90 degrees.
Uses the external utility \"jpegtran\".
Saves file path and name to registers 'p' and 'n', and
also pushes the name to the kill-ring.
Changes directory to the location of the file, so that
save-as in the external app will go to the same place.
This works using a shell buffer named \\[dired-external-apps-shell-buffer],
which is where you should look for any error messages."
  (interactive)
  (image-dired-run-jpegtran "-rotate 270"))

(defun image-dired-run-jpegtran (option)
  "Runs jpegtran on the current image, using the given OPTION string.
For example '-rotate 90' should rotate the image clockwise 90 degrees.
Saves file path and name to registers 'p' and 'n', and
also pushes the name to the kill-ring.
Changes directory to the location of the file, so that
save-as in the external app will go to the same place.
This works using a shell buffer named \\[dired-external-apps-shell-buffer],
which is where you should look for any error messages."
  (interactive "sjpegtran option: ")
  (image-dired-kill-buffer)
  (let* ( (fullname (dired-get-filename))
          (name     (dired-get-filename "no-dir"))
          (backup   (concat name ".bak"))
          (path     (file-name-directory fullname)) ;; alternately, dired-current-directory
          )
    (if image-dired-external-apps-flag
        (dired-external-apps-file-name-to-ring-and-registers-if-enabled))

    (save-excursion
      (setq cmd1 (concat "cd " (shell-quote-argument path)))

      (setq cmd2 (concat "cp " (shell-quote-argument name) " " (shell-quote-argument backup)))
      (setq cmd3 (concat "jpegtran " option " (shell-quote-argument backup) " > " (shell-quote-argument name) ))
;      (setq cmd (format "%s; %s; %s &" cmd1 cmd2 cmd3))
      (setq cmd (format "%s; %s; %s " cmd1 cmd2 cmd3))

      (dired-external-apps-shell-command cmd)

      ))
  (dired-external-apps-open-with-emacs))))

;; TODO Wed Jul  9 13:43:15 2008
;; Would be much better to mimic the current keybindings
;; of dired-mode, rather than presuming the user wants the defaults.

(defun image-dired-standard-keymap-changes ()
  "Makes the recommended changes to the image-mode keymap."
  (add-hook 'image-mode-hook
            '(lambda ()
               (define-key image-mode-map
                 [return]
                 'image-dired-kill-buffer)
               (define-key image-mode-map
                 " "
                 'image-dired-next-image)
               (define-key image-mode-map
                 [backspace]
                 'image-dired-previous-image)
               (define-key image-mode-map
                 "\C-n"
                 'image-dired-next-image)
               (define-key image-mode-map
                 "\C-p"
                 'image-dired-previous-image)
               (define-key image-mode-map
                 "n"
                 'image-dired-next-image)
               (define-key image-mode-map
                 "p"
                 'image-dired-previous-image)
               (define-key image-mode-map
                 "d"
                 'image-dired-flag-file-deletion)
               (define-key image-mode-map
                 "m"
                 'image-dired-dired-mark)
               (define-key image-mode-map
                 "u"
                 'image-dired-dired-unmark)
               (define-key image-mode-map
                 "r"
                 'image-dired-rotate-image-clockwise)
               (define-key image-mode-map
                 "R"
                 'image-dired-rotate-image-counterclockwise)
               )))


;;; image-dired.el ends here

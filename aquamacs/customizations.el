;;; customizations.el ---                            -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Keith Avery

;; Author: Keith Avery <keithavery@ip-10-16-104-234.ec2.internal>
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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 307 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(cursor-type (quote (bar . 5)))
 '(custom-enabled-themes (quote (wheatgrass)))
 '(custom-safe-themes
   (quote
    ("bf25a2d5c2eddc36b2ee6fc0342201eb04ea090e637562c95b3b6e071216b524" default)))
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
 '(tabbar-background-color "Black")
 '(tabbar-cycle-scope (quote tabs))
 '(tabbar-mode t nil (tabbar))
 '(tabbar-mwheel-mode t nil (tabbar))
 '(visual-line-mode nil t))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit nil :stipple nil :background "White" :foreground "#85d8ef" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Monaco"))))
;;  '(:foreground ((t (:background "#000000"))) t)
;;  '(Custom-mode-default ((t (:inherit autoface-default :background "#000000"))) t)
;;  '(autoface-default ((t (:inherit default))))
;;  '(button ((t (:inherit link :background "#000000"))))
;;  '(coffee-mode-default ((t (:inherit prog-mode-default :foreground "#a4c5e3" :height 150 :family "Monaco"))) t)
;;  '(custom-documentation ((t (:foreground "#869190"))))
;;  '(custom-variable-tag ((t (:foreground "#587cda" :weight bold))))
;;  '(dired-mode-default ((t (:inherit autoface-default :background "#000000" :foreground "#eaeaea" :height 180 :family "Anonymous Pro"))) t)
;;  '(echo-area ((t (:stipple nil :background "#181818" :foreground "#e3e3e3" :strike-through nil :underline nil :slant normal :weight normal :width normal :family "Lucida Grande"))))
;;  '(emacs-lisp-mode-default ((t (:inherit prog-mode-default :background "#000000"))) t)
;;  '(enh-ruby-mode-default ((t (:inherit default :background "#000000" :foreground "#91ac9f" :height 160 :family "Anonymous Pro"))) t)
;;  '(enh-ruby-op-face ((t (:foreground "#85acd0"))))
;;  '(font-lock-builtin-face ((t (:foreground "#1B3B6F"))))
;;  '(font-lock-comment-face ((t (:background "#000c10" :foreground "#50de49"))))
;;  '(font-lock-keyword-face ((t (:foreground "#364791"))))
;;  '(font-lock-string-face ((t (:foreground "#1C7293"))))
;;  '(font-lock-type-face ((t (:foreground "#74a9e3"))))
;;  '(font-lock-variable-name-face ((t (:foreground "#3180e3"))))
;;  '(fringe ((t (:background "#000000" :foreground "#2a2e2e"))))
;;  '(fundamental-mode-default ((t (:inherit autoface-default))) t)
;;  '(helm-buffer-directory ((t (:background "Black" :foreground "White"))))
;;  '(helm-ff-directory ((t (:background "Black" :foreground "#b1a872"))))
;;  '(helm-ff-file ((t (:inherit font-lock-builtin-face :background "black" :foreground "#687141"))))
;;  '(helm-moccur-mode-default ((t (:inherit special-mode-default :background "#000000" :foreground "#cbcbcb"))) t)
;;  '(helm-selection ((t (:background "#323c57" :foreground "#7b91ca"))))
;;  '(helm-source-header ((t (:background "#1a1a1a" :foreground "#dedede" :weight bold :height 1.3 :family "Sans Serif"))))
;;  '(js-mode-default ((t (:inherit prog-mode-default))) t)
;;  '(link ((t (:foreground "#719bdf" :underline t))))
;;  '(minibuffer-inactive-mode-default ((t (:inherit autoface-default))) t)
;;  '(minibuffer-prompt ((t (:inherit minibuffer :foreground "#d0e0ed"))))
;;  '(mode-line ((t (:inherit aquamacs-variable-width :background "#0e0e0e" :foreground "#f5fefd" :box (:line-width -1 :style released-button) :strike-through nil :underline nil :slant normal :weight normal :width normal))))
;;  '(package-menu-mode-default ((t (:inherit tabulated-list-mode-default :background "#000000"))) t)
;;  '(ruby-mode-default ((t (:inherit prog-mode-default :height 160 :family "Anonymous Pro"))) t)
;;  '(sass-mode-default ((t (:inherit haml-mode-default :height 180 :family "Anonymous Pro"))) t)
;;  '(scss-mode-default ((t (:inherit css-mode-default :height 140 :family "Anonymous Pro"))) t)
;;  '(swift-mode-default ((t (:inherit prog-mode-default :background "#000c10" :foreground "#88ddf4"))) t)
;;  '(tabbar-button ((t (:inherit tabbar-default :box nil))))
;;  '(tabbar-button-highlight ((t (:inherit nil))))
;;  '(tabbar-default ((t (:stipple nil :background "selectedMenuItemTextColor" :foreground "Black" :box nil :strike-through nil :underline nil :slant normal :weight bold :height 140 :width normal :family "Anonymous Pro"))))
;;  '(tabbar-highlight ((t (:underline "Red"))))
;;  '(tabbar-unselected ((t (:inherit tabbar-default :background "gray80" :foreground "secondaryLabelColor" :box (:line-width 3 :color "grey80")))))
;;  '(text-mode-default ((t (:inherit default :background "#000000" :foreground "#c6c6c6" :height 160 :family "Anonymous Pro"))))
;;  '(web-mode-default ((t (:inherit web-mode-prog-mode-default :background "#000000" :foreground "#c5c5c5" :height 150 :family "Anonymous Pro"))) t)
;;  '(widget-field ((t (:background "#ababab" :foreground "#000000"))))
;;  '(yaml-mode-default ((t (:inherit autoface-default :background "#000000" :foreground "#96b2a4"))) t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(autoface-default ((t (:inherit default :height 180 :family "Anonymous Pro"))))
 '(emacs-lisp-mode-default ((t (:inherit prog-mode-default :height 150 :family "Anonymous Pro"))) t)
 '(fundamental-mode-default ((t (:inherit autoface-default))) t)
 '(ruby-mode-default ((t (:inherit prog-mode-default :height 160 :family "Anonymous Pro"))) t)
 '(sass-mode-default ((t (:inherit haml-mode-default :height 180 :family "Anonymous Pro"))) t))

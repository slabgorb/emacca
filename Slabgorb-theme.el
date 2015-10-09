(deftheme Slabgorb
  "Created 2015-10-08.")

(custom-theme-set-variables
 'Slabgorb
 '(aquamacs-additional-fontsets nil)
 '(aquamacs-customization-version-id 307)
 '(aquamacs-tool-bar-user-customization nil)
 '(default-frame-alist (quote ((alpha 100 85) (left . 0) (width . 141) (height . 44))))
 '(ns-tool-bar-display-mode (quote both))
 '(ns-tool-bar-size-mode nil)
 '(visual-line-mode t)
 '(global-hl-line-mode t)
 '(global-linum-mode t)
 '(aquamacs-autoface-mode nil)
 '(aquamacs-tool-bar-user-customization nil t)
 '(blink-cursor-mode 1)
 '(set-face-background hl-line-face "#080808")
 '(custom-safe-themes (quote ("7223a5da43181da5b98198b69cc0099c67f89c90c376f7d36a321fc3b5131d47" "ee331270a8c7855e380113998e7bbc0ab72fe6b0974e3c7074d12c00b590dcb5" "d117d3994d64122bae967357c2b2958f837d8edd4c3206ee64db38cd49387a68" "e0e40b5743a0f0a484bbb037bf363787620f3986ff06aa03a370391dc2e7fe7b" "e0c3ef2750b8556c0a2853ee2d0824e8e5baebaa86e4648fc6a3d653953a1922" default))))

(custom-theme-set-faces
 'Slabgorb
 '(special-mode-default ((t (:inherit autoface-default))))
 '(messages-buffer-mode-default ((t (:inherit special-mode-default))))
 '(sass-mode-default ((t (:inherit haml-mode-default :height 180 :family "Anonymous Pro"))))
 '(yaml-mode-default ((t (:inherit autoface-default :height 160 :family "Anonymous Pro"))))
 '(prog-mode-default ((t (:inherit autoface-default))))
 '(enh-ruby-parent-mode-default ((t (:inherit autoface-default))))
 '(web-mode-prog-mode-default ((t (:inherit autoface-default))))
 '(log-edit-mode-default ((t (:inherit text-mode-default))))
 '(vc-git-log-edit-mode-default ((t (:inherit log-edit-mode-default))))
 '(css-mode-default ((t (:inherit autoface-default))))
 '(log-view-mode-default ((t (:inherit special-mode-default))))
 '(vc-git-log-view-mode-default ((t (:inherit log-view-mode-default))))
 '(help-mode-default ((t (:inherit special-mode-default))))
 '(vc-annotate-mode-default ((t (:inherit special-mode-default))))
 '(web-mode-default ((t (:inherit web-mode-prog-mode-default :height 150 :family "Anonymous Pro"))))
 '(ruby-mode-default ((t (:inherit prog-mode-default :height 160 :family "Anonymous Pro"))))
 '(js-mode-default ((t (:inherit prog-mode-default :height 160 :family "Anonymous Pro"))))
 '(diff-mode-default ((t (:inherit autoface-default))))
 '(compilation-mode-default ((t (:inherit autoface-default))))
 '(scss-mode-default ((t (:inherit css-mode-default :height 140 :family "Anonymous Pro"))))
 '(text-mode-default ((t (:inherit autoface-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 130 :width normal :family "Lucida Grande"))))
 '(dired-mode-default ((t (:inherit autoface-default :height 180 :family "Anonymous Pro"))))
 '(coffee-mode-default ((t (:inherit prog-mode-default :height 160 :family "Anonymous Pro"))))
 '(tar-mode-default ((t (:inherit special-mode-default))))
 '(emacs-lisp-mode-default ((t (:inherit prog-mode-default :height 150 :family "Anonymous Pro"))))
 '(color-theme-mode-default ((t (:inherit autoface-default))))
 '(enh-ruby-mode-default ((t (:inherit enh-ruby-parent-mode-default :stipple nil :background "#494949" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "nil" :family "Anonymous Pro"))))
 '(fundamental-mode-default ((t (:inherit autoface-default))))
 '(minibuffer-inactive-mode-default ((t (:inherit autoface-default :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Monaco"))))
 '(font-lock-constant-face ((t (:background "#000000" :foreground "#6dab9f" :weight bold))))
 '(font-lock-comment-face ((t (:foreground "#7fd48e" :slant italic))))
 '(font-lock-type-face ((t (:foreground "#84a5d8" :weight bold))))
 '(helm-ff-directory ((t (:background "#1c2533" :foreground "#5f779d"))))
 '(helm-selection ((t (:background "#87ccd1" :foreground "#243e3b"))))
 '(helm-ff-dotted-directory ((t (:background "#4b6e81" :foreground "#8bc9e8"))))
 '(dired-header ((t (:foreground "#83c3a2"))))
 '(default ((t (:inherit nil :stipple nil :background "Black" :foreground "#92cce3" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 180 :width normal :foundry "nil" :family "Anonymous Pro"))))
 '(dired-directory ((t (:foreground "#14efff"))))
 '(font-lock-variable-name-face ((t (:foreground "#7eabed" :slant italic :weight bold))))
 '(font-lock-function-name-face ((t (:foreground "#8edced" :slant italic :weight bold))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#7fd48c"))))
 '(font-lock-string-face ((t (:foreground "#97a7d7" :slant italic))))
 '(font-lock-keyword-face ((t (:foreground "#6175d7" :weight bold)))))

(provide-theme 'Slabgorb)

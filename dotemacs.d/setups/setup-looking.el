;;; setup-looking.el --- setup of GUI

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords: convenience,

;; ;;色 ----------
(require 'color-theme)


(setq default-frame-alist
      (append
       '((top . 0) (left . 0) (width . 103 ) (height . 56)) ;; ウィンドウサイズ 
       default-frame-alist))

;; ウィンドウサイズの確認手順
;; scratchバッファで
;; (frame-width) C-j
;; (frame-height) C-j


(require 'moe-theme)
;; ;; moe-theme
;; ;; (require 'moe-theme-switcher)
;; (load-theme 'moe-dark t)
;; ;; (setq show-paren-style 'expression)

(require 'gotham-theme)
(load-theme 'gotham t)

;; (load-theme 'spacemacs-dark t)

(global-hl-line-mode)

(provide 'setup-looking)

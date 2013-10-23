;;; setup-looking.el --- setup of GUI

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords: convenience,

;; ;;色 ----------
(require 'color-theme)
;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-initialize)
;;      ;; (color-theme-clarity)
;;      (color-theme-hober)
;;      ))

 (setq default-frame-alist
      (append
       '((top . 0) (left . 0) (width . 115 ) (height . 73)) ;; ウィンドウサイズ 
       default-frame-alist))

;; ウィンドウサイズの確認手順
;; scratchバッファで
;; (frame-width) C-j
;; (frame-height) C-j

;; moe-theme
;; (require 'moe-theme-switcher)
(load-theme 'moe-dark t)

(global-hl-line-mode)


(provide 'setup-looking)

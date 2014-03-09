;;; setup-looking.el --- setup of GUI

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords: convenience,

;; ;;色 ----------
(require 'color-theme)

;; (defun color-theme-christmas ()
;;   "Example theme. Carbon copy of color-theme-gnome contributed by Jonadab."
;;   (interactive)
;;   (color-theme-install
;;    '(color-theme-example
;;      ((foreground-color . "white")
;;       (background-color . "forestgreen")
;;       (background-mode . dark))
;;      (default ((t (nil))))
;;      (region ((t (:foreground "#EBCA1B" :background "#080059"))))
;;      (underline ((t (:foreground "#EBCA1B" :underline t))))
;;      (modeline ((t (:foreground "#D7C447" :background "#00A0E9"))))
;;      (modeline-buffer-id ((t (:foreground "#D7C447" :background "#00A0E9"))))
;;      (modeline-mousable ((t (:foreground "#D7C447" :background "#00A0E9"))))
;;      (modeline-mousable-minor-mode ((t (:foreground "#D7C447" :background "#00A0E9"))))
;;      (italic ((t (:foreground "#5D070C" :italic t))))
;;      (bold-italic ((t (:foreground "#5D070C" :bold t :italic t))))
;;      (font-lock-comment-face ((t (:foreground "red4"))))
;;      ()
;;      (bold ((t (:bold)))))))


;; (eval-after-load "color-theme"
;;   '(progn
;;      (color-theme-initialize)
;;      ;; (color-theme-clarity)
;;      (color-theme-hober)
;;      ))



 (setq default-frame-alist
      (append
       '((top . 0) (left . 0) (width . 115 ) (height . 56)) ;; ウィンドウサイズ 
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

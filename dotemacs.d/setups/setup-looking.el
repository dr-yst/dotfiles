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
;; moe-theme
;; (require 'moe-theme-switcher)
(load-theme 'moe-dark t)
;; (setq show-paren-style 'expression)

;; (load-theme 'spacemacs-dark t)

(global-hl-line-mode)

;; GUIで直接ファイルを開いた場合フレームを作成しない
(add-hook 'before-make-frame-hook
          (lambda ()
            (when (eq tabbar-mode t)
              (switch-to-buffer (buffer-name))
              ;; (delete-this-frame)
              )))


(provide 'setup-looking)

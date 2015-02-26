;;; setup-tabbar.el --- setup of tabbar

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords: tabbar

;; tabbar.el------------------------------------------

(require 'tabbar)
(tabbar-mode 1)
;; scratch buffer 以外をまとめてタブに表示する
(setq tabbar-buffer-groups-function
      (lambda (b) (list "All Buffers")))
(setq tabbar-buffer-list-function
      (lambda ()
        (remove-if
         (lambda(buffer)
           (find (aref (buffer-name buffer) 0) " *"))
         (buffer-list))))
(tabbar-mode)

;; M-[で前のタブに移動, M-]で次のタブ
(global-set-key "\M-]" 'tabbar-forward)
(global-set-key "\M-[" 'tabbar-backward)

;; タブ上でマウスホイール無効化
(tabbar-mwheel-mode -1)

;; グループ化しない
(setq tabbar-buffer-groups-function nil)

;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

;; ウインドウからはみ出たタブを省略して表示
(setq tabbar-auto-scroll-flag nil)
 
;; タブとタブの間の長さ
(setq tabbar-separator '(0.5))

;; 外観変更
(set-face-attribute
 'tabbar-default nil
 :family "Comic Sans MS"
 :background "#17806D"                  ;Tropical Rain Forest
 :foreground "#EEEEEE"                  
 :height 1.0)
(set-face-attribute
 'tabbar-unselected nil
 :background "#17806D"
 :foreground "#EEEEEE"
 :box nil
 ;; :box '(:line-width 2 :color "midnight blue" :style released-button)
 )
(set-face-attribute
 'tabbar-selected nil
 :background "white"
 :foreground "#c82829"
 :box nil
 ;; :box '(:line-width 2 :color "white" :style pressed-button)
 )
(set-face-attribute
 'tabbar-modified nil
 :background "#FF7F49"                  ; Burnt Orange
 :foreground "#1974D2"                  ;Navy Blue
 :box nil)

(set-face-attribute
 'tabbar-button nil
 :box nil)
 (set-face-attribute
  'tabbar-separator nil
  :height 1.8)

;; M-4 で タブ表示、非表示
(global-set-key "\M-4" 'tabbar-mode)

;; GUIで直接ファイルを開いた場合フレームを作成しない
(add-hook 'before-make-frame-hook
          (lambda ()
            (when (eq tabbar-mode t)
              (switch-to-buffer (buffer-name))
              (delete-this-frame))))

(provide 'setup-tabbar)

;;; setup-ace-jump.el --- setup of ace-jump-mode

;; Copyright (C) 2014  渡辺 良人

;; Author: 渡辺 良人 <yoshito@Yoshitos-iMac.local>
;; Keywords: 

;; ace-jump-mode.el----------------------------
(require 'ace-jump-mode)

(setq ace-jump-mode-move-keys
      (append "jklasdfghyuiopqwertnmzxcvb" nil))

(global-set-key (kbd "C-+") 'ace-jump-char-mode)
(global-set-key (kbd "C-M-;") 'ace-jump-line-mode)
(setq ns-function-modifier (quote hyper))  ; set Mac's Fn key to Hyper


(provide 'setup-ace-jump)

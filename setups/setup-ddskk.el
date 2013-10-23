;;; setup-ddskk.el --- setup of ddskk

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@Yoshitos-iMac.local>
;; Keywords:

(require 'info)
(add-to-list 'Info-additional-directory-list "~/.emacs.d/info")

;;skk-server AquaSKK
(setq skk-server-portnum 1178)
(setq skk-server-host "localhost")

(setq skk-user-directory "~/.emacs.d/ddskk/") ; ディレクトリ指定
(when (require 'skk-autoloads nil t)
  ;; C-x C-j で skk モードを起動
  (when (require 'dired-x nil t)
    (global-set-key "\C-x\C-j" 'skk-mode)
    (global-set-key "\C-xj" 'skk-mode))
  
  ;; .skk を自動的にバイトコンパイル
  (setq skk-byte-compile-init-file t))

(require 'skk-vars)

;;; カナモードのときにC-oしてもひらがなモードにもどる
(defun my:skk-kakutei-key (arg)
  (interactive "P")
  (if skk-henkan-mode
      (skk-kakutei arg)
    (skk-j-mode-on)))

(add-to-list 'skk-rom-kana-rule-list
             '(skk-kakutei-key nil my:skk-kakutei-key))

(provide 'setup-ddskk)

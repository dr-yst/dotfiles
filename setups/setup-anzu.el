;;; setup-anzu.el --- setup of anzu

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords:



(require 'anzu)
(global-anzu-mode t)

(set-face-attribute 'anzu-mode-line nil
                    :foreground "yellow" :weight 'bold)

(provide 'setup-anzu)

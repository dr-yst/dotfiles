;;; setup-egg.el --- setup of egg

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@Yoshitos-iMac.local>
;; Keywords: git

(when (executable-find "git")
  (require 'egg nil t))

(provide 'setup-egg)

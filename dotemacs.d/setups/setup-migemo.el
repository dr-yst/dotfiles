;;; setup-migemo.el --- setup of migemo

;; Copyright (C) 2014  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords: migemo,

(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

;; Set your installed path
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)

(provide 'setup-migemo)


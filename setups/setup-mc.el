;;; setup-mc.el --- setup of multiple-cursors

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@Yoshitos-iMac.local>
;; Keywords: cursors

(require 'multiple-cursors)
(require 'smartrep)

(global-set-key (kbd "C-c C-a") 'mc/edit-lines)
;; (global-set-key (kbd "C-}") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-{") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-<") 'mc/unmark-next-like-this)
;; (global-set-key (kbd "C->") 'mc/unmark-previous-like-this)

;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(smartrep-define-key global-map "C-c"
  '(("}"        . 'mc/mark-next-like-this)
    ("{"        . 'mc/mark-previous-like-this)
    ("m"        . 'mc/mark-more-like-this-extended)
    ("<"        . 'mc/unmark-next-like-this)
    (">"        . 'mc/unmark-previous-like-this)
;;    ("s"        . 'mc/skip-to-next-like-this)
;;    ("S"        . 'mc/skip-to-previous-like-this)
    ("*"        . 'mc/mark-all-like-this)
;;    ("d"        . 'mc/mark-all-like-this-dwim)
;;    ("i"        . 'mc/insert-numbers)
;;    ("o"        . 'mc/sort-regions)
    ;;("O"        . 'mc/reverse-regions)
    ))

(provide 'setup-mc)

;;; setup-zlc.el --- setup of zlc

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@Yoshitos-iMac.local>
;; Keywords: files,

(require 'zlc)

(setq zlc-select-completion-immediately t)

(let ((map minibuffer-local-map))
  ;;; like menu select
  (define-key map (kbd "<down>")  'zlc-select-next-vertical)
  (define-key map (kbd "<up>")    'zlc-select-previous-vertical)
  (define-key map (kbd "<right>") 'zlc-select-next)
  (define-key map (kbd "<left>")  'zlc-select-previous)

  ;;; reset selection
  (define-key map (kbd "C-g") 'zlc-reset)
  )

(provide 'setup-zlc)

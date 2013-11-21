;;; setup-hi-lock-mode.el --- setup of hi-lock-mode

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@Yoshitos-iMac.local>
;; Keywords:

(global-hi-lock-mode 1)
(setq hi-lock-file-patterns-policy t)

;; key             binding
;; C-x w b         hi-lock-write-interactive-patterns
;; C-x w r         unhighlight-regexp
;; C-x w h         highlight-regexp
;; C-x w p         highlight-phrase
;; C-x w l         highlight-lines-matching-regexp
;; C-x w i         hi-lock-find-patterns

;;  M-s h w         hi-lock-write-interactive-patterns
;;  M-s h u         unhighlight-regexp
;;  M-s h r         highlight-regexp
;;  M-s h p         highlight-phrase
;;  M-s h l         highlight-lines-matching-regexp
;;  M-s h f         hi-lock-find-patterns

(provide 'setup-hi-lock-mode)

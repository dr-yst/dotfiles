;;; setup-ace-jump.el --- setup of ace-jump-mode

;; Copyright (C) 2014  渡辺 良人

;; Author: 渡辺 良人 <yoshito@Yoshitos-iMac.local>
;; Keywords: 

;; ace-jump-mode.el----------------------------
(require 'ace-jump-mode)
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

(setq ns-function-modifier (quote hyper))  ; set Mac's Fn key to Hyper

(defun add-keys-to-ace-jump-mode (prefix c &optional mode)
  (define-key global-map
    (read-kbd-macro (concat prefix (string c)))
    `(lambda ()
       (interactive)
       (funcall (if (eq ',mode 'word)
                    #'ace-jump-word-mode
                  #'ace-jump-char-mode) ,c))))

;; (loop for c from ?0 to ?9 do (add-keys-to-ace-jump-mode "H-" c))
;; (loop for c from ?a to ?z do (add-keys-to-ace-jump-mode "H-" c))
;; (loop for c from ?0 to ?9 do (add-keys-to-ace-jump-mode "C-M-S-" c 'word)) これは使えない
(loop for c from ?a to ?z do (add-keys-to-ace-jump-mode "C-M-S-" c 'word))

(provide 'setup-ace-jump)

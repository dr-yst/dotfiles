;;; setup-guidekey.el --- setup of guide-key.el

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords:

(require 'guide-key)
(guide-key-mode 1)

(defun guide-key/my-hook-function-for-org-mode ()
  (guide-key/add-local-guide-key-sequence "C-c")
  (guide-key/add-local-guide-key-sequence "C-c C-x")
  (guide-key/add-local-highlight-command-regexp "org-"))
(add-hook 'org-mode-hook 'guide-key/my-hook-function-for-org-mode)

(defun guide-key/my-hook-function-for-LaTeX-mode ()
  ;; (guide-key/add-local-guide-key-sequence "C-c")
  ;; (guide-key/add-local-guide-key-sequence "C-c C-c")
  (guide-key/add-local-guide-key-sequence "C-c C-p")
  (guide-key/add-local-guide-key-sequence "C-c C-p C-c")
  (guide-key/add-local-highlight-command-regexp "TeX-")
  (guide-key/add-local-highlight-command-regexp "reftex-")
  (guide-key/add-local-highlight-command-regexp "preview-"))
(add-hook 'LaTeX-mode-hook 'guide-key/my-hook-function-for-LaTeX-mode)


(provide 'setup-guidekey)

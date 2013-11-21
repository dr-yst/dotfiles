;;; setup-markdown-mode.el --- setup of markdown-mode

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@Yoshitos-iMac.local>
;; Keywords:

(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

(provide 'setup-markdown-mode)

;;; setup-term.el --- setup of terminal

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords: terminals,

;; ターミナル関連---------------------------------
;; Find available shell
(defun skt:shell ()
  (or (executable-find "/opt/local/bin/zsh")
      (executable-find "bash") ;; zshユーザは一行下と入れ替え
      ;; (executable-find "f_zsh") ;; Emacs + Cygwin を利用する人は Zsh の代りにこれにしてください
      ;; (executable-find "f_bash") ;; Emacs + Cygwin を利用する人は Bash の代りにこれにしてください
      (error "No shell program was found in your PATH...")))
 
;; Set shell-name
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)


(setq shell-command-switch "-ic")

(setq system-uses-terminfo nil)

;; multi-term.el --------------------------------
(when (require 'multi-term nil t)
  (setq multi-term-program "/opt/local/bin/zsh"))

;; my-keybinds for keybinds -e
(defun term-send-forward-char ()
  (interactive)
  (term-send-raw-string "\C-f"))

(defun term-send-backward-char ()
  (interactive)
  (term-send-raw-string "\C-b"))

(defun term-send-previous-line ()
  (interactive)
  (term-send-raw-string "\C-p"))

(defun term-send-next-line ()
  (interactive)
  (term-send-raw-string "\C-n"))

(add-hook 'term-mode-hook
          '(lambda ()
             (let* ((key-and-func
                     `(("\C-p"           term-send-previous-line)
                       ("\C-n"           term-send-next-line)
                       ("\C-b"           term-send-backward-char)
                       ("\C-f"           term-send-forward-char)
                       (,(kbd "C-h")     term-send-backspace)
                       (,(kbd "C-y")     term-paste)
                       (,(kbd "ESC ESC") term-send-raw)
                       (,(kbd "C-M-p")   multi-term-prev)
                       (,(kbd "C-M-n")   multi-term-next)
                       ;; 利用する場合は
                       ;; helm-shell-historyの記事を参照してください
                       ;; ("\C-r"           helm-shell-history)
                       )))
               (loop for (keybind function) in key-and-func do
                     (define-key term-raw-map keybind function)))))

(global-set-key (kbd "C-c t") '(lambda ()
                                 (interactive)
                                 (multi-term)))

(global-set-key (kbd "C-x t") '(lambda ()
                                (interactive)
                                (if (get-buffer "*terminal<1>*")
                                    (switch-to-buffer "*terminal<1>*")
                                (multi-term))))

(provide 'setup-term)

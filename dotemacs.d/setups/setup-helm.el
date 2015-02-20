;;; setup-helm.el --- setup of helm

;; Copyright (C) 2014  WatanabeYoshito

;; Author: WatanabeYoshito <yoshito@WatanabeYoshito-no-iMac.local>
;; Keywords:

(require 'helm)

;; customize
(progn
  (require 'helm-ls-git)
  (custom-set-variables
   '(helm-truncate-lines t)
   '(helm-buffer-max-length 35)
   '(helm-delete-minibuffer-contents-from-point t)
   '(helm-ff-skip-boring-files t)
   '(helm-boring-file-regexp-list '("~$" "\\.elc$"))
   '(helm-ls-git-show-abs-or-relative 'relative)
   '(helm-mini-default-sources '(helm-source-buffers-list
                                 helm-source-ls-git
                                 helm-source-recentf
                                 helm-source-buffer-not-found))))

;; set helm-command-prefix-key to "C-z"
(progn
  (require 'helm-config)
  (global-unset-key (kbd "C-z"))
  (custom-set-variables
   '(helm-command-prefix-key "C-z")))

;; key settings
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-M-z") 'helm-resume)
(define-key helm-command-map (kbd "d") 'helm-descbinds)
(define-key helm-command-map (kbd "g") 'helm-ag)
(define-key helm-command-map (kbd "o") 'helm-occur)
(define-key helm-command-map (kbd "y") 'yas/insert-snippet)
(define-key helm-command-map (kbd "M-/") 'helm-dabbrev)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-map (kbd "C-w") 'backward-kill-word-or-kill-region)
(eval-after-load "helm-files"
  '(progn
     (define-key helm-find-files-map (kbd "C-h") 'helm-ff-backspace)
     (define-key helm-find-files-map (kbd "C-i") 'helm-execute-persistent-action)
     (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
     ))

;; find-fileをいい感じにする
(defadvice helm-mode (around avoid-read-file-name activate)
  (let ((read-file-name-function read-file-name-function)
        (completing-read-function completing-read-function))
    ad-do-it))
(setq completing-read-function 'my-helm-completing-read-default)
(defun my-helm-completing-read-default (&rest _)
  (apply (cond ;; [2014-08-11 Mon]helm版のread-file-nameは重いからいらない
          ((eq (nth 1 _) 'read-file-name-internal)
           'completing-read-default)
          (t
           'helm--completing-read-default))
         _))

(defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
  "Execute command only if CANDIDATE exists"
  (when (file-exists-p candidate)
    ad-do-it))

(defadvice helm-ff-transform-fname-for-completion (around my-transform activate)
  "Transform the pattern to reflect my intention"
  (let* ((pattern (ad-get-arg 0))
         (input-pattern (file-name-nondirectory pattern))
         (dirname (file-name-directory pattern)))
    (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
    (setq ad-return-value
          (concat dirname
                  (if (string-match "^\\^" input-pattern)
                      ;; '^' is a pattern for basename
                      ;; and not required because the directory name is prepended
                      (substring input-pattern 1)
                    (concat ".*" input-pattern))))))

(defun helm-buffers-list-pattern-transformer (pattern)
  (if (equal pattern "")
      pattern
    ;; Escape '.' to match '.' instead of an arbitrary character
    (setq pattern (replace-regexp-in-string "\\." "\\\\." pattern))
    (let ((first-char (substring pattern 0 1)))
      (cond ((equal first-char "*")
             (concat " " pattern))
            ((equal first-char "=")
             (concat "*" (substring pattern 1)))
            (t
             pattern)))))

(add-to-list 'helm-source-buffers-list
             '(pattern-transformer helm-buffers-list-pattern-transformer))

;; helm-font-families
(defun helm-font-families ()
  "Preconfigured `helm' for font family."
  (interactive)
  (flet ((helm-mp-highlight-match () nil))
    (helm-other-buffer
     '(helm-c-source-font-families)
     "*helm font families*")))

(defun helm-font-families-create-buffer ()
  (with-current-buffer
      (get-buffer-create "*Fonts*")
    (loop for family in (sort (delete-duplicates (font-family-list)) 'string<)
          do (insert
              (propertize (concat family "\n")
                          'font-lock-face
                          (list :family family :height 2.0 :weight 'bold))))
    (font-lock-mode 1)))

(defvar helm-c-source-font-families
      '((name . "Fonts")
        (init lambda ()
              (unless (helm-candidate-buffer)
                (save-window-excursion
                  (helm-font-families-create-buffer))
                (helm-candidate-buffer
                 (get-buffer "*Fonts*"))))
        (candidates-in-buffer)
        (get-line . buffer-substring)
        (action
         ("Copy Name" lambda
          (candidate)
          (kill-new candidate))
         ("Insert Name" lambda
          (candidate)
          (with-current-buffer helm-current-buffer
            (insert candidate))))))

(defvar helm-c-source-objc-headline
  '((name . "Objective-C Headline")
    (headline  "^[-+@]\\|^#pragma mark")))

(defun objc-headline ()
  (interactive)
  ;; Set to 500 so it is displayed even if all methods are not narrowed down.
  (let ((helm-candidate-number-limit 500))
    (helm-other-buffer '(helm-c-source-objc-headline)
                           "*ObjC Headline*")))

(global-set-key "\C-xp" 'objc-headline)


(require 'helm-ag)

(global-set-key (kbd "M-g .") 'helm-ag)
(global-set-key (kbd "M-g ,") 'helm-ag-pop-stack)
(global-set-key (kbd "M-g s") 'helm-ag-this-file)

(defun helm-ag-dot-emacs ()
  ".emacs.d以下を検索"
  (interactive)
  (helm-ag "~/.emacs.d/"))

(helm-mode 1)

(provide 'setup-helm)

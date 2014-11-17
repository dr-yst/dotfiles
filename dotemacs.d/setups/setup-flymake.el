;;; setup-flymake.el --- setup of flymake

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords: lisp, c

;; @ flymake.el

(require 'flymake)

;; popup.el を使って tip として表示
;; (require 'popup)
;; (defun my-popup-flymake-display-error ()
;;   (interactive)
;;   (let* ((line-no            (flymake-current-line-no))
;;          (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info
;;                                                            line-no)))
;;          (count              (length line-err-info-list)))
;;     (while (> count 0)
;;       (when line-err-info-list
;;         (let* ((file       (flymake-ler-file (nth (1- count)
;;                                                   line-err-info-list)))
;;                (full-file (flymake-ler-full-file (nth (1- count)
;;                                                       line-err-info-list)))
;;                (text      (flymake-ler-text (nth (1- count)
;;                                                  line-err-info-list)))
;;                (line      (flymake-ler-line (nth (1- count)
;;                                                  line-err-info-list))))
;;           (popup-tip (format "[%s] %s" line text))))
;;       (setq count (1- count)))))

;; エラーをミニバッファに表示する
(defun flymake-display-err-minibuffer ()
  "現在行の error や warinig minibuffer に表示する"
  (interactive)
  (let* ((line-no (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((file (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)))
      (setq count (1- count)))))

;; ;; 下の一行はflymakeモードでエラー行に飛べるコマンドをキーに割り当ててるコードですが、
;; ;; 個人的な理由でコメントアウトしてます。必要でしたらこのコメント削除して、アンコメントしてください
(define-key global-map (kbd "\C-cd") 'flymake-display-err-minibuffer)
(define-key global-map (kbd "\C-cn") 'flymake-goto-next-error)
(define-key global-map (kbd "\C-cp") 'flymake-goto-prev-error)
(define-key global-map (kbd "\C-cs") 'flymake-start-syntax-check)


 ;;;;;latex 
(defun flymake-tex-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-dir   (file-name-directory buffer-file-name))
         (local-file  (file-relative-name
                       temp-file
                       local-dir)))
    (list "platex" (list "-file-line-error" "-interaction=nonstopmode" local-file))))
(defun flymake-tex-cleanup-custom ()
  (let* ((base-file-name (file-name-sans-extension (file-name-nondirectory flymake-temp-source-file-name)))
          (regexp-base-file-name (concat "^" base-file-name "\\.")))
    (mapcar '(lambda (filename)
                      (when (string-match regexp-base-file-name filename)
                         (flymake-safe-delete-file filename)))
                (split-string (shell-command-to-string "ls"))))
  (setq flymake-last-change-time nil))

;; なぜか自動でflymake起動しないので手動でオンにしないといけない
(add-hook 'LaTeX-mode-hook
          (lambda()
            (push '("\\.tex$" flymake-tex-init flymake-tex-cleanup-custom) flymake-allowed-file-name-masks)))
;; (add-hook 'LaTeX-mode-hook 'flymake-mode-1)

;; C
;; http://d.hatena.ne.jp/nyaasan/20071216/p1
(defun flymake-c-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "gcc" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.\\(c\\|h\\|y\\l\\)$" flymake-c-init))
;; C++
(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" ;; "-std=c++11"
                      local-file))))
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.cpp$" flymake-cc-init))
(add-hook 'c++-mode-hook
          (lambda()
            (push '("\\.h$" flymake-cc-init) flymake-allowed-file-name-masks)))

;; Objective-C
(defvar xcode:iossdkver "7.1")
(defvar xcode:iossdkpath "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/")
(defvar xcode:iossdk (concat xcode:iossdkpath "SDKs/iPhoneSimulator" xcode:iossdkver ".sdk"))

(defvar xcode:macsdkver "10.9")
(defvar xcode:macsdkpath "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/")
(defvar xcode:macsdk (concat xcode:macsdkpath "SDKs/MacOSX" xcode:macsdkver ".sdk"))

(defvar flymake-objc-compiler (executable-find "clang"))
;; (defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-fobjc-arc" "-isysroot" xcode:sdk
;;                                                    ))
(defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99"
                                                   "-fblocks" "-fobjc-arc" "-Wno-unused-parameter"
                                              ;; "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200"
                                                   ;; "-framework Foundation" "-fsyntax-only" "-fno-color-diagnostics" "-fobjc-arc" "-fblocks" "-Wreturn-type" "-Wparentheses" "-Wswitch" "-Wno-unused-parameter" "-Wunused-variable" "-Wunused-value"
                                                   "-isysroot" xcode:iossdk)) ;## ここをiossdkとmacsdkで変える
(defvar flymake-last-position nil)
(defvar flymake-objc-compile-options '("-I."))

(defun flymake-objc-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list flymake-objc-compiler (append flymake-objc-compile-default-options flymake-objc-compile-options (list local-file)))))
(add-hook 'objc-mode-hook
          (lambda ()
            ;; 拡張子 m と h に対して flymake を有効にする設定 flymake-mode t の前に書く必要があります
            (push '("\\.m$" flymake-objc-init) flymake-allowed-file-name-masks)
            (push '("\\.h$" flymake-objc-init) flymake-allowed-file-name-masks)
            ;; 存在するファイルかつ書き込み可能ファイル時のみ flymake-mode を有効にします
            (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                (flymake-mode t))
            ))

;; Emacs Lisp
;; http://www.emacswiki.org/emacs/FlymakeElisp
(defun flymake-elisp-init ()
  (unless (string-match "^ " (buffer-name))
    (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
           (local-file  (file-relative-name
                         temp-file
                         (file-name-directory buffer-file-name))))
      (list
       (expand-file-name invocation-name invocation-directory)
       (list
        "-Q" "--batch" "--eval"
        (prin1-to-string
         (quote
          (dolist (file command-line-args-left)
            (with-temp-buffer
              (insert-file-contents file)
              (condition-case data
                  (scan-sexps (point-min) (point-max))
                (scan-error
                 (goto-char(nth 2 data))
                 (princ (format "%s:%s: error: Unmatched bracket or quote\n"
                                file (line-number-at-pos)))))))
          )
         )
        local-file)))))
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.el$" flymake-elisp-init))

(add-hook 'emacs-lisp-mode-hook
          ;; workaround for (eq buffer-file-name nil)
          (function (lambda () (if buffer-file-name (flymake-mode)))))
(add-hook 'c-mode-common-hook
          (lambda () (flymake-mode t)))
(add-hook 'php-mode-hook
          (lambda () (flymake-mode t)))


(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)

;; (set-face-background 'flymake-errline "red3")
;; (set-face-foreground 'flymake-errline "SpringGreen")
;; (set-face-background 'flymake-warnline "dimgray")

(provide 'setup-flymake)

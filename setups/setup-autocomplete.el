;;; setup-autocomplete.el --- setup of autocomplete

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords: abbrev,

;; ;; auto-complete --------------------------------
(require 'auto-complete-config)
(require 'auto-complete-clang)
;; (require 'auto-complete-clang-async)
(require 'auto-complete-etags)
(require 'ac-company)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict/")
;; (ac-config-default)

;; (define-key ac-completing-map "\C-j" 'ac-complete)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(define-key ac-menu-map "\C-j" 'ac-complete)
(setq ac-auto-start nil)              ; t or nil
(define-key ac-mode-map  (kbd "C-'") 'auto-complete)
(define-key ac-mode-map  (kbd "C-M-/") 'auto-complete)
;; (ac-set-trigger-key "M-_")
(setq ac-quick-help-delay 0.8)            ;クイックヘルプのディレイ
;; (setq ac-auto-start 4)                  ;何文字入力したらauto-completeになるか
;; (setq ac-auto-show-menu 0.8)  ;; 0.8秒後に自動で表示
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)




(defun my-ac-config ()
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers
                                              ac-source-yasnippet))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'python-mode-hook 'ac-python-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t)
  )

;; (defun my-ac-cc-mode-setup ()
;;   ;; (setq ac-clang-complete-executable "~/.emacs.d/elisp/emacs-clang-complete-async/clang-complete")
;;   (setq ac-sources (append '(;; ac-source-clang-async
;;                              ac-source-yasnippet ;yasnippet だけ
;;                              ) ac-sources)) ;etagsもある
;;   ;; (ac-clang-launch-completion-process) ;; auto-complete-clang-asyncの設定
;;   )
;; (add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup) ;my-ac-cc-mode-setup

;; ac-source-gtags
(my-ac-config)

(add-hook 'c-mode-hook
          (lambda()
            (setq ac-sources (append '(ac-source-clang) ac-sources))
            ;; (ac-clang-launch-completion-process) ;; async
            ;; (setq ac-clang-prefix-header "~/.emacs.d/fuga.pch")
            (setq ac-etags-use-document t)))


(add-hook 'c++-mode-hook
          (lambda()
            (setq ac-sources (append '(ac-source-clang
                                       ac-source-etags) ac-sources))
            ;; (ac-clang-launch-completion-process) ;; async
            (setq ac-clang-prefix-header "~/.emacs.d/hoge.pch")
            (setq ac-clang-flags
                  '("-std=c++11" "-w" "-ferror-limit" "1"))
            (setq ac-etags-use-document t)))

;; (add-hook 'python-mode-hook
;;           (lambda()
;;             (setq ac-sources (append '(ac-source-yasnippet)) ac-sources)))

;; Objective-C用の設定 -----------------------
; ac-company で company-xcode を有効にする
(ac-company-define-source ac-source-company-xcode company-xcode)
;; objc-mode で補完候補を設定
(setq ac-modes (append ac-modes '(objc-mode)))

;; hook
(add-hook 'objc-mode-hook
          (lambda ()
            (setq ac-clang-flags (list "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200" "-x" "objective-c" "-std=gnu99" "-isysroot" xcode:iossdk "-I." "-F.." "-fblocks" )) ;## iossdkとmacsdkを変える
            ;; (setq ac-clang-flags (append
            ;;                       flymake-objc-compile-default-options
            ;;                       flymake-objc-compile-options))
            (setq ac-sources (append '(ac-source-company-xcode ;; XCode を利用した補完を有効にする
                                       ac-source-clang
                                       ) ac-sources))
            ))

;;; yasnippetのbindingを指定するとエラーが出るので回避する方法。
;; (setf (symbol-function 'yas-active-keys)
;;       (lambda ()
;;         (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))

(provide 'setup-autocomplete)

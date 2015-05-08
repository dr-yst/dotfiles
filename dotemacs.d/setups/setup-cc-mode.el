;;; setup-cc-mode.el --- setup of cc-mode

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords: c,

;; imenuを自動リスキャン
(setq imenu-auto-rescan t)

;; includeフォルダにパスを通す
;; (setenv "C_INCLUDE_PATH"
;;         (concat (getenv "C_INCLUDE_PATH")
;;         ":./:/Users/yoshito/MyLib/include/:/opt/local/include/:/usr/local/include/:/usr/include/"))

;; (setenv "CPLUS_INCLUDE_PATH"
;;         (concat (getenv "CPLUS_INCLUDE_PATH")
;;         ":./:/Users/yoshito/MyLib/include/:/opt/local/include/:/usr/local/include/:/usr/include/"))

;java, C, C++モードでhs-minor-modeを自動的にＯＮにします
;cモードのc++, javaの元になるフックだけにいれておけばＯＫ
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; c++モードで前の文字までの空欄を全削除するモードと、セミコロンで自動改行するモード
(add-hook 'c-mode-common-hook
          '(lambda()
             (c-toggle-auto-hungry-state)
             (visual-line-mode t)))

(global-set-key "\C-c\C-t" 'c-toggle-auto-hungry-state)
;; (global-set-key "\C-c\C-d" 'c-toggle-hungry-state)
(global-set-key "\C-c\C-a" 'c-toggle-auto-newline)


;; etagsの参照tag
(setq tags-table-list
      '("~/MyLib"))

;; ;; gtags
;; (require 'gtags)

;; (add-hook 'c-mode-common-hook
;;           '(lambda()
;;              (gtags-mode 1)             ;gtags-mode
;;              (gtags-make-complete-list))) ;gtagsの補完

;; (setq gtags-mode-hook
;;       '(lambda()
;;          (local-set-key "\M-t" 'gtags-find-tag)
;;          (local-set-key "\M-r" 'gtags-find-rtag)
;;          (local-set-key "\M-s" 'gtags-find-symbol)
;;          (local-set-key "\C-t" 'gtags-pop-stack)))


;; C++で大文字を単語の一区切りにする
(add-hook 'c-mode-common-hook
          '(lambda ()
             (define-key c++-mode-map "\M-f"
               'c-forward-into-nomenclature)
             (define-key c++-mode-map "\M-b"
               'c-backward-into-nomenclature)
             (define-key objc-mode-map "\M-f"
               'c-forward-into-nomenclature)
             (define-key objc-mode-map "\M-b"
               'c-backward-into-nomenclature)
             ))


;; --- Obj-C switch between header and source ---

(setq ff-search-directories
      '("." "../SRC" "../include" "/opt/local/include" "/usr/local/include" "/usr/include"))

(setq ff-other-file-alist
      '(("\\.mm?$" (".h"))
        ("\\.cc$"  (".hh" ".h"))
        ("\\.hh$"  (".cc" ".C"))

        ("\\.c$"   (".h"))
        ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.C$"   (".H"  ".hh" ".h"))
        ("\\.H$"   (".C"  ".CC"))

        ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
        ("\\.HH$"  (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))

        ("\\.hpp$" (".cpp" ".c"))))
(add-hook 'c-mode-common-hook
         (lambda ()
           (define-key c-mode-base-map (kbd "C-q t") 'ff-find-other-file)
         ))

;; adaptive-wrap.el -----------------------

(when (fboundp 'adaptive-wrap-prefix-mode)
  (defun my-activate-adaptive-wrap-prefix-mode ()
    "Toggle `visual-line-mode' and `adaptive-wrap-prefix-mode' simultaneously."
    (if visual-line-mode
        (adaptive-wrap-prefix-mode 1)
      (adaptive-wrap-prefix-mode -1)))
  (add-hook 'visual-line-mode-hook 'my-activate-adaptive-wrap-prefix-mode))


(provide 'setup-cc-mode)

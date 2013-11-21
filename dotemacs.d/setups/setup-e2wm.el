;;; setup-e2wm.el --- setup of e2wm

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@Yoshitos-iMac.local>
;; Keywords:

(require 'e2wm)
(global-set-key (kbd "M-+") 'e2wm:start-management)

;; C-c ; Qで終了
;; C-c ; Mで最大化
;; C-c ; Cで時計
;; C-c ; 1でcode
;; C-c ; 2でtwo
;; C-c ; 3でdoc (follow-mode)
;; C-c ; 4でarray

;; twoモードでC-c ; dで同一バッファを並べる
(e2wm:add-keymap 
 e2wm:pst-minor-mode-keymap
 '(;; ("<M-left>" . e2wm:dp-code ) ; codeへ変更
   ;; ("<M-right>"  . e2wm:dp-two) ; twoへ変更
   ;; ("<M-up>"    . e2wm:dp-doc)  ; docへ変更
   ;; ("<M-down>"  . e2wm:dp-dashboard) ; dashboardへ変更
   ("C->"       . e2wm:pst-history-forward-command) ; 履歴進む
   ("C-<"       . e2wm:pst-history-back-command) ; 履歴戻る
   ;; ("C-M-s"     . e2wm:my-toggle-sub) ; subの表示をトグルする
   ;; ("prefix L"  . ielm) ; ielm を起動する（subで起動する）
   ("M-m"       . e2wm:pst-window-select-main-command) ; メインウインドウを選択する
   ) e2wm:prefix-key)

;; キーバインド
(e2wm:add-keymap
 e2wm:dp-two-minor-mode-map
 '(("prefix I" . info)
   ("C->" . e2wm:dp-two-right-history-forward-command) ; 右側の履歴を進む
   ("C-<" . e2wm:dp-two-right-history-back-command) ; 右側の履歴を進む
   ) e2wm:prefix-key)

;; キーバインド
(e2wm:add-keymap
 e2wm:dp-doc-minor-mode-map
 '(("prefix I" . info))
 e2wm:prefix-key)

;;; dashboard

(setq e2wm:c-dashboard-plugins
  '(clock top
    (open :plugin-args (:command eshell :buffer "*eshell*"))
    (open :plugin-args (:command doctor :buffer "*doctor*"))
    ))




(provide 'setup-e2wm)

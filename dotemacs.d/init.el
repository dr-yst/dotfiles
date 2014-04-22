;; Last Updated: <2014/04/22 18:30:32 from dr-yst-no-pc.local by yoshito>


; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ------------------------------------------------------------------------


;; @ load-path

;; load environment value
;; (load-file (expand-file-name "~/.emacs.d/shellenv.el"))
;; (dolist (path (reverse (split-string (getenv "PATH") ":")))
;;   (add-to-list 'exec-path path))

(setenv "MANPATH" (concat "/usr/local/man:/usr/share/man:/opt/local/man:/Developer/usr/share/man:/sw/share/man" (getenv "MANPATH")))

;; ;;load-pathの追加関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; ;; load-pathに追加するフォルダ
;; ;; 2つ以上フォルダを指定する場合の引数 => (add-to-load-path "elisp" "xxx" "xxx")
(add-to-load-path "setups" "elisp" "auto-install" ;; "plugins/yasnippet"
                  ;; "elisp/nyan-mode"
                  ;; "elisp/company" ;; "elisp/emacs-clang-complete-async"
                  "elisp/lilypond" ;; "el-get" ;; "el-get/el-get"
                  ;; "elisp/helm"
                  "elisp/emacs-zoom-window" "elisp/emacs-sound-wav")

(eval-when-compile
  (require 'cl))

;他のエディタでファイルが更新されたら自動でrevert
(global-auto-revert-mode 1) 

;; emacsとshellでパスを共有------------------------------------
(server-start)
(defun non-elscreen-current-directory ()
  (let* (current-dir
         (current-buffer
          (nth 1 (assoc 'buffer-list
                        (nth 1 (nth 1 (current-frame-configuration))))))
         (active-file-name
          (with-current-buffer current-buffer
            (progn
              (setq current-dir (expand-file-name (cadr (split-string (pwd)))))
              (buffer-file-name)))))
    (if active-file-name
        (file-name-directory active-file-name)
      current-dir)))

;; カレントディレクトリをFinderで開く------------------------
(defun open-current-dir-with-finder ()
  (interactive)
  (shell-command (concat "open .")))
(global-set-key "\C-cf" 'open-current-dir-with-finder)


;; el-get -----------------------------------------------------

;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))


;; (setq el-get-sources
;;       '(
;;         (:name golden-ratio
;;                :type git
;;                :url "https://github.com/roman/golden-ratio.el.git")
;;         (:name yasnippet
;;                :type git
;;                :url "https://github.com/emacsmirror/yasnippet.git")))

;; ;; (el-get 'wait '(golden-ratio yasnippet))

;; (el-get 'sync)

;; package.el -------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; (mapc
;;  (lambda (package)
;;    (or (package-installed-p package)
;;        (package-install package)))
;;  '(
;;    all
;;    all-ext
;;    ))


;;自動バイトコンパイル
;; (declare-function gud-find-c-expr "auto-async-byte-compile.el" nil)
;; (require 'auto-async-byte-compile)
;; (setq auto-async-byte-compile-exclude-files-regexp "/junk/")
;; (add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;; load environment variables -------------------------------
(let ((envs '("PATH" "C_INCLUDE_PATH" "CPLUS_INCLUDE_PATH" "TEXINPUTS" "BSTINPUTS" "BIBINPUTS")))
(exec-path-from-shell-copy-envs envs))


;;基本的なもの -------------------------------
;; スタートアップ非表示
;; (setq inhibit-startup-screen t)

(fset 'yes-or-no-p 'y-or-n-p)

(if (>= emacs-major-version 24)
    (electric-pair-mode t))

;; バッファの名前が重複した場合、上のフォルダまで表示する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; ;; 1行ずつスクロール
;; (setq scroll-conservatively 35
;;       scroll-margin 0
;;       scroll-step 1)
;; (setq comint-scroll-show-maximum-output t) ;; shell-mode

;; ;; タブをスペースで扱う
(setq-default indent-tabs-mode nil)


;; scratchの初期メッセージ消去
(setq initial-scratch-message "")

;meta keyの変更
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)
;; (global-set-key "\C-z" 'undo)
(global-set-key "\C-x\C-b" 'electric-buffer-list)
;; (global-set-key "\C-j" 'newline-and-indent)

;; original
(defun backward-kill-word-or-kill-region ()
  (interactive)
  (if (or (not transient-mark-mode) (region-active-p))
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))
(global-set-key "\C-w" 'backward-kill-word-or-kill-region)

(global-set-key "\M-h" 'backward-kill-word)
(global-set-key "\M-'" 'dabbrev-expand)

;; (global-set-key "\M-p" 'backward-paragraph)
;; (global-set-key "\M-n" 'forward-paragraph)
(global-set-key [C-M-f5] 'goto-line)
;; (global-set-key "\C-cr" 'rename-uniquely)
(global-set-key "\C-o" 'open-line)
(global-set-key "\M-n" (lambda () (interactive) (scroll-up 1)))
(global-set-key "\M-p" (lambda () (interactive) (scroll-down 1)))
(global-set-key "\M-N" (lambda () (interactive) (scroll-up 10)))
(global-set-key "\M-P" (lambda () (interactive) (scroll-down 10)))
		
(global-set-key "\C-@" 'ispell-word)
(global-set-key "\M-@" 'ispell-complete-word)

(define-key global-map (kbd "C-m") 'smart-newline)

;; スクロールしてもカーソルの相対位置変えない設定
;; (defun my-count-lines-window ()
;;   "Count lines relative to the selected window. The number of lines begins 0."
;;   (interactive)
;;   (let* ((window-string (buffer-substring-no-properties (window-start) (point)))
;;          (line-string-list (split-string window-string "\n"))
;;          (line-count 0)
;;          line-count-list)
;;     (setq line-count (1- (length line-string-list)))
;;     (unless truncate-lines      ; consider folding back
;;       ;; `line-count-list' is list of the number of physical lines which each logical line has.
;;       (setq line-count-list (mapcar '(lambda (str)
;;                                        (/ (my-count-string-columns str) (window-width)))
;;                                     line-string-list))
;;       (setq line-count (+ line-count (apply '+ line-count-list))))
;;     line-count))

;; (defun my-count-string-columns (str)
;;   "Count columns of string. The number of column begins 0."
;;   (with-temp-buffer
;;     (insert str)
;;     (current-column)))

;; (defadvice scroll-up (around scroll-up-relative activate)
;;   "Scroll up relatively without move of cursor."
;;   (let ((line (my-count-lines-window)))
;;     ad-do-it
;;     (move-to-window-line line)))

;; (defadvice scroll-down (around scroll-down-relative activate)
;;   "Scroll down relatively without move of cursor."
;;   (let ((line (my-count-lines-window)))
;;     ad-do-it
;;     (move-to-window-line line)))


;; (global-set-key "\M-l" 'ns-toggle-fullscreen)



;(global-set-key [C-backspace] 'backward-kill-word)
(global-set-key [end] 'end-of-buffer)
(global-set-key [home] 'beginning-of-buffer)


;;追加ライブラリとそのキーバインド---------------------------------------

;一行コピー
;; (load-library "copy-line")
;; (global-set-key "\C-o" 'copy-line)

;touch
(load-library "touch")


;画面左に行番号表示
;; (require 'linum)
;; (require 'hlinum)
;; (global-linum-mode)
;; (custom-set-faces
;;  '(linum-highlight-face ((t (:foreground "black"
;;                                          :background "SkyBlue3")
;;                             ))))

;; (setq linum-delay t)
;; (defadvice linum-schedule (around my-linum-schedule () activate)
;;   (run-with-idle-timer 0.2 nil #'linum-update-current))


(load-library "fold-dwim")
;ダブルクリックで，折りたたみtoggleを発動
;; (global-set-key [(double-mouse-1)] 'fold-dwim-toggle)
;all showとall hide ...うまく行かなかったのでやっぱり無し．
;;(global-set-key "\C-c\C-s" 'fold-dwim-show-all)
;;(global-set-key "\C-c\C-h" 'fold-dwim-hide-all)




;; 最近使ったファイルをメニューに表示
(recentf-mode t)

;; 最近使ったファイルの表示数
;(setq recentf-max-menu-items 10)

;; 行間
;(setq-default line-spacing 0)
;; バックアップを残さない
;(setq make-backup-files nil)

;; ;;カーソルの点滅を止めます
(blink-cursor-mode -1) 

;; ; 言語を日本語にする
(set-language-environment 'Japanese)
;; ; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;; (create-fontset-from-ascii-font
;;        "Source Code Pro-14:weight=normal:slant=normal"
;;        nil "codekakugo")
;; (set-fontset-font "fontset-codekakugo"
;;                         'unicode
;;                         (font-spec :family "Hiragino Kaku Gothic Pro" :size 14) 
;;                         nil 
;;                         'append)
;; (add-to-list 'default-frame-alist '(font . "fontset-codekakugo"))


(set-face-attribute 'default nil
                    :family "Source Code Pro"
                    :height 140         ;デフォルトは140
                    )

(set-fontset-font
  (frame-parameter nil 'font)
    'japanese-jisx0208
    '("Hiragino Kaku Gothic ProN" . "iso10646-1"))
(set-fontset-font
  (frame-parameter nil 'font)
    'japanese-jisx0212
    '("Hiragino Kaku Gothic ProN" . "iso10646-1")) 

;; ;;フォント
;; (when (>= emacs-major-version 23)
;;  (set-face-attribute 'default nil
;;                      :family "monaco"
;;                      ;; :height 170
;; 		     )
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'japanese-jisx0208
;;   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'japanese-jisx0212
;;   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
;;  (set-fontset-font
;;   (frame-parameter nil 'font)
;;   'mule-unicode-0100-24ff
;;   '("monaco" . "iso10646-1"))
;;  (setq face-font-rescale-alist
;;       '(("^-apple-hiragino.*" . 1.2)
;;         (".*osaka-bold.*" . 1.2)
;;         (".*osaka-medium.*" . 1.2)
;;         (".*courier-bold-.*-mac-roman" . 1.0)
;;         (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
;;         (".*monaco-bold-.*-mac-roman" . 0.9)
;;         ("-cdac$" . 1.3))))


;; ビープ音を消す
(setq visible-bell t)

;;; mark 領域に色付け
(setq transient-mark-mode t)

;;; 括弧の対応表示
(require 'paren)
(show-paren-mode)

;;; 前回の編集箇所を記録
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/Library/Application Support/places.txt")

;;バックアップファイルを~/backupに保存させます
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/Library/emacs-backup"))
	    backup-directory-alist))

;; テンプレートの保存先
(setq auto-insert-directory "~/.emacs.d/insert")
(auto-insert-mode 1)
;; テンプレート挿入時に尋ねない ;; デフォルトは 'function
(setq auto-insert-query nil)
(setq auto-insert-alist
      (append
       '(
         ;; モード名で指定
         ;;(-mode . "test.html")
         ;; ファイル名で指定
         ("\\.cpp$" . "template.cpp")
         ("\\.sh$" . "template.sh")
         )
       auto-insert-alist))

;; 辞書をaspellに変更
(setq-default ispell-program-name "aspell")
	      



;; ;; 残さない
(setq make-backup-files nil)


;;モード毎の設定-----------------------------------------------------

;;.hファイルをC++モードで開く。.shファイルが.hと見なされてしまうので、設定し直す
(setq auto-mode-alist
      (cons (cons ".\.h$" 'c++-mode) auto-mode-alist))

;; objective-cの.hファイルはobjc-modeで開く
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

(setq auto-mode-alist
      (cons (cons ".sh$" 'shell-script-mode) auto-mode-alist))

;;CSSモード
(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css$" . css-mode) auto-mode-alist))



;; プログラミング言語関連 -------------------------------------

(autoload 'se/make-summary-buffer "summarye" nil t)

;章や節の定義
(make-variable-buffer-local 'outline-regexp)


;; python-mode
(add-hook 'python-mode-hook
          '(lambda()
             (define-key python-mode-map (kbd "C-,") 'python-shift-left)
             (define-key python-mode-map (kbd "C-.") 'python-shift-right)
             ))
(require 'highlight-indentation)
(setq highlight-indentation-offset 4)
;; (set-face-background 'highlight-indentation-face "gray37")
(set-face-background 'highlight-indentation-current-column-face "LemonChiffon4")
;; (add-hook 'python-mode-hook 'highlight-indentation-mode)
(add-hook 'python-mode-hook 'highlight-indentation-current-column-mode)


;; Lilypond mode
(autoload 'LilyPond-mode "lilypond-mode")
(setq auto-mode-alist
      (cons '("\\.ly$" . LilyPond-mode) auto-mode-alist))
(add-hook 'LilyPond-mode-hook 'turn-on-font-lock) 




;; ;; dired関連--------------------------------------------------
;; ;;; フォルダを開く時, 新しいバッファを作成しない
;; aで同じバッファに読み込み
(put 'dired-find-alternate-file 'disabled nil)
;; ^で親フォルダに移動するときも同じバッファに読み込む
(add-hook 'dired-mode-hook
 (lambda ()
  (define-key dired-mode-map (kbd "^")
    (lambda () (interactive) (find-alternate-file "..")))
  ; was dired-up-directory
 ))

;; ;; RETで同じバッファに読み込むようにする
;; (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
;; (define-key dired-mode-map (kbd "a") 'dired-find-file)

;; ;; ---------- or --------------
;; (defun dired-find-alternate-file ()
;;   "In dired, visit this file or directory instead of the dired buffer."
;;   (interactive)
;;   (set-buffer-modified-p nil)
;;   (find-alternate-file (dired-get-filename)))


;; ;; ---------- or --------------
;; バッファを作成したい時にはoやC-u ^を利用する
;; (defvar my-dired-before-buffer nil)
;; (defadvice dired-advertised-find-file
;;   (before kill-dired-buffer activate)
;;   (setq my-dired-before-buffer (current-buffer)))

;; (defadvice dired-advertised-find-file
;;   (after kill-dired-buffer-after activate)
;;   (if (eq major-mode 'dired-mode)
;;       (kill-buffer my-dired-before-buffer)))

;; (defadvice dired-up-directory
;;   (before kill-up-dired-buffer activate)
;;   (setq my-dired-before-buffer (current-buffer)))

;; (defadvice dired-up-directory
;;   (after kill-up-dired-buffer-after activate)
;;   (if (eq major-mode 'dired-mode)
;;       (kill-buffer my-dired-before-buffer)))



;; 時間管理 ----------------------------------
;;; ステータスラインに時間を表示する
(if (equal (substring (concat 
       (shell-command-to-string "defaults read -g AppleLocale") "__") 0 2) "ja")
      (progn
       (setq dayname-j-alist
            '(("Sun" . "日") ("Mon" . "月") ("Tue" . "火") ("Wed" . "水")
             ("Thu" . "木") ("Fri" . "金") ("Sat" . "土")))
       (setq display-time-string-forms
             '((format "%s年%s月%s日(%s) %s:%s %s"
                       year month day
                       (cdr (assoc dayname dayname-j-alist))
                       24-hours minutes
                       load)))))
(display-time)
(display-time-mode 1)


;;; 最終更新日の自動挿入---------------------
;;;   ファイルの先頭から 8 行以内に Time-stamp: <> または
;;;   Time-stamp: " " と書いてあれば、セーブ時に自動的に日付が挿入されます
;; (require 'time-stamp)
;; (if (not (memq 'time-stamp write-file-functions))
;;     (setq write-file-functions
;;    (cons 'time-stamp write-file-functions)))
;; (setq time-stamp-format "%:y(%:b) %02m/%02d  %02H:%02M:%02S  %s")

(require 'time-stamp)
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-start "[lL]ast[ -][uU]pdated[ \t]*:[ \t]*<")
(setq time-stamp-format "%:y/%02m/%02d %02H:%02M:%02S from %s by %u")
(setq time-stamp-end ">")
(setq time-stamp-line-limit 50)

;;     %:a → 「 Monday 」．曜日
;;     %#A → 「 MONDAY 」．曜日を全部大文字で
;;     %:b →「 September 」．月名．

;;     桁数を指定すると指定した文字だけが表示されます．"%2#A"なら「 MO 」など．

;;     %02H → 「 15 」 ．時刻 (24 時間)
;;     %02I → 「 03 」 ．時刻 (12 時間)
;;     %#p → 「 pm 」 PM と AM の別
;;     %P → 「 PM 」 PM と AM の別
;;     %w → 土曜なら 「 6 」 ．日曜を 0 とし，何番目の曜日なのか
;;     %02y → 「 03 」．西暦の下 2 桁．
;;     %z → 「 jst 」．タイムゾーン
;;     %Z → 「 JST 」．タイムゾーン
;;     %% → 「%」自体を入力
;;     %f → 「 meadowmemo.texi 」ファイル名
;;     %F → 「 d:/home/meadowmemo.texi 」ファイル名のフルパス
;;     %s → マシン名
;;     %u → ログインしたユーザ名
;;     %U → ログインしたユーザのフルネーム 

;; undo-tree.el---------------------------------------------------
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

(global-set-key "\C-\\" 'undo-tree-redo)

;; C-x uで起動

;redo----------------------------------------
;; (require 'redo)


;; point-undo.el--------------------------------------------------
(when (require 'point-undo nil t)
  (define-key global-map [f6] 'point-undo)
  (define-key global-map [f7] 'point-redo))

;; popwin.el-------------------------------------
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
;; (if (require 'popwin nil t)
;;     (progn
;; ;;       (push '("*anything*" :height 20) popwin:special-display-config)
;;       (push '("*anything*" :position left) popwin:special-display-config)
;;       (push '("*Completions*" :position bottom) popwin:special-display-config)
;;       (push '(dired-mode :position bottom) popwin:special-display-config)
;;       (push '("\\*[Vv][Cc]" :regexp t :position top) popwin:special-display-config)
;;       (push '("\\*git-" :regexp t :position top) popwin:special-display-config)
;;       ))

;; (push '(dired-mode :position bottom) popwin:special-display-config)
;; (setq popwin:popup-window-position 'right)


;; setups ------------------------------
(require 'setup-ddskk)
(require 'setup-looking)
;; (require 'setup-zlc) ; 上手く動かない
;; 多分anythingと競合してる


;; (require 'setup-ido-mode)
(require 'setup-egg)
(require 'setup-hi-lock-mode)
(require 'setup-term)
(require 'setup-sdic)
(require 'setup-e2wm)
(require 'setup-modeline)
(require 'setup-cc-mode)
(require 'setup-markdown-mode)
(require 'setup-latex-mode)
(require 'setup-flymake)
(require 'setup-tabbar)
(require 'setup-yasnippet)
(require 'setup-smartrep)
(require 'setup-mc)                     ;multiple-cursors
(require 'setup-anything)
(require 'setup-autocomplete)
(require 'setup-orgmode)
(require 'setup-anzu)
(require 'setup-guidekey)
(require 'setup-ace-jump)

;; jaunte.el-------------------------------------
;; 好きなところにカーソルを移動させる
(require 'jaunte)
(global-set-key (kbd "C-c j") 'jaunte)

;; historyf.el ------------------------------
(require 'historyf)
;; (global-unset-key (kbd "C-["))
(global-set-key (kbd "C-M-{") 'historyf-back);;shortcut key
(global-set-key (kbd "C-M-}") 'historyf-forward);;上に同じ

;; nyan-mode.el ------------------------------
;; (require 'nyan-mode)
;; (nyan-mode)
;; (nyan-start-animation)

;; direx.el---------------------------------------
;; (require 'direx)
;; (setq direx:leaf-icon "  "
;;       direx:open-icon "&#9662; "
;;       direx:closed-icon "&#9656; ")
;; (push '(direx:direx-mode :position left :width 25 :dedicated t)
;;       popwin:special-display-config)
;; (global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

;; auto-highlight-symbol.el------------------------
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

(define-key auto-highlight-symbol-mode-map (kbd "C-x C-^") 'ahs-change-range)


;; C-x C-aでハイライト中のシンボルを一括変更
;; C-x C-^でハイライトする範囲を変える
;; M--で最初のカーソル位置のシンボルへ移動
;; M-<left> 前のシンボルへ移動
;; M-<right> 次のシンボルへ移動


;; auto-intall.el-------------------------------

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install")
;; 以下がエラーの根源
;; (auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)             ; 互換性確保

(setq auto-install-use-wget nil)




;; c-eldoc.el ----------------------------
(load "c-eldoc")
;; (setq c-eldoc-includes "-I./ -I../ -I~/Dropbox/Programming/lib/myLibrary/include/ ")
;; (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (set (make-local-variable 'eldoc-idle-delay) 0.20)
	    (c-turn-on-eldoc-mode)))

;; nurumacs.el ---------------------------
;; (require 'nurumacs)

;; golden-ratio-------------------
;; (require 'golden-ratio)

;; (golden-ratio-enable)

;; rotate.el ------------------------------
;; (require 'rotate)
;; (global-set-key (kbd "C-T") 'rotate-layout)
;; (global-set-key (kbd "M-T") 'rotate-window)

;; Dash.appとの連携-------------------------
(defun dash ()
  (interactive)
  (shell-command
   (format "open dash://%s"
           (or (thing-at-point 'symbol) ""))))
(global-set-key "\C-cr" 'dash)

;; emacs-zoom-window----------------------
(require 'zoom-window)
(global-set-key (kbd "C-x C-z") 'zoom-window-zoom)
(setq zoom-window-mode-line-color "DarkGreen")

;; all-ext.el ---------------------------
(require 'all-ext)

;; hiwin.el---------------------------------------
;; (require 'hiwin)
;; (hiwin-mode)


;; helm -------------------------------
(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)
;; (helm-mode 1)

;; evil-------------------------------
;; (require 'evil)
;; (evil-mode 1)
;; (setq evil-default-state 'emacs)

;; sound-wav-------------------------
(require 'sound-wav)
;; Play wav file when file opened
(defun my/find-file-hook ()
  (sound-wav-play "~/.emacs.d/Achievement.mp3"))
(add-hook 'find-file-hook 'my/find-file-hook)

;; (defun my/before-save-hook ()
;;   (sound-wav-play "~/.emacs.d/Achievement.mp3"))
;; (add-hook 'before-save-hook 'my/before-save-hook)

;; free-keys---------------------
;; (require 'free-keys)

;; swap-buffer------------------
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
(global-set-key "\C-qs" 'swap-screen)
(global-set-key "\C-qS" 'swap-screen-with-cursor)

;; ------------------------------------
;; 自作のpurgeする関数
(defun purge ()
  (interactive)
  (message "purging...")
  (shell-command
   (format "purge"))
  (message "Finished."))
(global-set-key "\C-q\C-p" 'purge)

;; 自作のhoge_compile.shする関数
(defun hoge-compile ()
  (interactive)
  (message "hoge compiling...")
  (shell-command
   (format "~/.emacs.d/hoge_compile.sh"))
  (message "making etags...")
  (shell-command
   (format "~/Dropbox/Programming/lib/myLibrary/maketags.sh"))
  (message "Finished."))
(global-set-key "\C-q\C-c" 'hoge-compile)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(abbrev-mode t t)
 '(blink-cursor-mode nil)
 '(display-time-mode t)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 )
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(default ((t (:stipple nil :background "AliceBlue" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :weight normal :height 120 :width normal :family "apple-monaco")))))

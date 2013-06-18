;; Last Updated: <2013/06/18 21:04:17 from Yoshitos-iMac.local by yoshito>


; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;; ------------------------------------------------------------------------
;; @ load-path

;; load environment value
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))


;; より下に記述した物が PATH の先頭に追加されます



;; (dolist (dir (list
;;               ;; "/Applications/UpTex.app/teTeX/bin"
;;               "/Users/yoshito/Dropbox/ochiailab/tex/"
;;               "/opt/local/bin"
;;               "/usr/local/share/emacs/site-lisp/"
;;               "/Users/yoshito/MyProgram"
;; 	      ;; "/Users/yoshitowatanabe/bin"
;; 	      ;; "/Users/yoshitowatanabe/script"
;; 	      "/usr/bin"
;; 	      "/bin"
;; 	      "/usr/sbin"
;; 	      "/sbin"
;; 	      "/usr/local/bin"
;; 	      "/opt/X11/bin"
;;               (expand-file-name "~/bin")
;;               (expand-file-name "~/.emacs.d/bin")
;;               ))
;;  ;; PATH と exec-path に同じ物を追加します
;;  (when (and (file-exists-p dir) (not (member dir exec-path)))
;;    (setenv "PATH" (concat dir ":" (getenv "PATH")))
;;    (setq exec-path (append (list dir) exec-path))))

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
(add-to-load-path "elisp" "auto-install" "plugins/yasnippet" "elisp/nyan-mode"
                  "elisp/company" "elisp/emacs-clang-complete-async"
                  "elisp/Highlight-Indentation-for-Emacs" "elisp/lilypond" "el-get" "el-get/el-get")

(eval-when-compile
  (require 'cl))

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

;; el-get -----------------------------------------------------

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))


(setq el-get-sources
      '(
        (:name golden-ratio
               :type git
               :url "https://github.com/roman/golden-ratio.el.git")
        (:name yasnippet
               :type git
               :url "https://github.com/emacsmirror/yasnippet.git")))

;; (el-get 'wait '(golden-ratio yasnippet))

(el-get 'sync)

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
(global-set-key "\C-z" 'undo)
;; (global-set-key "\C-c\C-c" 'comment-region)
;; (global-set-key "\C-cc" 'uncomment-region)
;; (global-set-key "\C-j" 'dabbrev-expand)
;; (global-set-key "\C-q" 'query-replace)
;; (global-set-key "\C-x\C-q" 'kill-this-buffer)
(global-set-key "\C-xe" 'electric-buffer-list)
;; (global-set-key "\C-j" 'newline-and-indent)

;; original
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

(defun my-count-lines-window ()
  "Count lines relative to the selected window. The number of lines begins 0."
  (interactive)
  (let* ((window-string (buffer-substring-no-properties (window-start) (point)))
         (line-string-list (split-string window-string "\n"))
         (line-count 0)
         line-count-list)
    (setq line-count (1- (length line-string-list)))
    (unless truncate-lines      ; consider folding back
      ;; `line-count-list' is list of the number of physical lines which each logical line has.
      (setq line-count-list (mapcar '(lambda (str)
                                       (/ (my-count-string-columns str) (window-width)))
                                    line-string-list))
      (setq line-count (+ line-count (apply '+ line-count-list))))
    line-count))

(defun my-count-string-columns (str)
  "Count columns of string. The number of column begins 0."
  (with-temp-buffer
    (insert str)
    (current-column)))

(defadvice scroll-up (around scroll-up-relative activate)
  "Scroll up relatively without move of cursor."
  (let ((line (my-count-lines-window)))
    ad-do-it
    (move-to-window-line line)))

(defadvice scroll-down (around scroll-down-relative activate)
  "Scroll down relatively without move of cursor."
  (let ((line (my-count-lines-window)))
    ad-do-it
    (move-to-window-line line)))

;;mac風のコピペ
;; (global-set-key "\M-c" 'kill-ring-save)
;; (global-set-key "\M-v" 'yank)
;; ;(global-set-key "\M-x" 'kill-region);コマンド呼び出しとダブるので、Cmd-xはあきらめる
;; (global-set-key "\M-z" 'undo)

;; (global-set-key "\M-l" 'ns-toggle-fullscreen)



;(global-set-key [C-backspace] 'backward-kill-word)
(global-set-key [end] 'end-of-buffer)
(global-set-key [home] 'beginning-of-buffer)

;; マークがアクティブでないときは1行コピーとカット
(defadvice copy-region-as-kill (around slick-copy activate)
  "When called interactively with no active region, copy a single line instead."
  (if (or (use-region-p) (not (called-interactively-p)))
      ad-do-it
    (kill-new (buffer-substring (line-beginning-position)
				(line-beginning-position 2))
	      nil '(yank-line))
    (message "Copied line")))
(defadvice kill-region (around slick-copy activate)
  "When called interactively with no active region, kill a single line instead."
  (if (or (use-region-p) (not (called-interactively-p)))
      ad-do-it
    (kill-new (filter-buffer-substring (line-beginning-position)
				       (line-beginning-position 2) t)
	      nil '(yank-line))))
(defun yank-line (string)
  "Insert STRING above the current line."
  (save-excursion
    (beginning-of-line)
    (unless (= (elt string (1- (length string))) ?\n)
      (save-excursion (insert "\n")))
    (insert string)))


;;追加ライブラリとそのキーバインド---------------------------------------

;一行コピー
;; (load-library "copy-line")
;; (global-set-key "\C-o" 'copy-line)

;touch
(load-library "touch")

;redo
(require 'redo)
(global-set-key "\C-_" 'redo)

;画面左に行番号表示
(require 'linum)
(require 'hlinum)
(global-linum-mode)
(custom-set-faces
 '(linum-highlight-face ((t (:foreground "black"
                                         :background "SkyBlue3")
                            ))))

(load-library "fold-dwim")
;ダブルクリックで，折りたたみtoggleを発動
(global-set-key [(double-mouse-1)] 'fold-dwim-toggle)
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
         )
       auto-insert-alist))

;; 辞書をaspellに変更
(setq-default ispell-program-name "aspell")
	      
;; 辞書(sdic)--------------------------------------
;;; sdic-mode 用の設定
(setq load-path (cons "/usr/local/share/emacs/site-lisp" load-path))
(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)

(defun temp-cancel-read-only (function &optional jaspace-off)
  "eval temporarily cancel buffer-read-only
&optional t is turn of jaspace-mode"
  (let ((read-only-p nil)
        (jaspace-mode-p nil))
    (when (and jaspace-off jaspace-mode)
      (jaspace-mode)
      (setq jaspace-mode-p t))
    (when buffer-read-only
      (toggle-read-only)
      (setq read-only-p t))
    (eval function)
    (when read-only-p
      (toggle-read-only))
    (when jaspace-mode-p
      (jaspace-mode))))

(defun my-sdic-describe-word-with-popup (word &optional search-function)
  "Display the meaning of word."
  (interactive
   (let ((f (if current-prefix-arg (sdic-select-search-function)))
         (w (sdic-read-from-minibuffer)))
     (list w f)))
  (let ((old-buf (current-buffer))
        (dict-data))
    (set-buffer (get-buffer-create sdic-buffer-name))
    (or (string= mode-name sdic-mode-name) (sdic-mode))
    (erase-buffer)
    (let ((case-fold-search t)
          (sdic-buffer-start-point (point-min)))
      (if (prog1 (funcall (or search-function
                              (if (string-match "\\cj" word)
                                  'sdic-search-waei-dictionary
                                'sdic-search-eiwa-dictionary))
                          word)
            (set-buffer-modified-p nil)
            (setq dict-data (buffer-string))
            (set-buffer old-buf))
          (temp-cancel-read-only
           '(popup-tip dict-data :scroll-bar t :truncate nil))
        (message "Can't find word, \"%s\"." word))))
    )

(defadvice sdic-describe-word-at-point (around sdic-popup-advice activate)
  (letf (((symbol-function 'sdic-describe-word) (symbol-function 'my-sdic-describe-word-with-popup)))
    ad-do-it))

;; C-cpでツールチップに表示
(global-set-key "\C-c \C-p" 'sdic-describe-word-at-point)

;; ;;色 ----------
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     ;; (color-theme-clarity)
     (color-theme-hober)
     ))

 (setq default-frame-alist
      (append
       '((top . 0) (left . 0) (width . 131 ) (height . 73)) ;; ウィンドウサイズ 
       default-frame-alist))

;; ウィンドウサイズの確認手順
;; scratchバッファで
;; (frame-width) C-j
;; (frame-height) C-j


;; ターミナル関連---------------------------------
;; Find available shell
(defun skt:shell ()
  (or (executable-find "zsh")
      (executable-find "bash") ;; zshユーザは一行下と入れ替え
      ;; (executable-find "f_zsh") ;; Emacs + Cygwin を利用する人は Zsh の代りにこれにしてください
      ;; (executable-find "f_bash") ;; Emacs + Cygwin を利用する人は Bash の代りにこれにしてください
      (error "No shell program was found in your PATH...")))
 
;; Set shell-name
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)
 
(setq system-uses-terminfo nil)

;; ;; 残さない
(setq make-backup-files nil)

;;モード毎の設定-----------------------------------------------------

;;.hファイルをC++モードで開く。.shファイルが.hと見なされてしまうので、設定し直す
(setq auto-mode-alist
      (cons (cons ".\.h$" 'c++-mode) auto-mode-alist))

(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

(setq auto-mode-alist
      (cons (cons ".sh$" 'shell-script-mode) auto-mode-alist))


;; dummy-h-mode.el -----------
;; (add-to-list 'auto-mode-alist '("\\.h$" . dummy-h-mode))
;; (autoload 'dummy-h-mode "dummy-h-mode" "Dummy H mode" t)
;; (add-hook 'dummy-h-mode-hook
;;           (lambda ()
;;             (setq dummy-h-mode-default-major-mode 'c++-mode)))



;;CSSモード
(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css$" . css-mode) auto-mode-alist))

;; Tex-------------------------------------
;; \C-c\C-fでplatex
;; (setq latex-run-command "platex")
;; \C-c\C-vでxdvi
;; (setq tex-dvi-view-command "xdvi")
;; \C-c\C-iでbibtex

(require 'tex-site)
(setq TeX-default-mode 'japanese-latex-mode)
;; (add-hook 'TeX-mode-hook
;;           (function (lambda ()
;;                       (setq TeX-command-default "pLaTeX")
;;                       (setq LaTeX-command-default "pLaTeX")
;;                       (setq japanese-TeX-command-default "pTeX")
;;                       (setq japanese-LaTeX-command-default "pLaTeX")
;;                       )))
(setq japanese-LaTeX-default-style "jarticle")
(setq TeX-output-view-style '(("^dvi$" "." "xdvi '%d'")))
(setq preview-image-type 'dvipng)
(add-hook 'LaTeX-mode-hook (function (lambda ()
  (add-to-list 'TeX-command-list
    '("pTeX" "%(PDF)ptex %`%S%(PDFout)%(mode)%' %t"
     TeX-run-TeX nil (plain-tex-mode) :help "Run ASCII pTeX"))
  (add-to-list 'TeX-command-list
    '("pLaTeX" "%(PDF)platex %`%S%(PDFout)%(mode)%' %t"
     TeX-run-TeX nil (latex-mode) :help "Run ASCII pLaTeX"))
  (add-to-list 'TeX-command-list
    '("acroread" "acroread '%s.pdf' " TeX-run-command t nil))
  (add-to-list 'TeX-command-list
    '("pdf" "dvipdfmx -V 4 '%s' " TeX-run-command t nil))
)))
;; (setq japanese-LaTeX-command-default "pLaTeX")
(setq japanese-TeX-command-default "pLaTeX")
(setq TeX-command-default "pLaTeX")
;; (setq LaTeX-command-default "pLaTeX")


(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)


;; (add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook
          '(lambda ()
               (setq enable-local-variables t)))
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; 上でYaTeXに譲り渡したRefTeXのコマンドを定義し直す 
;;;;; labelの参照のコマンドを"C-c )"から"C-h )"に変更(暫定的)
(add-hook 'reftex-mode-hook
 '(lambda ()
               (define-key reftex-mode-map (kbd "\C-cr") 'reftex-reference)
               (define-key reftex-mode-map (kbd "\C-cl") 'reftex-label)
               (define-key reftex-mode-map (kbd "\C-cc") 'reftex-citation)
))


;; 数式のラベル作成時にも自分でラベルを入力できるようにする
(setq reftex-insert-label-flags '("s" "sfte"))

;; \eqrefを使う
(setq reftex-label-alist
      '(
        (nil ?e nil "\\eqref{%s}" nil nil)
        ))

; RefTeXで使用するbibファイルの位置を指定する
(setq reftex-default-bibliography '("~/Dropbox/ochiailab/tex/biblio.bib"
                                    "~/Dropbox/ochiailab/tex/IEEEabrv.bib"
                                    "~/Dropbox/ochiailab/tex/library.bib"
                                    ))


;; Add tex packages path
(setenv "TEXINPUTS"
	(concat ".:" (getenv "HOME")
                ":/Users/yoshito/Dropbox/ochiailab/tex/:"
		(getenv "TEXINPUTS")))

;; Add bibtex reference files path
(setenv "BIBINPUTS"
	(concat ".:" (getenv "HOME")
                ":/Users/yoshito/Dropbox/ochiailab/tex/:"
		(getenv "BIBINPUTS")))


;; Add bst reference files path
(setenv "BSTINPUTS"
	(concat ".:" (getenv "HOME")
                ":/Users/yoshito/Dropbox/ochiailab/tex/:"
		(getenv "BSTINPUTS")))

;; Abbrev mode and auctex
 ;; (define-abbrev-table 'TeX-mode-abbrev-table (make-abbrev-table))
 ;;   (add-hook 'TeX-mode-hook (lambda ()
 ;;      (setq abbrev-mode t)
 ;;      (setq local-abbrev-table TeX-mode-abbrev-table)))

;; (add-hook
;;  'yatex-mode-hook
;;  (function
;;   (lambda ()
;;     (setq outline-regexp
;;           (concat "[ \t]*\\\\\\(documentstyle\\|documentclass\\|"
;;                   "chapter\\|section\\|subsection\\|subsubsection\\)"
;;                   "\\*?[ \t]*[[{]")))))
;RefTexをつかうため
;; (add-hook 'yatex-mode-hook '(lambda () (reftex-mode t)))

;;texに対しては，hs-minor-modeがうまく動かないので，outlineモードをつかう
;; (add-hook 'yatex-mode-hook
;;           '(lambda () (outline-minor-mode t)))


;; プログラミング言語関連 -------------------------------------

;; imenuを自動リスキャン
(setq imenu-auto-rescan t)

;; includeフォルダにパスを通す
(setenv "C_INCLUDE_PATH"
        (concat (getenv "C_INCLUDE_PATH")
        ":./:/Users/yoshito/MyLib/include/"))

(setenv "CPLUS_INCLUDE_PATH"
        (concat (getenv "CPLUS_INCLUDE_PATH")
        ":./:/Users/yoshito/MyLib/include/"))

;java, C, C++モードでhs-minor-modeを自動的にＯＮにします
;cモードのc++, javaの元になるフックだけにいれておけばＯＫ
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;章や節の定義
(make-variable-buffer-local 'outline-regexp)

;; c++モードで前の文字までの空欄を全削除するモードと、セミコロンで自動改行するモード
(add-hook 'c-mode-common-hook
          '(lambda()
             (c-toggle-auto-hungry-state))) ;gtagsの補完

(global-set-key "\C-c\C-t" 'c-toggle-auto-hungry-state)
;; (global-set-key "\C-c\C-d" 'c-toggle-hungry-state)
(global-set-key "\C-c\C-a" 'c-toggle-auto-newline)


;; etagsの参照tag
(setq tags-table-list
      '("~/Dropbox/Programming/lib/myLibrary"))

;; gtags
(require 'gtags)

(add-hook 'c-mode-common-hook
          '(lambda()
             (gtags-mode 1)             ;gtags-mode
             (gtags-make-complete-list))) ;gtagsの補完

;; C++で大文字を単語の一区切りにする
(add-hook 'c++-mode-hook
          '(lambda ()
             (define-key c++-mode-map "\M-f"
               'c-forward-into-nomenclature)
             (define-key c++-mode-map "\M-b"
               'c-backward-into-nomenclature)))

(setq gtags-mode-hook
      '(lambda()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)))

;; --- Obj-C switch between header and source ---

(defun objc-in-header-file ()
  (let* ((filename (buffer-file-name))
         (extension (car (last (split-string filename "\\.")))))
    (string= "h" extension)))

(defun objc-jump-to-extension (extension)
  (let* ((filename (buffer-file-name))
         (file-components (append (butlast (split-string filename
                                                         "\\."))
                                  (list extension))))
    (find-file (mapconcat 'identity file-components "."))))

;;; Assumes that Header and Source file are in same directory
(defun objc-jump-between-header-source ()
  (interactive)
  (if (objc-in-header-file)
      (objc-jump-to-extension "m")
    (objc-jump-to-extension "h")))

(defun objc-mode-customizations ()
  (define-key objc-mode-map (kbd "C-c t") 'objc-jump-between-header-source))

(add-hook 'objc-mode-hook 'objc-mode-customizations)


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


;; org-mode--------------
(require 'org-install)
(setq org-startup-truncated nil)
(setq org-return-follows-link t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (org-remember-insinuate)
(setq org-directory "~/Dropbox/memo/")
(setq org-default-notes-file (concat org-directory "agenda.org"))
(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline nil "Inbox")
         "** TODO %?\n   %i\n   %a\n   %t")
        ("b" "Bug" entry
         (file+headline nil "Inbox")
         "** TODO %?   :bug:\n   %i\n   %a\n   %t")
        ("i" "Idea" entry
         (file+headline nil "New Ideas")
         "** %?\n   %i\n   %a\n   %t")))

(setq org-agenda-files (list org-directory)) ;agendaを使うため
;; ショートカットキー
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook 'turn-on-font-lock)

;; ;; remember.el-------------
;; (require 'remember)
;; (setq remember-annotation-functions '(org-remember-annotation))
;; (setq remember-handler-functions '(org-remember-handler))
;; (add-hook 'remember-mode-hook 'org-remember-apply-template)


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
;; C-x uで起動

;; point-undo.el--------------------------------------------------
(when (require 'point-undo nil t)
  (define-key global-map [f6] 'point-undo)
  (define-key global-map [f7] 'point-redo))

;; ------------------------------------------------------------------------
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

;; エラーをミニバッファの表示する
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

;; (defadvice flymake-goto-next-error (after display-message activate compile)
;;   "次のエラーへ進む"
;;   (flymake-display-err-minibuffer))

;; (defadvice flymake-goto-prev-error (after display-message activate compile)
;;   "前のエラーへ戻る"
;;   (flymake-display-err-minibuffer))

;; (defadvice flymake-mode (before post-command-stuff activate compile)
;;   "エラー行にカーソルが当ったら自動的にエラーが minibuffer に表示されるように
;; post command hook に機能追加"
;;   (set (make-local-variable 'post-command-hook)
;;        (add-hook 'post-command-hook 'flymake-display-err-minibuffer)))

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
(add-to-list 'flymake-allowed-file-name-masks
             '("\\.tex$" flymake-tex-init flymake-tex-cleanup-custom
               ))

;; (add-hook 'LaTeX-mode-hook
;;           (lambda()
;;             (push '("\\.tex$" flymake-tex-init flymake-tex-cleanup-custom) flymake-allowed-file-name-masks)))
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
(defvar xcode:gccver "4.0")
(defvar xcode:sdkver "6.1")
(defvar xcode:sdkpath "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/")
(defvar xcode:sdk (concat xcode:sdkpath "SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))
;; (defvar flymake-objc-compiler (concat xcode:sdkpath "/usr/bin/gcc-" xcode:gccver))
(defvar flymake-objc-compiler (executable-find "clang"))
;; (defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" xcode:sdk))
(defvar flymake-objc-compile-default-options (list "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200" "-fsyntax-only" "-fno-color-diagnostics" "-fobjc-arc" "-fblocks" "-Wreturn-type" "-Wparentheses" "-Wswitch" "-Wno-unused-parameter" "-Wunused-variable" "-Wunused-value" "-isysroot" xcode:sdk))
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

(set-face-background 'flymake-errline "red3")
(set-face-background 'flymake-warnline "dimgray")


;; tabbar.el------------------------------------------

(require 'tabbar)
(tabbar-mode 1)
;; scratch buffer 以外をまとめてタブに表示する
(setq tabbar-buffer-groups-function
      (lambda (b) (list "All Buffers")))
(setq tabbar-buffer-list-function
      (lambda ()
        (remove-if
         (lambda(buffer)
           (find (aref (buffer-name buffer) 0) " *"))
         (buffer-list))))
(tabbar-mode)

;; M-[で前のタブに移動, M-]で次のタブ
(global-set-key "\M-]" 'tabbar-forward)
(global-set-key "\M-[" 'tabbar-backward)

;; タブ上でマウスホイール無効化
(tabbar-mwheel-mode -1)

;; グループ化しない
(setq tabbar-buffer-groups-function nil)

;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

;; ウインドウからはみ出たタブを省略して表示
(setq tabbar-auto-scroll-flag nil)
 
;; タブとタブの間の長さ
(setq tabbar-separator '(0.5))

;; 外観変更
(set-face-attribute
 'tabbar-default nil
 :family "Comic Sans MS"
 :background "midnight blue"
 :foreground "gray72"
 :height 1.0)
(set-face-attribute
 'tabbar-unselected nil
 :background "midnight blue"
 :foreground "#c82829"
 :box '(:line-width 2 :color "midnight blue" :style released-button))
(set-face-attribute
 'tabbar-selected nil
 :background "white"
 :foreground "#c82829"
 :box '(:line-width 2 :color "white" :style pressed-button))
(set-face-attribute
 'tabbar-button nil
 :box nil)
 (set-face-attribute
  'tabbar-separator nil
  :height 1.2)

;; M-4 で タブ表示、非表示
(global-set-key "\M-4" 'tabbar-mode)

;; GUIで直接ファイルを開いた場合フレームを作成しない
(add-hook 'before-make-frame-hook
          (lambda ()
            (when (eq tabbar-mode t)
              (switch-to-buffer (buffer-name))
              (delete-this-frame))))

;; yasnippet.el----------------------------------
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mySnippets"         ; original
        "~/.emacs.d/plugins/yasnippet/snippets"
        ))
(yas-global-mode 1)

;; 既存スニペットを挿入
(define-key yas-minor-mode-map (kbd "C-x y i") 'yas-insert-snippet)
;; 新規スニペットを作成するバッファを用意する
(define-key yas-minor-mode-map (kbd "C-x y n") 'yas-new-snippet)
;; 既存スニペットの閲覧、編集
(define-key yas-minor-mode-map (kbd "C-x y v") 'yas-visit-snippet-file)

;; anything interface
(eval-after-load "anything-config"
  '(progn
     (defun my-yas-prompt (prompt choices &optional display-fn)
       (let* ((names (loop for choice in choices
                           collect (or (and display-fn (funcall display-fn choice))
                                       choice)))
              (selected (anything-other-buffer
                         `(((name . ,(format "%s" prompt))
                            (candidates . names)
                            (action . (("Insert snippet" . (lambda (arg) arg))))))
                         "*anything yas-prompt*")))
         (if selected
             (let ((n (position selected names :test 'equal)))
               (nth n choices))
           (signal 'quit "user quit!"))))
     (custom-set-variables '(yas-prompt-functions '(my-yas-prompt)))
     (define-key anything-command-map (kbd "y") 'yas-insert-snippet)))

;; snippet-mode for *.yasnippet files
(add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode))


;; yasnippet展開中はflymakeを無効にする
(defvar flymake-is-active-flag nil)

(defadvice yas-expand-snippet
  (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
  (setq flymake-is-active-flag
        (or flymake-is-active-flag
            (assoc-default 'flymake-mode (buffer-local-variables))))
  (when flymake-is-active-flag
    (flymake-mode-off)))

(add-hook 'yas-after-exit-snippet-hook
          '(lambda ()
             (when flymake-is-active-flag
               (flymake-mode-on)
               (setq flymake-is-active-flag nil))))

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

;; smartrep.el-------------------------------
(require 'smartrep)

;; \C-qをプレフィックスキーに設定
(defvar ctl-q-map (make-keymap))
(define-key global-map "\C-q" ctl-q-map) 

(smartrep-define-key 
    global-map "C-q" '(("n" . (lambda () (scroll-other-window 1)))
                       ("p" . (lambda () (scroll-other-window -1)))
                       ("N" . 'scroll-other-window)
                       ("P" . (lambda () (scroll-other-window '-)))
                       ("a" . (lambda () (beginning-of-buffer-other-window 0)))
                       ("e" . (lambda () (end-of-buffer-other-window 0)))))

(smartrep-define-key
    global-map "C-x"'(("o" . 'other-window)
                      ("^" . 'enlarge-window)
                      ("_" . 'shrink-window)
                      ("}" . 'enlarge-window-horizontally)
                      ("{" . 'shrink-window-horizontally)
                      ("M-]" . 'tabbar-forward)
                      ("M-[" . 'tabbar-backward)))

;; anything.el--------------------------------------
;; auto-installの前に置かなければいけない

(require 'anything-startup)

(define-key anything-map (kbd "C-p") 'anything-previous-line)
(define-key anything-map (kbd "C-n") 'anything-next-line)
(define-key anything-map (kbd "C-v") 'anything-next-source)
(define-key anything-map (kbd "M-v") 'anything-previous-source)
(global-set-key (kbd "C-;") 'anything)

(require 'cl)  ; loop, delete-duplicates

;; anything-font-families
(defun anything-font-families ()
  "Preconfigured `anything' for font family."
  (interactive)
  (flet ((anything-mp-highlight-match () nil))
    (anything-other-buffer
     '(anything-c-source-font-families)
     "*anything font families*")))

(defun anything-font-families-create-buffer ()
  (with-current-buffer
      (get-buffer-create "*Fonts*")
    (loop for family in (sort (delete-duplicates (font-family-list)) 'string<)
          do (insert
              (propertize (concat family "\n")
                          'font-lock-face
                          (list :family family :height 2.0 :weight 'bold))))
    (font-lock-mode 1)))

(defvar anything-c-source-font-families
      '((name . "Fonts")
        (init lambda ()
              (unless (anything-candidate-buffer)
                (save-window-excursion
                  (anything-font-families-create-buffer))
                (anything-candidate-buffer
                 (get-buffer "*Fonts*"))))
        (candidates-in-buffer)
        (get-line . buffer-substring)
        (action
         ("Copy Name" lambda
          (candidate)
          (kill-new candidate))
         ("Insert Name" lambda
          (candidate)
          (with-current-buffer anything-current-buffer
            (insert candidate))))))

(defvar anything-c-source-objc-headline
  '((name . "Objective-C Headline")
    (headline  "^[-+@]\\|^#pragma mark")))

(defun objc-headline ()
  (interactive)
  ;; Set to 500 so it is displayed even if all methods are not narrowed down.
  (let ((anything-candidate-number-limit 500))
    (anything-other-buffer '(anything-c-source-objc-headline)
                           "*ObjC Headline*")))

(global-set-key "\C-xp" 'objc-headline)


;; auto-intall.el-------------------------------

(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install")
;; 以下がエラーの根源
;; (auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)             ; 互換性確保

(setq auto-install-use-wget nil)

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
(define-key ac-mode-map  (kbd "M-_") 'auto-complete)
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
  ;;  (add-hook 'python-mode-hook 'ac-python-mode-setup)
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
            (setq ac-clang-prefix-header "~/.emacs.d/fuga.pch")
            (setq ac-etags-use-document t)))


(add-hook 'c++-mode-hook
          (lambda()
            (setq ac-sources (append '(ac-source-clang
                                       ac-source-etags) ac-sources))
            (setq ac-clang-prefix-header "~/.emacs.d/hoge.pch")
            (setq ac-etags-use-document t)))

(add-hook 'python-mode-hook
          (lambda()
            (setq ac-sources (append '(ac-source-yasnippet)) ac-sources)))

;; Objective-C用の設定 -----------------------
; ac-company で company-xcode を有効にする
(ac-company-define-source ac-source-company-xcode company-xcode)
;; objc-mode で補完候補を設定
(setq ac-modes (append ac-modes '(objc-mode)))

;; hook
(add-hook 'objc-mode-hook
          (lambda ()
            ;; (setq ac-clang-flags (list "-D__IPHONE_OS_VERSION_MIN_REQUIRED=30200" "-x" "objective-c" "-std=gnu99" "-isysroot" xcode:sdk "-I." "-F.." "-fblocks" ))
            ;; (setq ac-clang-flags (append
            ;;                       flymake-objc-compile-default-options
            ;;                       flymake-objc-compile-options))
            (setq ac-sources (append '(ac-source-company-xcode ;; XCode を利用した補完を有効にする
                                       ;; ac-source-clang
                                       ) ac-sources))
            ))

;;; yasnippetのbindingを指定するとエラーが出るので回避する方法。
;; (setf (symbol-function 'yas-active-keys)
;;       (lambda ()
;;         (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))



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
(require 'rotate)
(global-set-key (kbd "C-T") 'rotate-layout)
(global-set-key (kbd "M-T") 'rotate-window)

;; Dash.appとの連携-------------------------
(defun dash ()
  (interactive)
  (shell-command
   (format "open dash://%s"
           (or (thing-at-point 'symbol) ""))))
(global-set-key "\C-cr" 'dash)


;; all-ext.el ---------------------------
(require 'all-ext)

;; hiwin.el---------------------------------------
;; (require 'hiwin)
;; (hiwin-mode)

;; powerline.el ---------------------------------
;; (require 'powerline)

;; based from: http://amitp.blogspot.jp/2011/08/emacs-custom-mode-line.html
;; Mode line setup
(setq-default
 mode-line-position
 '(
   " "
   ;; Position, including warning for 80 columns
   (:propertize "%4l" face mode-line-position-face)
   (:propertize "/" face mode-line-delim-face-1)
   (:eval
    (number-to-string (count-lines (point-min) (point-max))))
   " "
   (:eval (propertize "%3c" 'face
                      (if (>= (current-column) 80)
                          'mode-line-80col-face
                        'mode-line-position-face)))
   " "
   ))

(setq-default
 mode-line-format
 '("%e"
   mode-line-mule-info
   ;; emacsclient [default -- keep?]
   mode-line-client
   mode-line-remote
   ;evil-mode-line-tag
   mode-line-position
   ; read-only or modified status
   (:eval
    (cond (buffer-read-only
           (propertize " RO " 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize " ** " 'face 'mode-line-modified-face))
          (t " ")))
   " "
   ;; directory and buffer/file name
   (:propertize (:eval (shorten-directory default-directory 30))
                face mode-line-folder-face)
   (:propertize "%b" face mode-line-filename-face)
   ;; narrow [default -- keep?]
   " %n"
   ;; mode indicators: vc, recursive edit, major mode, minor modes, process, global
   (vc-mode vc-mode)
   " %["
   (:propertize mode-name
                face mode-line-mode-face)
   "%]"
   (:eval (propertize (format-mode-line minor-mode-alist)
                      'face 'mode-line-minor-mode-face))
   " "
   (:propertize mode-line-process
                face mode-line-process-face)
   " "
   (global-mode-string global-mode-string)
   ;; " "
   ;; nyan-mode uses nyan cat as an alternative to %p
   ;; (:eval (when nyan-mode (list (nyan-create))))
   ))


;; Helper function
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))



(set-face-attribute 'mode-line nil
    :foreground "gray80" :background "gray10"
    :inverse-video nil
    :weight 'normal
    :height 120
    :box '(:line-width 2 :color "gray10" :style nil))
(set-face-attribute 'mode-line-inactive nil
    :foreground "gray80" :background "gray30"
    :inverse-video nil
    :weight 'extra-light
    :height 120
    :box '(:line-width 2 :color "gray30" :style nil))


;; extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)
(make-face 'mode-line-delim-face-1)

(set-face-attribute 'mode-line-read-only-face nil
    :inherit 'mode-line-face
    :foreground "#4271ae"
    :box '(:line-width 2 :color "#4271ae"))
(set-face-attribute 'mode-line-modified-face nil
    :inherit 'mode-line-face
    :foreground "#c82829"
    :background "#ffffff"
    :box '(:line-width 2 :color "#c82829"))
(set-face-attribute 'mode-line-folder-face nil
    :inherit 'mode-line-face
    :weight 'extra-light
    :height 110
    :foreground "gray90")
(set-face-attribute 'mode-line-filename-face nil
    :inherit 'mode-line-face
    :foreground "#eab700"
    :weight 'bold)
(set-face-attribute 'mode-line-position-face nil
    :inherit 'mode-line-face
    :family "Menlo")
(set-face-attribute 'mode-line-mode-face nil
    :inherit 'mode-line-face
    :foreground "red")
(set-face-attribute 'mode-line-minor-mode-face nil
    :inherit 'mode-line-mode-face
    :foreground "gray60"
    :height 100)
(set-face-attribute 'mode-line-process-face nil
    :inherit 'mode-line-face
    :foreground "#718c00")
(set-face-attribute 'mode-line-80col-face nil
    :inherit 'mode-line-position-face
    :foreground "black" :background "#eab700")
(set-face-attribute 'mode-line-delim-face-1 nil
    :inherit 'mode-line-face
    :foreground "white")



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

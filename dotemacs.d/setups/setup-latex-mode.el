;;; setup-latex-mode.el --- setup of LaTeX-mode

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords: tex,

;; Tex-------------------------------------
;; \C-c\C-fでplatex
;; (setq latex-run-command "platex")
;; \C-c\C-vでxdvi
;; (setq tex-dvi-view-command "xdvi")
;; \C-c\C-iでbibtex

(require 'tex-jp)
;; (setq TeX-default-mode 'japanese-latex-mode)

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
  (add-to-list 'TeX-command-list
    '("pp" "~/.files/platexpdf/platexpdf %t" TeX-run-command t nil))
  (add-to-list 'TeX-command-list
    '("open" "open '%s.pdf' " TeX-run-command t nil))
)))

(setq japanese-TeX-command-default "pLaTeX")
(setq TeX-command-default "pLaTeX")


(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

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
(setq reftex-default-bibliography '(;; "~/Dropbox/ochiailab/tex/IEEEabrv.bib"
                                    "~/Dropbox/ochiailab/tex/library.bib"
                                    ;; "~/Dropbox/ochiailab/tex/biblio.bib"
                                    ))



;; ;; Add tex packages path
;; (setenv "TEXINPUTS"
;; 	(concat ".:" (getenv "HOME")
;;                 ":/Users/yoshito/Dropbox/ochiailab/tex/:"
;; 		(getenv "TEXINPUTS")))

;; ;; Add bibtex reference files path
;; (setenv "BIBINPUTS"
;; 	(concat ".:" (getenv "HOME")
;;                 ":/Users/yoshito/Dropbox/ochiailab/tex/:"
;; 		(getenv "BIBINPUTS")))


;; ;; Add bst reference files path
;; (setenv "BSTINPUTS"
;; 	(concat ".:" (getenv "HOME")
;;                 ":/Users/yoshito/Dropbox/ochiailab/tex/:"
;; 		(getenv "BSTINPUTS")))

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

(latex-preview-pane-enable)


(provide 'setup-latex-mode)

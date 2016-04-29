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
(server-force-delete)
(server-start); start emacs in server mode so that skim can talk to it


(setq japanese-LaTeX-default-style "jarticle")
(setq preview-image-type 'dvipng)
(add-hook 'LaTeX-mode-hook (function (lambda ()
  (add-to-list 'TeX-command-list
               '("pTeX" "ptex %`%S%(PDFout)%(mode)%' %t"
                 TeX-run-TeX nil (plain-tex-mode) :help "Run ASCII pTeX"))
  (add-to-list 'TeX-command-list
               '("pLaTeX" "platex %`%S%(PDFout)%(mode)%' %t"
                 TeX-run-TeX nil (latex-mode) :help "Run ASCII pLaTeX"))
  (add-to-list 'TeX-command-list
               '("acroread" "acroread '%s.pdf' " TeX-run-command t nil))
  (add-to-list 'TeX-command-list
               '("pdf" "dvipdfmx -V 4 '%s' " TeX-run-command t nil))
  (add-to-list 'TeX-command-list
               '("pp" "~/.files/platexpdf/platexpdf %t" TeX-run-command t nil))
  (add-to-list 'TeX-command-list
               '("open" "open '%s.pdf' " TeX-run-command t nil))
  ;; Use Skim as viewer, enable source <-> PDF sync
  ;; make latexmk available via C-c C-c
  ;; Note: SyncTeX is setup via ~/.latexmkrc
  (add-to-list 'TeX-command-list
               '("latexmk" "latexmk %s" TeX-run-TeX nil t
                 :help "Run latexmk on file"))
  (add-to-list 'TeX-command-list
               '("Skim" "open -a /Applications/Skim.app '%s.pdf'" TeX-run-command t nil))
  (add-to-list 'TeX-command-list
               '("SkimBG" "open -g -a /Applications/Skim.app '%s.pdf'" TeX-run-command nil t))

)))

(setq japanese-TeX-command-default "latexmk")
(setq TeX-command-default "latexmk")

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background 
(setq TeX-view-program-list
     '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b"))) ;; displayline must be available.
(setq TeX-view-program-selection '((output-pdf "Skim")))

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(setq TeX-auto-save t)                  ; auto directoryを作る
(setq TeX-parse-self t)

;; 複数のtexファイルを使う場合は以下を有効にする
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


;; Abbrev mode and auctex
 ;; (define-abbrev-table 'TeX-mode-abbrev-table (make-abbrev-table))
 ;;   (add-hook 'TeX-mode-hook (lambda ()
 ;;      (setq abbrev-mode t)
 ;;      (setq local-abbrev-table TeX-mode-abbrev-table)))


;; (latex-preview-pane-enable)


(provide 'setup-latex-mode)

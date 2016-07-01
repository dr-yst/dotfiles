;;; setup-orgmode.el --- setup of org-mode

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords: docs, tools,

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
         "** %?\n   %i\n   %a\n   %t")
        ("d" "Diary" entry (file "my-diary.org")
         "* %U%?\n%i\n")))

(setq org-agenda-files (list org-directory)) ;agendaを使うため
;; ショートカットキー
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-co" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook 'turn-on-font-lock)

;; LaTeX article class
(setq org-latex-classes
      '(("IEEEdouble"
         "\\documentclass[11pt,twocolumn,twoside]{IEEEtran}
\\usepackage{newenum}
\\usepackage{times,amsmath,amssymb}
\\usepackage{amsthm}
\\usepackage{cite,subfigure,bm}
\\usepackage{multicol,multirow}
\\usepackage{array}
\\usepackage[dvipdfmx]{graphicx}
\\usepackage[dvipdfmx]{color}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ("IEEEsingle"
         "\\documentclass[11pt,draftcls,onecolumn]{IEEEtran}
\\usepackage{newenum}
\\usepackage{times,amsmath,amssymb}
\\usepackage{amsthm}
\\usepackage{cite,subfigure,bm}
\\usepackage{multicol,multirow}
\\usepackage{array}
\\usepackage[dvipdfmx]{graphicx}
\\usepackage[dvipdfmx]{color}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ("thesis"                       
         "\\documentclass{jsarticle}
\\usepackage[dvipdfmx]{graphicx}
\\usepackage[T1]{fontenc}"
         ("\\chapter{%s}" . "\\chapter*{%s}")
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ("ieice"
         "\\documentclass[a4paper]{ieicejsp2}
\\usepackage{newenum}
\\usepackage{amsmath,amssymb}
\\usepackage[dvipdfmx]{graphicx}
\\usepackage{cite,subfigure,bm,color}
\\usepackage{array}
\\usepackage{epsfig}"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}")
         ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
        ))

(setq org-latex-default-class "IEEEsingle")

;;; LaTeX 形式のファイル PDF に変換するためのコマンド
(setq org-latex-pdf-process
      '("latexmk %f"))

(require 'origami)
(define-key origami-mode-map (kbd "<C-tab>") 'origami-toggle-node)
(define-key origami-mode-map (kbd "C-u <C-tab>") 'origami-toggle-all-nodes)

(add-hook 'c-mode-common-hook 'origami-mode)
(add-hook 'lisp-mode-hook 'origami-mode)

(require 'outline-magic)
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)
(define-key outline-minor-mode-map (kbd "<C-tab>") 'outline-cycle)

;; C-u押してからだとバッファ全体を対象


(setq org-html-validation-link nil)

;; ob-lilypond
(org-babel-do-load-languages
  'org-babel-load-languages
  '(
    (emacs-lisp . t)
    (sh t)
    (org t)
    (lilypond t)))



(provide 'setup-orgmode)

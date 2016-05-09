;;; setup-lilypond.el --- setup of lilypond-mode     -*- lexical-binding: t; -*-

;; Copyright (C) 2015  WatanabeYoshito

;; Author: WatanabeYoshito <yoshito@alcohorhythm.local>
;; Keywords: 

;; Lilypond mode

(require 'lilypond-mode)
;; (autoload 'LilyPond-mode "lilypond-mode")
(add-to-list 'auto-mode-alist '("\\.ly\'" . LilyPond-mode))
(add-hook 'LilyPond-mode-hook 'turn-on-font-lock) 

(add-hook 'LilyPond-mode-hook (function (lambda ()
                                          (add-to-list 'LilyPond-command-alist
                                                       '("OpenPDF" "open '%f'"))
                                          )))


;; (require 'ac-lilypond)


(provide 'setup-lilypond)

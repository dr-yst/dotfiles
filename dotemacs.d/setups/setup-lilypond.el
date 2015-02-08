;;; setup-lilypond.el --- setup of lilypond-mode     -*- lexical-binding: t; -*-

;; Copyright (C) 2015  WatanabeYoshito

;; Author: WatanabeYoshito <yoshito@alcohorhythm.local>
;; Keywords: 

;; Lilypond mode

(require 'lilypond-mode)
;; (autoload 'LilyPond-mode "lilypond-mode")
(setq auto-mode-alist
      (cons '("\\.ly$" . LilyPond-mode) auto-mode-alist))
(add-hook 'LilyPond-mode-hook 'turn-on-font-lock) 

(add-hook 'LilyPond-mode-hook (function (lambda ()
                                          (add-to-list 'LilyPond-command-alist
                                                       '("OpenPDF" "open '%f'"))
                                          )))


(require 'ac-lilypond)
(eval-after-load "LilyPond-mode" (load-library "ac-lilypond"))



(provide 'setup-lilypond)

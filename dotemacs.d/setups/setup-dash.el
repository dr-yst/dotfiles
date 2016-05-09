;;; setup-dash.el --- setup of dash-at-point         -*- lexical-binding: t; -*-

;; Copyright (C) 2016  WatanabeYoshito

;; Author: WatanabeYoshito <yoshito@alcohorhythm.local>
;; Keywords:

;; Dash.appとの連携-------------------------

(autoload 'dash-at-point "dash-at-point"
          "Search the word at point with Dash." t nil)
(global-set-key "\C-cr" 'dash-at-point)
(global-set-key "\C-ce" 'dash-at-point-with-docset)

(provide 'setup-dash)

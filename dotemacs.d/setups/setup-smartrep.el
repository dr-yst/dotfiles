;;; setup-smartrep.el --- setup of smartrep

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@yoshitos-mac-mini.local>
;; Keywords:

;; smartrep.el-------------------------------
(require 'smartrep)

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

(provide 'setup-smartrep)

;;; setup-keybindings.el --- setup of keybindings    -*- lexical-binding: t; -*-

;; Copyright (C) 2016  WatanabeYoshito

;; Author: WatanabeYoshito <yoshito@alcohorhythm.local>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:


;meta keyの変更
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)
(global-set-key "\C-z" 'undo)
(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-j" 'newline-and-indent)

(global-set-key (kbd "C-x C-b") 'bs-show)

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

(global-set-key "\M-n" (lambda () (interactive) (scroll-up 1)))
(global-set-key "\M-p" (lambda () (interactive) (scroll-down 1)))
(global-set-key "\M-N" (lambda () (interactive) (scroll-up 10)))
(global-set-key "\M-P" (lambda () (interactive) (scroll-down 10)))
		
(global-set-key "\C-@" 'ispell-word)
(global-set-key "\M-@" 'ispell-complete-word)

(defun open-line-next-indent ()
  "Open a line and indent the next line."
  (interactive)
  (save-excursion
  (newline)
  (indent-for-tab-command))
  )
(global-set-key "\C-o" 'open-line-next-indent)

;; \C-qをプレフィックスキーに設定
(defvar ctl-q-map (make-keymap))
(define-key global-map "\C-q" ctl-q-map) 

;; M-q の逆
(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unfill-region ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-region (region-beginning) (region-end) nil)))

(global-set-key "\C-\M-q" 'unfill-paragraph)

;(global-set-key [C-backspace] 'backward-kill-word)
(global-set-key [end] 'end-of-buffer)
(global-set-key [home] 'beginning-of-buffer)

(require 'generic-x)


(provide 'setup-keybindings)
;;; setup-keybindings.el ends here

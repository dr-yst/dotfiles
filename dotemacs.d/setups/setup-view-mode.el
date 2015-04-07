;;; setup-view-mode.el --- setup for view-mode       -*- lexical-binding: t; -*-

;; Copyright (C) 2015  WatanabeYoshito

;; Author: WatanabeYoshito <yoshito@WatanabeYoshito-no-iMac.local>
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


(setq view-read-only t)
(defvar pager-keybind
      `( 
        ("h" . backward-char)
        ("l" . forward-char)
        ("j" . next-line)
        ("k" . previous-line)
        (";" . sdic-describe-word)
        ("S-SPC" . scroll-down)
        (" " . scroll-up)
        ("@" . set-mark-command)
        ("a" (lambda () (beginning-of-buffer-other-window 0)))
        ("e" (lambda () (beginning-of-buffer-other-window 0)))
        ("f" . forward-word)
        ("b" . backward-word)
        ("]" . forward-word)
        ("[" . backward-word)
        ("(" . point-undo)
        (")" . point-redo)
        ("n" . ,(lambda () (interactive) (scroll-up 1)))
        ("p" . ,(lambda () (interactive) (scroll-down 1)))
        ("N" . ,(lambda () (interactive) (scroll-up 10)))
        ("P" . ,(lambda () (interactive) (scroll-down 10)))
        ("c" . scroll-other-window-down)
        ("v" . scroll-other-window)
        ("J" . jaunte)
        ))
(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
            cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
        (define-key keymap key cmd))))
  keymap)

(defun view-mode-hook0 ()
  (define-many-keys view-mode-map pager-keybind)
  (hl-line-mode 1)
  (define-key view-mode-map " " 'scroll-up))
(add-hook 'view-mode-hook 'view-mode-hook0)

;; 書き込み不能なファイルはview-modeで開くように
(defadvice find-file
  (around find-file-switch-to-view-file (file &optional wild) activate)
  (if (and (not (file-writable-p file))
           (not (file-directory-p file)))
      (view-file file)
    ad-do-it))
;; 書き込み不能な場合はview-modeを抜けないように
(defvar view-mode-force-exit nil)
(defmacro do-not-exit-view-mode-unless-writable-advice (f)
  `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
     (if (and (buffer-file-name)
              (not view-mode-force-exit)
              (not (file-writable-p (buffer-file-name))))
         (message "File is unwritable, so stay in view-mode.")
       ad-do-it)))

(do-not-exit-view-mode-unless-writable-advice view-mode-exit)
(do-not-exit-view-mode-unless-writable-advice view-mode-disable)

(require 'key-chord)
(setq key-chord-two-keys-delay 0.04)
(key-chord-mode 1)
(key-chord-define-global "jk" 'view-mode)

(provide 'setup-view-mode)
;;; setup-view-mode.el ends here

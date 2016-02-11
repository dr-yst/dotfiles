;;; setup-ido-mode.el --- setup of ido-mode

;; Copyright (C) 2013  渡辺 良人

;; Author: 渡辺 良人 <yoshito@Yoshitos-iMac.local>
;; Keywords: ido-mode


(ido-mode 1)
(ido-everywhere 1)

(provide 'setup-ido-mode)

;; type some characters appearing in the file name, RET to choose the file or directory in the front of the list.
;; C-s (next) or C-r (previous) to move through the list.
;; [Tab] - display possible completion in a buffer (or open the file or go down the directory if there is only one possible completion).
;; RET - type to go down inside the directory in front of the list.
;; [backspace] - go up to the parent directory.
;; // - go to the root directory.
;; ~/ - go to the home directory.
;; C-f - to go back temporarily to the normal find-file.
;; C-d - enter Dired for this directory (used to be C-x C-d in older versions)
;; C-j - create a new file named with the text you entered (note: this is needed if the text you entered matches an existing file, because RET would open the existing one)

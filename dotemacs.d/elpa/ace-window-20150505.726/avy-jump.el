;;; avy-jump.el --- jump to things tree-style

;; Copyright (C) 2015  Free Software Foundation, Inc.

;; Author: Oleh Krehel

;; This file is part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; This package offers various commands for navigating to things using `avy'.
;; They are in the "Commands" outline.

;;; Code:
;;* Requires
(require 'avy)

;;* Customization
(defgroup avy-jump nil
  "Jump to things tree-style."
  :group 'convenience
  :prefix "avi-")

(defcustom avi-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
  "Keys for jumping.")

(defcustom avi-background nil
  "When non-nil, a gray background will be added during the selection."
  :type 'boolean)

(defcustom avi-word-punc-regexp "[!-/:-@[-`{-~]"
  "Regexp of punctuation characters that should be matched when calling
`avi-goto-word-1' command. When nil, punctuation chars will not be matched.

\"[!-/:-@[-`{-~]\" will match all printable punctuation chars.")

(defface avi-lead-face
  '((t (:foreground "white" :background "#e52b50")))
  "Face used for the leading chars.")

(defface avy-background-face
  '((t (:foreground "gray40")))
  "Face for whole window background during selection.")

;;* Internals
(defun avi--goto (x)
  "Goto X.
X is (POS . WND)
POS is either a position or (BEG . END)."
  (if (null x)
      (message "zero candidates")
    (select-window (cdr x))
    (let ((pt (car x)))
      (when (consp pt)
        (setq pt (car pt)))
      (unless (= pt (point)) (push-mark))
      (goto-char pt))))

(defun avi--process (candidates overlay-fn)
  "Select one of CANDIDATES using `avy-read'."
  (unwind-protect
       (cl-case (length candidates)
         (0
          nil)
         (1
          (car candidates))
         (t
          (avy--make-backgrounds (list (selected-window)))
          (avy-read (avy-tree candidates avi-keys)
                    overlay-fn
                    #'avy--remove-leading-chars)))
    (avy--done)))

(defvar avy--overlays-back nil
  "Hold overlays for when `avi-background' is t.")

(defun avy--make-backgrounds (wnd-list)
  "Create a dim background overlay for each window on WND-LIST."
  (when avi-background
    (setq avy--overlays-back
          (mapcar (lambda (w)
                    (let ((ol (make-overlay
                               (window-start w)
                               (window-end w)
                               (window-buffer w))))
                      (overlay-put ol 'face 'avy-background-face)
                      ol))
                  wnd-list))))

(defun avy--done ()
  "Clean up overlays."
  (mapc #'delete-overlay avy--overlays-back)
  (setq avy--overlays-back nil)
  (avy--remove-leading-chars))

(defcustom avi-all-windows t
  "When non-nil, loop though all windows for candidates."
  :type 'boolean)

(defun avi--regex-candidates (regex &optional wnd beg end pred)
  "Return all elements that match REGEX in WND.
Each element of the list is ((BEG . END) . WND)
When PRED is non-nil, it's a filter for matching point positions."
  (let (candidates)
    (dolist (wnd (if avi-all-windows
                     (window-list)
                   (list (selected-window))))
      (with-selected-window wnd
        (let ((we (or end (window-end (selected-window) t))))
          (save-excursion
            (goto-char (or beg (window-start)))
            (while (re-search-forward regex we t)
              (unless (get-char-property (point) 'invisible)
                (when (or (null pred)
                          (funcall pred))
                  (push (cons (cons (match-beginning 0)
                                    (match-end 0))
                              wnd) candidates))))))))
    (nreverse candidates)))

(defvar avi--overlay-offset 0
  "The offset to apply in `avi--overlay'.")

(defvar avy--overlays-lead nil
  "Hold overlays for leading chars.")

(defun avy--remove-leading-chars ()
  "Remove leading char overlays."
  (mapc #'delete-overlay avy--overlays-lead)
  (setq avy--overlays-lead nil))

(defun avi--overlay (str pt wnd)
  "Create an overlay with STR at PT in WND."
  (let* ((pt (+ pt avi--overlay-offset))
         (ol (make-overlay pt (1+ pt) (window-buffer wnd)))
         (old-str (with-selected-window wnd
                    (buffer-substring pt (1+ pt)))))
    (when avi-background
      (setq old-str (propertize
                     old-str 'face 'avy-background-face)))
    (overlay-put ol 'window wnd)
    (overlay-put ol 'display (concat str old-str))
    (push ol avy--overlays-lead)))

(defun avi--overlay-pre (path leaf)
  "Create an overlay with STR at LEAF.
PATH is a list of keys from tree root to LEAF.
LEAF is ((BEG . END) . WND)."
  (avi--overlay
   (propertize (apply #'string (reverse path))
               'face 'avi-lead-face)
   (cond ((numberp leaf)
          leaf)
         ((consp (car leaf))
          (caar leaf))
         (t
          (car leaf)))
   (if (consp leaf)
       (cdr leaf)
     (selected-window))))

(defun avi--overlay-at (path leaf)
  "Create an overlay with STR at LEAF.
PATH is a list of keys from tree root to LEAF.
LEAF is ((BEG . END) . WND)."
  (let ((str (propertize
              (string (car (last path)))
              'face 'avi-lead-face))
        (pt (if (consp (car leaf))
                (caar leaf)
              (car leaf)))
        (wnd (cdr leaf)))
    (let ((ol (make-overlay pt (1+ pt)
                            (window-buffer wnd)))
          (old-str (with-selected-window wnd
                     (buffer-substring pt (1+ pt)))))
      (when avi-background
        (setq old-str (propertize
                       old-str 'face 'avy-background-face)))
      (overlay-put ol 'window wnd)
      (overlay-put ol 'display str)
      (push ol avy--overlays-lead))))

(defun avi--overlay-post (path leaf)
  "Create an overlay with STR at LEAF.
PATH is a list of keys from tree root to LEAF.
LEAF is ((BEG . END) . WND)."
  (avi--overlay
   (propertize (apply #'string (reverse path))
               'face 'avi-lead-face)
   (cond ((numberp leaf)
          leaf)
         ((consp (car leaf))
          (cdar leaf))
         (t
          (car leaf)))
   (if (consp leaf)
       (cdr leaf)
     (selected-window))))

(defun avi--generic-jump (regex flip)
  "Jump to REGEX.
When FLIP is non-nil, flip `avi-all-windows'."
  (let ((avi-all-windows
         (if flip
             (not avi-all-windows)
           avi-all-windows)))
    (avi--goto
     (avi--process
      (avi--regex-candidates
       regex)
      #'avi--overlay-post))))

;;* Commands
;;;###autoload
(defun avi-goto-char (&optional arg)
  "Read one char and jump to it.
The window scope is determined by `avi-all-windows'.
When ARG is non-nil, flip the window scope."
  (interactive "P")
  (avi--generic-jump
   (string (read-char "char: ")) arg))

;;;###autoload
(defun avi-goto-char-2 (&optional arg)
  "Read two chars and jump to them in current window.
When ARG is non-nil, flip the window scope."
  (interactive "P")
  (avi--generic-jump
   (string
    (read-char "char 1: ")
    (read-char "char 2: "))
   arg))

;;;###autoload
(defun avi-isearch ()
  "Jump to one of the current isearch candidates."
  (interactive)
  (let* ((candidates
          (avi--regex-candidates isearch-string))
         (avi-background nil)
         (candidate
          (avi--process candidates #'avi--overlay-post)))
    (isearch-done)
    (avi--goto candidate)))

;;;###autoload
(defun avi-goto-word-0 (arg)
  "Jump to a word start."
  (interactive "P")
  (let ((avi-keys (number-sequence ?a ?z)))
    (avi--generic-jump "\\b\\sw" arg)))

;;;###autoload
(defun avi-goto-subword-0 (&optional arg)
  "Jump to a word or subword start."
  (interactive "P")
  (let* ((avi-all-windows
          (if arg
              (not avi-all-windows)
            avi-all-windows))
         (avi-keys (number-sequence ?a ?z))
         (candidates (avi--regex-candidates
                      "\\(\\b\\sw\\)\\|\\(?:[^A-Z]\\([A-Z]\\)\\)")))
    (dolist (x candidates)
      (when (> (- (cdar x) (caar x)) 1)
        (cl-incf (caar x))))
    (avi--goto
     (avi--process candidates #'avi--overlay-pre))))

;;;###autoload
(defun avi-goto-word-1 ()
  "Jump to a word start in current window.
Read one char with which the word should start."
  (interactive)
  (let* ((str (string (read-char "char: ")))
         (candidates (avi--regex-candidates
                      (if (and avi-word-punc-regexp
                               (string-match avi-word-punc-regexp str))
                          str
                        (concat
                         "\\b"
                         str)))))
    (avi--goto
     (avi--process candidates #'avi--overlay-pre))))

(defun avi--line (&optional arg)
  "Select line in current window."
  (let ((avi-background nil)
        (avi-all-windows
         (if arg
             (not avi-all-windows)
           avi-all-windows))
        candidates)
    (dolist (wnd (if avi-all-windows
                     (window-list)
                   (list (selected-window))))
      (with-selected-window wnd
        (let ((ws (window-start)))
          (save-excursion
            (save-restriction
              (narrow-to-region ws (window-end (selected-window) t))
              (goto-char (point-min))
              (while (< (point) (point-max))
                (unless (get-char-property
                         (max (1- (point)) ws) 'invisible)
                  (push (cons (point) (selected-window))
                        candidates))
                (forward-line 1)))))))
    (avi--process (nreverse candidates) #'avi--overlay-pre)))

;;;###autoload
(defun avi-goto-line (&optional arg)
  "Jump to a line start in current buffer."
  (interactive "P")
  (avi--goto (avi--line arg)))

;;;###autoload
(defun avi-copy-line (arg)
  "Copy a selected line above the current line.
ARG lines can be used."
  (interactive "p")
  (let ((start (car (avi--line))))
    (move-beginning-of-line nil)
    (save-excursion
      (insert
       (buffer-substring-no-properties
        start
        (save-excursion
          (goto-char start)
          (move-end-of-line arg)
          (point)))
       "\n"))))

;;;###autoload
(defun avi-move-line (arg)
  "Move a selected line above the current line.
ARG lines can be used."
  (interactive "p")
  (let ((start (car (avi--line))))
    (move-beginning-of-line nil)
    (save-excursion
      (save-excursion
        (goto-char start)
        (move-end-of-line arg)
        (kill-region start (point)))
      (insert
       (current-kill 0)
       "\n"))))

;;;###autoload
(defun avi-copy-region ()
  "Select two lines and copy the text between them here."
  (interactive)
  (let ((beg (car (avi--line)))
        (end (car (avi--line)))
        (pad (if (bolp) "" "\n")))
    (move-beginning-of-line nil)
    (save-excursion
      (insert
       (buffer-substring-no-properties
        beg
        (save-excursion
          (goto-char end)
          (line-end-position)))
       pad))))

(provide 'avy-jump)

;;; avy-jump.el ends here

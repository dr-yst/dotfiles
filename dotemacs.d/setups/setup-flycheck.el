;;; setup-flycheck.el --- setup of flycheck-mode     -*- lexical-binding: t; -*-

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

;;; Code:

(require 'flycheck)

(global-flycheck-mode)

(define-key global-map (kbd "\C-cn") 'flycheck-next-error)
(define-key global-map (kbd "\C-cp") 'flycheck-previous-error)
(define-key global-map (kbd "\C-cd") 'flycheck-list-errors)

(flycheck-define-checker c/c++11
  "A C/C++ checker using g++."
  :command ("g++" "-Wall" "-Wextra" "-std=c++11" source)
  :error-patterns  ((error line-start
                           (file-name) ":" line ":" column ":" " Error: " (message)
                           line-end)
                    (warning line-start
                           (file-name) ":" line ":" column ":" " Warning: " (message)
                           line-end))
  :modes (c-mode c++-mode))



(provide 'setup-flycheck)
;;; setup-flycheck.el ends here

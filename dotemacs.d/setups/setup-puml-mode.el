;;; setup-puml-mode.el --- setup of puml-mode (PlantUML mode).  -*- lexical-binding: t; -*-

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


;; Enable puml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.puml\\'" . puml-mode))
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . puml-mode))

;; C-c C-c  puml-preview: renders a PlantUML diagram from the current buffer in the best supported format

;; C-u C-c C-c  puml-preview in other window

;; C-u C-u C-c C-c puml-preview in other frame

(add-to-list
 'org-src-lang-modes '("plantuml" . puml))

;; こんな感じでorg-mode内で使える
;; #+BEGIN_SRC plantuml
;;   <hit C-' here to open a puml-mode buffer>
;; #+END_SRC
;; you can edit a plantuml code block with puml-mode by hitting C-' while inside of the code block itself.


(provide 'setup-puml-mode)
;;; setup-puml-mode.el ends here

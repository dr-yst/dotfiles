;;; setup-pangu-spacing.el ---                       -*- lexical-binding: t; -*-

;; Copyright (C) 2015  WatanabeYoshito

;; Author: WatanabeYoshito <yoshito@okanai.local>
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

;;; chinse-two-byte→japaneseに置き換えるだけで日本語でも使える
(setq pangu-spacing-chinese-before-english-regexp
  (rx (group-n 1 (category japanese))
      (group-n 2 (in "a-zA-Z0-9$="))))
(setq pangu-spacing-chinese-after-english-regexp
  (rx (group-n 1 (in "a-zA-Z0-9$="))
      (group-n 2 (category japanese))))
;;; 見た目ではなくて実際にスペースを入れる
(setq pangu-spacing-real-insert-separtor t)
;; text-modeやその派生モード(org-mode等)のみに使いたいならこれ
(add-hook 'org-mode-hook 'pangu-spacing-mode)
;; すべてのメジャーモードに使ってみたい人はこれを
;; (global-pangu-spacing-mode 1)

(provide 'setup-pangu-spacing)
;;; setup-pangu-spacing.el ends here

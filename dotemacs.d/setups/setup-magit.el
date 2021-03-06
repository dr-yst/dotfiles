;;; setup-magit.el ---                               -*- lexical-binding: t; -*-

;; Copyright (C) 2015  WatanabeYoshito

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


(require 'magit)

;; (setq magit-last-seen-setup-instructions "1.4.0")

(global-set-key (kbd "C-q v") 'magit-status)

(provide 'setup-magit)
;;; setup-magit.el ends here

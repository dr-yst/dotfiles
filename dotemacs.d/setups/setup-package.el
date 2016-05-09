;;; setup-package.el --- setup of elpa               -*- lexical-binding: t; -*-

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

;; package.el -------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; (require 'cl)

(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    ac-php
    ace-jump-helm-line
    ace-jump-mode
    ace-window
    alert
    all
    all-ext
    anzu
    async
    auctex
    auto-complete
    auto-highlight-symbol
    auto-install
    avy
    biblio
    biblio-core
    c-eldoc
    codic
    coffee-mode
    company
    company-auctex
    company-irony
    company-quickhelp
    dash
    dash-at-point
    deferred
    dired+
    dummy-h-mode
    e2wm
    ebib
    egg
    electric-spacing
    emms
    epl
    exec-path-from-shell
    f
    flycheck
    free-keys
    fuzzy
    git-commit
    gntp
    google-this
    goto-chg
    gtags
    guide-key
    helm
    helm-ag
    helm-bibtex
    helm-core
    helm-ls-git
    highlight-indentation
    historyf
    hiwin
    hlinum
    irony
    jaunte
    key-chord
    latex-preview-pane
    let-alist
    log4e
    lua-mode
    magit
    magit-popup
    markdown-mode
    migemo
    moe-theme
    multi-term
    multiple-cursors
    nyan-mode
    org
    org-agenda-property
    org-wunderlist
    origami
    outline-magic
    pangu-spacing
    parsebib
    php-mode
    pkg-info
    point-undo
    popup
    popwin
    pos-tip
    rainbow-delimiters
    rainbow-mode
    recentf-ext
    request
    request-deferred
    s
    seq
    smartrep
    sound-wav
    summarye
    swift-mode
    tabbar
    undo-tree
    web-mode
    window-layout
    with-editor
    xcscope
    yasnippet
    yaxception
    zoom-window
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))

(provide 'setup-package)
;;; setup-package.el ends here

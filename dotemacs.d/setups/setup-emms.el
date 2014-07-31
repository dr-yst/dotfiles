;;; setup-emms.el --- setup of emms

;; Copyright (C) 2014  WatanabeYoshito

;; Author: WatanabeYoshito <yoshito@WatanabeYoshito-no-iMac.local>
;; Keywords: multimedia,

(require 'emms-setup)
(require 'emms-browser)
(emms-all)
(emms-default-players)

(setq emms-source-file-default-directory "~/Music/iTunes/iTunes Media/Music/")

(add-to-list 'emms-browser-covers "AlbumArtSmall.jpg" "Folder.jpg")


(provide 'setup-emms)


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

(defun fg-emms-track-description (track)
  "いくらかナイスなトラック情報を返す."
  (let ((artist (emms-track-get track 'info-artist))
        (year (emms-track-get track 'info-year))
        (album (emms-track-get track 'info-album))
        (tracknumber (emms-track-get track 'info-tracknumber))
        (title (emms-track-get track 'info-title)))
    (cond
     ((or artist title)
      (concat (if (> (length artist) 0) artist "Unknown artist") " - "
              (if (> (length year) 0) year "XXXX") " - "
              (if (> (length album) 0) album "Unknown album") " - "
              (if (> (length tracknumber) 0)
                  (format "%02d" (string-to-number tracknumber))
                "XX") " - "
                (if (> (length title) 0) title "Unknown title")))
     (t
      (emms-track-simple-description track)))))

(setq emms-track-description-function 'fg-emms-track-description)

(provide 'setup-emms)


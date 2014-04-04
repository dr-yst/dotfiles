;;; org-agenda-property-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (org-agenda-property-add-properties) "org-agenda-property"
;;;;;;  "org-agenda-property.el" (21310 40916 0 0))
;;; Generated autoloads from org-agenda-property.el

(autoload 'org-agenda-property-add-properties "org-agenda-property" "\
Append locations to agenda view.
Uses `org-agenda-locations-column'.

\(fn)" nil nil)

(if (boundp 'org-agenda-finalize-hook) (add-hook 'org-agenda-finalize-hook 'org-agenda-property-add-properties) (add-hook 'org-finalize-agenda-hook 'org-agenda-property-add-properties))

;;;***

;;;### (autoloads nil nil ("org-agenda-property-pkg.el") (21310 40916
;;;;;;  253912 0))

;;;***

(provide 'org-agenda-property-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; org-agenda-property-autoloads.el ends here

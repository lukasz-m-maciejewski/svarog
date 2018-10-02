;;; svarog-org -- summary

;;; Commentary:
;; 

;;; Code:
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

(with-eval-after-load 'org
  (setq org-default-notes-file (concat org-directory "/notes.org"))

  (setq org-capture-templates
        '(
          ("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
           "* TODO %?\n  %i\n  %a")
          ("j" "Journal" entry (file+olp+datetree "~/org/journal.org")
           "* %?\nEntered on %U\n  %i\n  %a"))
        )
  )

(provide 'svarog-org)
;;; svarog-org ends here

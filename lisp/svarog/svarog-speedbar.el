;;; svarog-speedbar.el --- Summary:
;;; Commentary:
;; Speedbar related config

;;; Code:
(use-package sr-speedbar
  :ensure t)

(use-package projectile-speedbar
  :ensure t)

(global-set-key (kbd "<f2> s") 'projectile-speedbar-open-current-buffer-in-tree)

(provide 'svarog-speedbar)
;;; svarog-speedbar.el ends here

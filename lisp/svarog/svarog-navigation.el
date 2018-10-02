;;; svarog-navigation.el --- Summary:
;;; Commentary:
;; Place for configuring editor navigation-related packages

;;; Code:
(use-package avy
  :ensure t
  :config
  (avy-setup-default)
  :bind (("C-:" . avy-goto-char)
         ("C-'" . avy-goto-char-2)
         ("M-g f" . avy-goto-line)
         ("M-g w" . avy-goto-word-1)
         ("M-g e" . avy-goto-word-0)
         ("C-c C-j" . avy-resume)))

(use-package window-numbering
  :ensure t)
(window-numbering-mode t)

(provide 'svarog-navigation)
;;; svarog-navigation.el ends here

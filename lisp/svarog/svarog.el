;;; svarog.el --- Summary

;;; Commentary:
;; use-package is required to be loaded before loading this file
;;; Code:

(use-package hydra
  :ensure t)
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))
(use-package ivy-hydra
  :ensure t)
(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)))
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("<f1> f" . counsel-describe-function)
         ("<f1> v" . counsel-describe-variable)
         ("<f1> l" . counsel-find-library)
         ("<f2> i" . counsel-info-lookup-symbol)
         ("<f2> u" . counsel-unicode-char))
  :config
  (define-key counsel-find-file-map (kbd "C-l") 'counsel-up-directory)
  (define-key counsel-find-file-map (kbd "RET") 'ivy-partial-or-done))

;; Make buffer names unique
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward))
(use-package graphene-meta-theme
  :ensure t)
(use-package rainbow-delimiters
  :ensure t)
(use-package smartparens
  :ensure t)
(use-package company
  :ensure t
  :delight)
(use-package which-key
  :delight
  :ensure t
  :config
  (which-key-mode))
(use-package multi-term
  :ensure t)
(use-package powerline
  :ensure t
  :config
  (powerline-default-theme))

(require 'svarog-navigation)
(require 'svarog-speedbar)

(require 'svarog-editing)
(require 'svarog-org)
(require 'svarog-prog)

(defun svarog/reload-theme (theme)
  "Reloads a THEME."
  (load-theme theme)
  (load-theme 'graphene-meta)
  (powerline-reset))

(defun svarog/light-theme ()
  "Set solarized light theme."
  (interactive)
  (svarog/reload-theme 'solarized-light))

(defun svarog/dark-theme ()
  "Set solarized dark theme."
  (interactive)
  (svarog/reload-theme 'solarized-dark))

(provide 'svarog)
;;; svarog.el ends here

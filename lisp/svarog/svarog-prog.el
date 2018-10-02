;;; svarog-prog.el -- Summary:
;;; Commentary:
;; Haskell related configuration

;;; Code:

(use-package lsp-ui
  :ensure t
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company-lsp
  :ensure t
  :config
  (push 'company-lsp company-backends))

(require 'svarog-prog-mode)
(require 'svarog-prog-haskell)
(provide 'svarog-prog)
;;; svarog-prog.el

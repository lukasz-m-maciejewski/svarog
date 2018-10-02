;;; svarog-editing.el --- General editing configuration

;;; Commentary:

;;; Code:
(use-package undo-tree
  :ensure t
  :config
  (diminish 'undo-tree-mode))
(global-undo-tree-mode)

(provide 'svarog-editing)
;;; svarog-editing.el ends here

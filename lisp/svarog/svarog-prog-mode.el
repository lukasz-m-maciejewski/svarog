;;; svarog-prog-mode.el --- Common configuration for prog modes

;;; Commentary:

;;; Code:
(defvar svarog-prog-mode-hook nil
  "A proxy prog mode hook for svarog.")

(add-hook 'svarog-prog-mode-hook
          (lambda ()
            (svarog-whitespace)
            (svarog-highlight)
            (svarog-hide-show)
            (svarog-line-numbers)
            (svarog-auto-revert-buffer)))

(defun svarog-whitespace ()
  "Enable and configure whitespace mode."
  (setq whitespace-line-column 80)
  (setq whitespace-style '(face tabs empty trailing newline))
  (whitespace-mode 1)
  (add-hook 'before-save-hook 'whitespace-cleanup))

(defun svarog-highlight ()
  "Enable hi-lock mode."
  (hl-line-mode 1)
  (hi-lock-mode 1))

(defun svarog-hide-show ()
  "Enable 'hs-minor-mode'."
  (hs-minor-mode 1))

(defun svarog-line-numbers ()
  "Enable linum mode."
  (setq linum-format " %4d ")
  (linum-mode 1))

(defun svarog-auto-revert-buffer ()
  "Enable 'auto-revert-mode'."
  (auto-revert-mode 1))

(add-hook 'after-init-hook
          (lambda ()
            (add-hook 'prog-mode-hook (lambda () (run-hooks 'svarog-prog-mode-hook)))))

(provide 'svarog-prog-mode)
;;; svarog-prog-mode.el ends here

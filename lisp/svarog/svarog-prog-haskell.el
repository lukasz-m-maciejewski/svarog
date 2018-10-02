;;; svarog-prog-haskell.el -- Summary:
;;; Commentary:
;; Haskell related configuration

;;; Code:
(use-package haskell-mode
  :ensure t
  :bind (("C-c h" . hoogle))
  :config
  (custom-set-variables '(haskell-process-type 'stack-ghci)))

(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))

(use-package intero
  :ensure t
  :after (:any haskell-mode haskell-cabal)
  :hook ((haskell-mode-hook . subword-mode)
         (haskell-mode-hook . eldoc-mode))
  :config
  (intero-global-mode)
  (after-load 'intero
    (define-key intero-mode-map (kbd "M-?") nil)
    (after-load 'flycheck
      (flycheck-add-next-checker 'intero
                                 '(warning . haskell-hlint)))))

(define-minor-mode stack-exec-path-mode
  "If this is a stack project, set `exec-path' to the path \"stack exec\" would use."
  nil
  :lighter ""
  :global nil
  (if stack-exec-path-mode
      (when (and (executable-find "stack")
                 (locate-dominating-file default-directory "stack.yaml"))
        (setq-local
         exec-path
         (seq-uniq
          (append
           (list
            (concat
             (string-trim-right
              (shell-command-to-string "stack path --local-install-root"))
             "/bin"))
           (parse-colon-path
            (replace-regexp-in-string
             "[\r\n]+\\'" ""
             (shell-command-to-string "stack path --bin-path"))))
          'string-equal)))
    (kill-local-variable 'exec-path)))

(use-package yaml-mode
  :ensure t)

(use-package lsp-haskell
  :ensure t)

(add-hook 'haskell-mode-hook 'stack-exec-path-mode)
;; (add-hook 'haskell-mode-hook #'lsp-haskell-enable)
;; (add-hook 'haskell-mode-hook 'flycheck-mode)

(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
  (speedbar-add-supported-extension ".hs")
  (speedbar-add-supported-extension ".yaml")))


(provide 'svarog-prog-haskell)
;;; svarog-prog-haskell.el ends here

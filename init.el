;;; init --- summary:
;;; Commentary:
;; Without this comment emacs25 adds (package-initialize) here
;; (package-initialize)

;;; Code:
(setq gc-cons-threshold 100000000)
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; Save backup files in the temporary directory
(setq backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(delete-selection-mode 1)
;; Don't show the startup message
(setq inhibit-startup-message t)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
            (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
    (package-install 'use-package))

(require 'use-package)

(let ((default-directory  "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(defconst svarog/config-local-directory
  (concat user-emacs-directory "config-local/"))
(unless (file-exists-p svarog/config-local-directory)
  (make-directory svarog/config-local-directory))

(defconst svarog/custom-file (expand-file-name "custom.el" svarog/config-local-directory))
(setq custom-file svarog/custom-file)
(load svarog/custom-file 'noerror)

(setq recentf-save-file (expand-file-name "recentf" svarog/config-local-directory))

(use-package auto-package-update
             :config
             (setq auto-package-update-last-update-day-path
                   (expand-file-name "last-package-update-day" svarog/config-local-directory))
             (setq auto-package-update-delete-old-versions t)
             (setq auto-package-update-hide-results t)
             (auto-package-update-maybe))

(setq ido-save-directory-list-file (concat svarog/config-local-directory "ido.last"))
(setq tramp-persistency-file-name (expand-file-name "tramp" svarog/config-local-directory))

(use-package solarized-theme
  :ensure t
  :config
  (setq solarized-distinct-fringe-background t
        solarized-use-variable-pitch nil
        solarized-high-contrast-mode-line t
        solarized-height-minus-1 1.0
        solarized-height-plus-1 1.0
        solarized-height-plus-2 1.0
        solarized-height-plus-3 1.0
        solarized-height-plus-4 1.0))
(load-theme 'solarized-dark t)

(defvar graphene-geometry-file
  (expand-file-name "frame-geometry" svarog/config-local-directory)
  "The file where frame geometry settings are saved.")

(require 'svarog)

(require 'graphene)
(use-package switch-window
  :ensure t
  :bind (("C-x o" . switch-window)
         ("C-x 1" . switch-window-then-maximize)
         ("C-x 2" . switch-window-then-split-below)
         ("C-x 3" . switch-window-then-split-right)
         ("C-x 0" . switch-window-then-delete)
         ("C-x 4 d" . switch-window-then-dired)
         ("C-x 4 f" . switch-window-then-find-file)
         ("C-x 4 m" . switch-window-then-compose-mail)
         ("C-x 4 r" . switch-window-then-find-file-read-only)
         ("C-x 4 0" . switch-window-then-kill-buffer)
         ("C-x 4 C-f" . switch-window-then-find-file)
         ("C-x 4 C-o" . switch-window-then-display-buffer)))

(use-package cquery
  :ensure t
  :config
  (add-hook 'c++-mode-hook (lambda ()
                             (lsp-cquery-enable))))

(with-eval-after-load 'projectile
  (projectile-register-project-type 'cpp-code '("projectile-cpp")
                                    :configure "(mkdir build-debug; cd build-debug; cmake ../source -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug; cd ..; ln -s build-debug/compile_commands.json)"
                                    :src-dir "source"
                                    :compile "(cd build-debug; cmake --build . )"
                                      :test "(cd build-debug; ctest .)"
                                      :test-suffix ".test.cpp"
                                      ))

(use-package projectile
  :ensure t
  :config
  (setq projectile-cache-file (concat svarog/config-local-directory "projectile.cache")
        projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld"
                                                         svarog/config-local-directory))
  (projectile-mode +1))

;;; C++ config:
(add-hook 'c-mode-common-hook
          (lambda ()
            "C mode customization hook."
            (c-set-style "bsd")
            (setq c-basic-offset 4
                  tab-width 4
                  indent-tabs-mode nil
                  c-tab-always-indent t
                  c-echo-syntactic-information-p t)
            (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

            (auto-revert-mode 1)
            (toggle-truncate-lines t)))

(add-hook 'c++-mode-hook
          (lambda ()
            (add-to-list 'c-offsets-alist '(innamespace . 0))
            (c-set-offset 'substatement-open 0)
            (c-set-offset 'label '+)))

(setq vc-handled-backends nil) ; disables build-in version control
(use-package magit
  :ensure t)

(use-package diminish
  :ensure t)
(diminish 'company-mode)
(diminish 'visual-line-mode)
(diminish 'which-key-mode)
(diminish 'auto-revert-mode)
(diminish 'smartparens-mode)
(diminish 'eldoc-mode)
(diminish 'lsp-mode)
(diminish 'whitespace-mode)
(diminish 'hs-minor-mode)
(diminish 'ivy-mode)
(diminish 'projectile-mode "P")

(display-battery-mode t)

(use-package ledger-mode
  :ensure t)


;;; init.el ends here

(require 'package)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-hook 'prog-mode-hook 'linum-mode)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;(add-to-list 'load-path "<path where use-package is installed>")
  (require 'use-package-ensure)
  (setq use-package-always-ensure t))

(use-package all-the-icons)
(use-package flycheck
  :init (global-flycheck-mode))
(use-package evil
  :config (evil-mode 1))
;(use-package nlinum-relative
  ;:config (nlinum-relative-setup-evil)
  ;:add-hook ('prog-mode-hook 'nlinum-relative-mode))
(use-package helm
  :bind ("M-x" . helm-M-x)
  :config
  (use-package helm-descbinds
    :config(helm-descbinds-mode))
  (helm-mode 1))
(use-package lsp-mode
  :hook (c++-mode . lsp)
  :commands lsp)
(use-package doom-themes
  :config(load-theme 'doom-gruvbox t))
(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))
(use-package helm-lsp
  :commands helm-lsp-workspace-symbol)

(setq doom-themes-enable-bold t)
(setq doom-themes-enable-italic t)

(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("67798cfaf7b064072bf519ed1ade02a8f4412df89c560e35f25d1936cf35b8ce" default)))
 '(package-selected-packages
   (quote
    (doom-modeline doom-themes use-package shrink-path nlinum-relative helm-lsp helm-descbinds gruvbox-theme flycheck evil-nerd-commenter evil-leader all-the-icons))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

(add-to-list 'load-path user-emacs-directory)
(add-to-list 'load-path (expand-file-name "elpa" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "site-lisp" user-emacs-directory))
(let ((default-directory "~/.emacs.d/elpa/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'sane-defaults)

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Set up appearance early
(require 'appearance)

(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Setup packages
(require 'setup-package)

(require 'setup-ido)
(require 'setup-yasnippet)
(require 'setup-hippie)
(require 'setup-auto-complete)
(require 'setup-nxml-mode)
(require 'setup-csharp-mode)
(require 'setup-cpp-mode)
(require 'setup-org-mode)
(require 'setup-html-mode)
(require 'setup-css)
;; (require 'xpath-parser)
(eval-after-load 'magit '(require 'setup-magit))
(eval-after-load "sql" '(load-library "tsql-indent"))

;; (require 'setup-cygwin-shell)

(add-to-list 'auto-mode-alist '("\\.asp\\'" . web-mode))

(autoload 'asp-mode "asp-mode")
    (setq auto-mode-alist 
       (cons '("\\.asp\\'" . asp-mode) auto-mode-alist))

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8"))
(guide-key-mode 1)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)
(setq guide-key/highlight-command-regexp "rectangle")
(setq guide-key/idle-delay 0.07)

;; (add-to-list 'load-path "c:/Users/mgrinman/AppData/Roaming/npm/node_modules/tern/emacs")
;; (autoload 'tern-mode "tern.el" nil t)
;; (add-hook 'js-mode-hook (lambda () (tern-mode t)))

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

(require 'smart-forward)

;; Smart M-x is smart
(require 'smex)
(smex-initialize)

;; Setup key bindings
(require 'key-bindings)
(put 'scroll-left 'disabled nil)

;; Settings for currently logged in user
(setq user-settings-dir
      (concat user-emacs-directory "users/" user-login-name))

;; Conclude init by setting up specifics for the current user
(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))




;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Set path to dependencies
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))
(setq my-lisp-dir
      (expand-file-name "lisp" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path site-lisp-dir)
(let ((dir (expand-file-name "elpa" user-emacs-directory)))
  (unless (file-exists-p dir)
    (make-directory dir)))
(add-to-list 'load-path (expand-file-name "elpa" user-emacs-directory))
(let ((default-directory "~/.emacs.d/elpa/"))
  (normal-top-level-add-subdirs-to-load-path))

;; Keep emacs Custom-settings in separate file
(let ((cust (expand-file-name "custom.el" my-lisp-dir)))
  (unless (file-exists-p cust)
    (write-region "" nil cust)))
(setq custom-file (expand-file-name "custom.el" my-lisp-dir))
(load custom-file)

;; Set up appearance early
(require 'appearance)

;; Add external projects to load path
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; (dolist (project (directory-files site-lisp-dir t "\\w+"))
;;   (when (file-directory-p project)
;;     (add-to-list 'load-path project)))


;; Setup packages
(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(anzu
     apache-mode
     auto-complete
     change-inner
     csharp-mode
     css-eldoc
     discover-my-major
     elisp-slime-nav
     flx-ido
     geben
     geiser
     ggtags
     god-mode
     guide-key
     highlight-escape-sequences
     less-css-mode
     magit
     move-text
     php-mode
     projectile
     quack
     rainbow-mode
     shell-command
     smooth-scrolling
     smartparens
     volatile-highlights
     web-mode
     yasnippet
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

(require 'sane-defaults)

;; Load stuff on demand
(autoload 'flycheck-mode "setup-flycheck" nil t)
(autoload 'auto-complete-mode "auto-complete" nil t)

;; Setup extensions
(eval-after-load 'ido '(require 'setup-ido))
(eval-after-load 'magit '(require 'setup-magit))
(eval-after-load 'sql '(load-library "sql-indent"))
(eval-after-load 'org '(require 'setup-org-mode))
;; (eval-after-load 'dired '(require 'setup-dired))
;; (eval-after-load 'grep '(require 'setup-rgrep))
;; (eval-after-load 'shell '(require 'setup-shell))

(require 'setup-shell)
(require 'setup-hippie)
(require 'setup-yasnippet)
(require 'setup-html-mode)
(require 'setup-flycheck)
;; (require 'setup-auto-complete)

;; Default setup of smartparens
(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
;; (setq sp-autoescape-string-quote nil)
(sp-use-paredit-bindings)
(--each '(css-mode-hook
          emacs-lisp-mode-hook
          c++-mode-hook
          geiser-repl-mode-hook
          scheme-mode-hook
          perl-mode-hook
          js-mode-hook
          python-mode-hook
          ruby-mode
          markdown-mode)
  (add-hook it 'turn-on-smartparens-mode))
;; (show-smartparens-global-mode +1)

;; Language specific setup files
(eval-after-load 'js2-mode '(require 'setup-js2-mode))
;; (eval-after-load 'nxml-mode '(require 'setup-nxml-mode))
(eval-after-load 'css-mode '(require 'setup-css))
(eval-after-load 'less-css-mode '(require 'setup-less-mode))
(eval-after-load "erc" '(require 'setup-irc))

(require 'quack)

(require 'setup-nxml-mode)
(require 'setup-c-modes)

(require 'mode-mappings)

;; Highlight escape sequences
(require 'highlight-escape-sequences)
(hes-mode)
(put 'font-lock-regexp-grouping-backslash 'face-alias 'font-lock-builtin-face)

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8" "C-x C-k" "<f1>" "C-c p"))
(guide-key-mode 1)
(setq guide-key/recursive-key-sequence-flag t)
(setq guide-key/popup-window-position 'bottom)
(setq guide-key/highlight-command-regexp "rectangle")
(setq guide-key/idle-delay 0.07)

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" my-lisp-dir))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

(require 'expand-region)
(require 'multiple-cursors)
(require 'smart-forward)
(require 'wgrep)

;; project management
(projectile-global-mode)

;; Fill column indicator
(require 'fill-column-indicator)
(setq fci-rule-color "#111122")

;; Highlight changes
(require 'volatile-highlights)
(volatile-highlights-mode t)

;; anzu-mode enhances isearch by showing total matches and current match position
(require 'anzu)
(global-anzu-mode)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
(global-set-key [remap query-replace] 'anzu-query-replace)

;; Fill column indicator
(require 'fill-column-indicator)
(setq fci-rule-color "#111122")

;; Browse kill ring
(require 'browse-kill-ring)
(setq browse-kill-ring-quit-action 'save-and-restore)

;; Smart M-x is smart
(require 'smex)
(smex-initialize)

;; Elisp go-to-definition with M-. and back again with M-,
(autoload 'elisp-slime-nav-mode "elisp-slime-nav")
(add-hook 'emacs-lisp-mode-hook (lambda () (elisp-slime-nav-mode t) (eldoc-mode 1)))

;; Dir tree like NERD for vim
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; Setup key bindings
(require 'key-bindings)

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

(require 'setup-god-mode)

;; Conclude init by setting up specifics for the current user
;; Settings for currently logged in user
(setq user-settings-dir
      (concat user-emacs-directory "users/" user-login-name))
(add-to-list 'load-path user-settings-dir)
(when (file-exists-p user-settings-dir)
  (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))

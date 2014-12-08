(setq visible-bell t
      font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

;; Highlight current line
(global-hl-line-mode 1)

;; set font
;; default font
;; (set-default-font "-outline-DejaVu Sans Mono-normal-normal-normal-mono-15-*-*-*-c-*-iso8859-1")
(if (member "Inconsolata" (font-family-list))
    (progn (set-frame-font "Inconsolata")
           (set-face-attribute :height 135))
  (set-frame-font "Bitstream Vera Sans Mono")
  (set-face-attribute 'default nil :height 115))

;; (set-frame-font "Bitstream Vera Sans Mono")
;; (set-face-attribute 'default nil :height 100)

;; (set-frame-font "dejavu sans mono")
;; (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-11.5"))
;; (add-to-list 'default-frame-alist '(font . "Inconsolata-13.5"))
;; (set-face-attribute 'default nil :font "Inconsolata-13.5")
;; (set-face-attribute 'default nil :font "Source Code Pro-11")
;; (set-face-attribute 'default nil :height 80 :font "-misc-dejavu sans mono-medium-r-normal--0-0-0-0-m-0-ascii-0")
;; (set-face-attribute 'default nil :height 150 :font "-misc-inconsolata-medium-r-normal-*-18-*-*-*-m-0-iso8859-1")
;; (set-face-attribute 'default nil :font "-bitstream-Bitstream Vera Sans Mono-normal-normal-normal-*-15-*-*-*-m-0-iso10646-1")
;; (set-face-attribute 'default nil :height 120 :font "-misc-dejavu sans mono-medium-r-normal-*-16-*-*-*-m-0-iso8859-1")


;; Set custom theme path
(setq custom-theme-directory (concat user-emacs-directory "themes"))

(dolist
    (path (directory-files custom-theme-directory t "\\w+"))
  (when (file-directory-p path)
    (add-to-list 'custom-theme-load-path path)))

;; Default theme
(defun use-presentation-theme ()
  (interactive)
  (disable-theme 'default-black)
  (load-theme 'prez))

(defun use-default-theme ()
  (interactive)
  (disable-theme 'prez)
  (load-theme 'default-black))

(defun toggle-presentation-mode ()
  (interactive)
  (if (member 'default-black custom-enabled-themes)
      (use-presentation-theme)
    (use-default-theme)))

(global-set-key (kbd "C-<f9>") 'toggle-presentation-mode)

(use-default-theme)

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

;; Make zooming affect frame instead of buffers
(require 'zoom-frm)

;; Unclutter the modeline
(require 'diminish)
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
(eval-after-load "eldoc" '(diminish 'eldoc-mode))
;; (eval-after-load "paredit" '(diminish 'paredit-mode))
(eval-after-load "smartparens" '(diminish 'smartparens-mode))
(eval-after-load "tagedit" '(diminish 'tagedit-mode))
(eval-after-load "elisp-slime-nav" '(diminish 'elisp-slime-nav-mode))
;; (eval-after-load "skewer-mode" '(diminish 'skewer-mode))
;; (eval-after-load "skewer-css" '(diminish 'skewer-css-mode))
;; (eval-after-load "skewer-html" '(diminish 'skewer-html-mode))
(eval-after-load "guide-key" '(diminish 'guide-key-mode))
(eval-after-load "volatile-highlights" '(diminish 'volatile-highlights-mode))
(eval-after-load "anzu" '(diminish 'anzu-mode))
(eval-after-load "subword" '(diminish 'subword-mode))

(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))

(rename-modeline "js2-mode" js2-mode "JS2")

(provide 'appearance)

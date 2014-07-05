(setq visible-bell t
      font-lock-maximum-decoration t
      color-theme-is-global t
      truncate-partial-width-windows nil)

;; Highlight current line
(global-hl-line-mode 1)

;; set font
;; default font
;; (set-default-font "-outline-DejaVu Sans Mono-normal-normal-normal-mono-15-*-*-*-c-*-iso8859-1")
;; (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-11.5"))
(add-to-list 'default-frame-alist '(font . "Inconsolata-13.5"))
(set-face-attribute 'default nil :font "Inconsolata-13.5")
;; (set-face-attribute 'default nil :font "Source Code Pro-11")
;; (set-face-attribute 'default nil :height 115 :font "DejaVu Sans Mono-11.5")

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
  (if (string= (frame-parameter nil 'font) "-unknown-Inconsolata-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")
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
(eval-after-load "paredit" '(diminish 'paredit-mode))
(eval-after-load "tagedit" '(diminish 'tagedit-mode))
(eval-after-load "skewer-mode" '(diminish 'skewer-mode))
(eval-after-load "skewer-css" '(diminish 'skewer-css-mode))
(eval-after-load "skewer-html" '(diminish 'skewer-html-mode))
(eval-after-load "guide-key" '(diminish 'guide-key-mode))

(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
        (setq mode-name ,new-name))))

(rename-modeline "js2-mode" js2-mode "JS2")

(provide 'appearance)

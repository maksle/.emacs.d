;; Highlight current line
(global-hl-line-mode 1)

;; set font
;; default font
;; (set-default-font "-outline-DejaVu Sans Mono-normal-normal-normal-mono-15-*-*-*-c-*-iso8859-1")
;; (add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-11.5"))
(add-to-list 'default-frame-alist '(font . "Inconsolata-13.5"))
;; (set-face-attribute 'default nil :font "Inconsolata-13.5")
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
  (if (string= (frame-parameter nil 'font) "Inconsolata")
      (use-presentation-theme)
    (use-default-theme)))

(global-set-key (kbd "C-<f9>") 'toggle-presentation-mode)

(use-default-theme)

(provide 'appearance)

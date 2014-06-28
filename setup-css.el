(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.less\\'" . css-mode))

;;; Colourise CSS colour literals
(when (eval-when-compile (>= emacs-major-version 24))
  ;; rainbow-mode needs color.el, bundled with Emacs >= 24.
  (require-package 'rainbow-mode)
  (dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook))
    (add-hook hook 'rainbow-mode)))

(require-package 'less-css-mode)

(add-hook 'css-mode-hook 'add-auto-complete-functionality)

;; Auto-complete CSS keywords
(defun add-auto-complete-functionality ()
  (provide 'setup-auto-complete)
  (after-load 'auto-complete
      (add-hook 'css-mode-hook 'ac-css-mode-setup)))

;; Use eldoc for syntax hints
(require-package 'css-eldoc)
(autoload 'turn-on-css-eldoc "css-eldoc")
(add-hook 'css-mode-hook 'turn-on-css-eldoc)

(provide 'setup-css)

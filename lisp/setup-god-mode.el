(require 'god-mode)

(global-set-key (kbd "<escape>") 'god-mode-all)

(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'box
                      'bar))
  ;; (if god-local-mode
  ;;     (set-cursor-color "PaleGreen")
  ;;   (set-cursor-color my-saved-cursor-face))
  )

(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)


(setq minor-mode-alist
      `(,@(assq-delete-all 'god-local-mode minor-mode-alist)
        (god-local-mode " ")
        (god-local-mode #("God" 0 3 (face (:foreground "yellow" :background "blue"))))))


(setq my-saved-mode-line-background (face-attribute 'mode-line :background))

(defun c/god-mode-update-cursor ()
  (let ((limited-colors-p (> 257 (length (defined-colors)))))
    (cond (god-local-mode (progn
                            (set-face-background 'mode-line "DarkOliveGreen4")))
          (t (progn
               (set-face-background 'mode-line my-saved-mode-line-background))))))

(add-hook 'god-mode-enabled-hook 'c/god-mode-update-cursor)
(add-hook 'god-mode-disabled-hook 'c/god-mode-update-cursor)


(defun god-toggle-on-overwrite ()
  "Toggle god-mode on overwrite-mode."
  (if (bound-and-true-p overwrite-mode)
      (god-local-mode-pause)
    (god-local-mode-resume)))

(add-hook 'overwrite-mode-hook 'god-toggle-on-overwrite)

(define-key god-local-mode-map (kbd "z") 'repeat)
(define-key god-local-mode-map (kbd "i") 'god-local-mode)
(define-key god-local-mode-map (kbd "h") 'backward-delete-char)

(global-set-key (kbd "C-x C-1") 'delete-other-windows)
(global-set-key (kbd "C-x C-2") 'split-window-below)
(global-set-key (kbd "C-x C-3") 'split-window-right)
(global-set-key (kbd "C-x C-0") 'delete-window)

(god-mode)

(provide 'setup-god-mode)

(defun skip-to-next-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (skip-syntax-forward " >")
    (unless (search-forward-regexp "^\\s *$" nil t)
      (goto-char (point-max)))))

(defun skip-to-previous-blank-line ()
  (interactive)
  (let ((inhibit-changing-match-data t))
    (skip-syntax-backward " >")
    (unless (search-backward-regexp "^\\s *$" nil t)
      (goto-char (point-min)))))

(defun html-wrap-in-tag (beg end)
  (interactive "r")
  (let ((oneline? (= (line-number-at-pos beg) (line-number-at-pos end))))
    (deactivate-mark)
    (goto-char end)
    (unless oneline? (newline-and-indent))
    (insert "</div>")
    (goto-char beg)
    (insert "<div>")
    (unless oneline? (newline-and-indent))
    (indent-region beg (+ end 11))
    (goto-char (+ beg 4))))

(defun --setup-simplezen ()
  (require 'simplezen)
  (set (make-local-variable 'yas-fallback-behavior)
       '(apply simplezen-expand-or-indent-for-tab)))

(add-hook 'sgml-mode-hook '--setup-simplezen)

(eval-after-load "sgml-mode"
  '(progn
     ;; don't include equal sign in symbols
     (modify-syntax-entry ?= "." html-mode-syntax-table)

     (define-key html-mode-map [remap forward-paragraph] 'skip-to-next-blank-line)
     (define-key html-mode-map [remap backward-paragraph] 'skip-to-previous-blank-line)
     (define-key html-mode-map (kbd "C-c C-w") 'html-wrap-in-tag)
     (define-key html-mode-map (kbd "/") nil) ;; no buggy matching of slashes

     ;; (define-key html-mode-map (kbd "C-c C-d") 'ng-snip-show-docs-at-point)

     (require 'tagedit)

     ;; paredit lookalikes
     (define-key html-mode-map (kbd "s-<left>") 'tagedit-forward-slurp-tag)
     (define-key html-mode-map (kbd "C-)") 'tagedit-forward-slurp-tag)
     (define-key html-mode-map (kbd "s-<right>") 'tagedit-forward-barf-tag)
     (define-key html-mode-map (kbd "C-}") 'tagedit-forward-barf-tag)
     (define-key html-mode-map (kbd "M-r") 'tagedit-raise-tag)
     (define-key html-mode-map (kbd "s-s") 'tagedit-splice-tag)
     (define-key html-mode-map (kbd "M-S") 'tagedit-split-tag)
     (define-key html-mode-map (kbd "M-J") 'tagedit-join-tags)
     (define-key html-mode-map (kbd "M-?") 'tagedit-convolute-tags)
     (define-key html-mode-map (kbd "M-k") 'tagedit-kill)

     (tagedit-add-experimental-features)
     (add-hook 'html-mode-hook (lambda () (tagedit-mode 1)))

     ;; no paredit equivalents
     (define-key html-mode-map (kbd "s-k") 'tagedit-kill-attribute)
     (define-key html-mode-map (kbd "s-<return>") 'tagedit-toggle-multiline-tag)))

;; after deleting a tag, indent properly
(defadvice sgml-delete-tag (after reindent activate)
  (indent-region (point-min) (point-max)))

;; toggle modes
;; (defun my-web-mode-hook ()
;;   "Hooks for Web mode."
;;   (setq web-mode-markup-indent-offset 4)
;;   (setq web-mode-css-indent-offset 4)
;;   (setq web-mode-code-indent-offset 4)
;; )
;; (add-hook 'web-mode-hook 'my-web-mode-hook)

(eval-after-load "html-mode"
  '(progn
     (defun toggle-jinja2-html-mode ()
       (interactive)
       "Toggle mode between web-mode and html-mode"
       (cond ((equal major-mode 'jinja2-mode)
              (html-mode))
             ((equal major-mode 'html-mode)
              (jinja2-mode))))

     (define-key html-mode-map [f5] 'toggle-jinja2-html-mode)
     (define-key jinja2-mode-map [f5] 'toggle-jinja2-html-mode)
     ))
(provide 'setup-html-mode)

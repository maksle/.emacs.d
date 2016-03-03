(defmacro after-load (feature &rest body)
  "After FEATURE is loaded, evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,feature
     '(progn ,@body)))

;; shorthand for interactive lambdas
(defmacro lam (&rest body)
  `(lambda ()
     (interactive)
     ,@body))

(defun my-shell-command-to-string (cmd)
  "Removes trailing newline from shell-command-to-string output"
  (substring (shell-command-to-string cmd) 0 -1))

(defun region-as-string ()
  (buffer-substring (region-beginning)
                    (region-end)))

(defun isearch-forward-use-region ()
  (interactive)
  (when (region-active-p)
    (add-to-history 'search-ring (region-as-string))
    (deactivate-mark))
  (call-interactively 'isearch-forward))

(defun isearch-backward-use-region ()
  (interactive)
  (when (region-active-p)
    (add-to-history 'search-ring (region-as-string))
    (deactivate-mark))
  (call-interactively 'isearch-backward))

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (call-interactively 'goto-line))
    (linum-mode -1)))

;; (defun url-get-qs (url)
;;   (let* ((urlobj (url-generic-parse-url url))
;;        (filename (url-filename urlobj))
;;        (qs-obj (cdr (s-split "?" filename))))
;;   (if qs-obj
;;       (url-parse-query-string (car qs-obj)))))

(defmacro comment (&rest ignore))

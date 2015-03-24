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

(defun url-get-qs (url)
  (let* ((urlobj (url-generic-parse-url url))
       (filename (url-filename urlobj))
       (qs-obj (cdr (s-split "?" filename))))
  (if qs-obj
      (url-parse-query-string (car qs-obj)))))

(defun form-amt-where-from-url-at-point ()
  (interactive)
  (let ((start (nth 8 (syntax-ppss)))
        (end (save-excursion
               (forward-sexp)
               (1+ (point)))))
    (form-amt-where (url-get-qs (buffer-substring start end)))))

(defun form-amt-where (qs)
  (interactive)
  (let (str)
    (--each qs
      (let ((key (car it))
            (val (cadr it)))
        (cond ((equal key "app")
               (setq str (concat "where app = '" val "'" str)))
              ((or (equal key "msg")
                   (equal key "topic"))
               (setq str (concat str " and " key " = '" val "'"))))))
    (message str)
    (kill-new str)
    str))

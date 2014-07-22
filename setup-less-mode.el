(if (getenv "CYGWIN")
    (eval-after-load "less-css-mode"
      '(progn
         (defun less-css-compile ()
           "Compiles the current buffer to css using `less-css-lessc-command'."
           (interactive)
           (message "Compiling less to css")
           (compile
            (mapconcat 'identity
                       (append (list (less-css--maybe-shell-quote-command less-css-lessc-command))
                               less-css-lessc-options
                               (list (shell-quote-argument
                                      (cygwin-convert-file-name-to-windows (or less-css-input-file-name buffer-file-name)))
                                     ">"
                                     (shell-quote-argument (cygwin-convert-file-name-to-windows (less-css--output-path)))))
                       " ")))
         )))

(provide 'setup-less-mode)

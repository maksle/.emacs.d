;; C-d to kill buffer if process is dead.
(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))

(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)))

(when (or (eq system-type "cygwin") (eq system-type "windows-nt"))
  (add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)
  (add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt nil t)
  (add-hook 'comint-output-filter-functions 'ansi-color-process-output nil t)
  (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

  (setq ansi-color-names-vector
        ["black" "red" "green" "yellow"
         "#729fcf" "magenta" "cyan" "white"])
  (setq ansi-color-map (ansi-color-make-color-map))

  ;; enable super and hyper keys on windows
  (setq w32-pass-lwindow-to-system nil
        w32-pass-rwindow-to-system nil
        w32-pass-apps-to-system nil
        w32-lwindow-modifier 'super ; Left Windows key
        w32-rwindow-modifier 'super ; Right Windows key
        w32-apps-modifier 'hyper)) ; Menu key

(provide 'setup-windows)

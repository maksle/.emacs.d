(add-to-list 'exec-path "/cygdrive/c/cygwin/bin")
(setq shell-file-name "/cygdrive/c/cygwin/bin/bash")
(setq explicit-shell-file-name shell-file-name)
(setq explicit-bash-args '("--login" "-i"))
(setenv "SHELL" shell-file-name)

(defun cmd-shell ()
  "Run windows shell"
  (interactive)
  (let ((explicit-shell-file-name "/cygdrive/c//WINDOWS/system32/cmd.exe"))
    (call-interactively 'shell)))

(add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt nil t)
(add-hook 'comint-output-filter-functions 'ansi-color-process-output nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; For subprocesses invoked via the shell (e.g., "shell -c command")
;; (setq shell-file-name explicit-shell-file-name)

;; (autoload 'bash-completion-dynamic-complete 
;;   "bash-completion"
;;   "BASH completion hook")
;; (add-hook 'shell-dynamic-complete-functions
;;   'bash-completion-dynamic-complete)
;; (add-hook 'shell-command-complete-functions
;;   'bash-completion-dynamic-complete)

;; C-d to kill buffer if process is dead.
(defun comint-delchar-or-eof-or-kill-buffer (arg)
  (interactive "p")
  (if (null (get-buffer-process (current-buffer)))
      (kill-buffer)
    (comint-delchar-or-maybe-eof arg)))

(add-hook 'shell-mode-hook
          (lambda ()
            (define-key shell-mode-map (kbd "C-d") 'comint-delchar-or-eof-or-kill-buffer)
            (make-local-variable 'face-remapping-alist)
            (face-remap-add-relative 'default :background "#300a24")))

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
      w32-apps-modifier 'hyper) ; Menu key

(provide 'setup-cygwin-shell)

(when (executable-find "gtags")
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode)
                (ggtags-mode 1)))))

;; C#
  (defun my-setup-csharp-mode-hook ()
     "function that runs when csharp-mode is initialized for a buffer."
     ;; (require 'flymake)
     ;; (flymake-mode 1)
     
     (c-set-style "c#")
     ;; (setenv "GTAGSLIBPATH" "/cygdrive/c/Users/xls")
  )
  (add-hook  'csharp-mode-hook 'my-setup-csharp-mode-hook t)


;; C++
(defun my-setup-cpp-mode-hook ()
  "my hook for cpp-mode"
  (interactive)
  (setq c-basic-offset 4)
  (c-set-style "stroustrup")
  (setenv "GTAGSLIBPATH" "/cygdrive/c/Users/xls.net"))

(add-hook 'c++-mode-hook 'my-setup-cpp-mode-hook)

(provide 'setup-c-modes)

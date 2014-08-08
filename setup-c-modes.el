(when (executable-find "gtags")
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'csharp-mode)
                (ggtags-mode 1)))))

;; C#
(add-hook  'csharp-mode-hook
           (lambda ()
             (c-set-style "c#")))

;; C++
(defun my-setup-cpp-mode-hook ()
  "my hook for cpp-mode"
  (interactive)
  (setq c-basic-offset 4)
  (c-set-style "stroustrup"))

(add-hook 'c++-mode-hook 'my-setup-cpp-mode-hook)

(provide 'setup-c-modes)

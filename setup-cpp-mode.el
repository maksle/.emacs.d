(defun my-setup-cpp-mode-hook ()
  "my hook for cpp-mode"
  (interactive)
  (setq c-default-style "linux")
  (setq c-basic-offset 4)
  (c-set-style "stroustrup"))

(add-hook 'c++-mode-hook 'my-setup-cpp-mode-hook)

(provide 'setup-cpp-mode)

(defun my-set-blacken-executable (&rest r)
  "Set `blacken-executable` to the black in the active virtualenv."
  (when python-shell-virtualenv-root
    (customize-set-variable 'blacken-executable
                            (concat (file-name-as-directory python-shell-virtualenv-root) "bin/black"))))

(defun my-reset-blacken-executable (&rest r)
  "Reset `blacken-executable` to its default value."
  (customize-set-variable 'blacken-executable "black"))

(advice-add 'pyenv-mode-set :after #'my-set-blacken-executable)
(advice-add 'pyenv-mode-unset :after #'my-reset-blacken-executable)

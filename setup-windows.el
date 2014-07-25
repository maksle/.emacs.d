(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq ansi-color-names-vector
      ["black" "red" "green" "yellow"
       "#729fcf" "magenta" "cyan" "white"])
(setq ansi-color-map '(ansi-color-make-color-map))

;; enable super and hyper keys on windows
(setq w32-pass-lwindow-to-system nil
      w32-pass-rwindow-to-system nil
      w32-pass-apps-to-system nil
      w32-lwindow-modifier 'super ; Left Windows key
      w32-rwindow-modifier 'super ; Right Windows key
      w32-apps-modifier 'hyper) ; Menu key

(provide 'setup-windows)

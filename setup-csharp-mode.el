(add-hook  'csharp-mode-hook
           (lambda ()
             (c-set-style "c#")
             (turn-on-auto-revert-mode)))

(add-to-list 'which-func-modes 'csharp-mode)

(provide 'setup-csharp-mode)

;; ;; (turn-on-font-lock)
;; ;; tabs are evil
;; (setq indent-tabs-mode nil)
;; (flymake-mode 1)
;; (yas/minor-mode-on)
;; ;; handy for flymake
;; (require 'rfringe) 
;; ;; also handy for flymake
;; (require 'flymake-cursor) 

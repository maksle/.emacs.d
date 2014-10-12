(defun --setup-simplezen ()
  (require 'simplezen)
  (set (make-local-variable 'yas-fallback-behavior)
       '(apply simplezen-expand-or-indent-for-tab)))

(defun my-nxml-mode-hook ()
  (setq
   sgml-basic-offset 4
   nxml-child-indent 4
   nxml-outline-child-indent 2)

  (when (string-match-p "/learn/xslt" (buffer-file-name))
    (visit-tags-table "~/Documents/learn/xslt/TAGS"  t)
    (require 'etags-update)
    (etags-update-mode))

  (require 'xslt-dep)
  (xslt-dep-mode)

  (--setup-simplezen)

  (define-key nxml-mode-map (kbd "C-c f") 'nxml-reformat-xml)
  (define-key nxml-mode-map (kbd "C-c w") 'nxml-where))

(add-hook 'nxml-mode-hook 'my-nxml-mode-hook)

;; (add-hook 'nxml-mode-hook '--setup-simplezen)
;; (setq sgml-basic-offset 4)

(provide 'setup-nxml-mode)

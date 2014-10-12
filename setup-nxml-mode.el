(add-hook 'nxml-mode-hook
          (lambda ()
            (setq
             nxml-child-indent 4
             nxml-outline-child-indent 2)
            (when (string-match-p "/learn/xslt" (buffer-file-name))
                  (visit-tags-table "~/Documents/learn/xslt/TAGS"  t)
                  (require 'etags-update)
                  (etags-update-mode))
            (define-key nxml-mode-map (kbd "C-c f") 'nxml-reformat-xml)
            (define-key nxml-mode-map (kbd "C-c w") 'nxml-where)))

(defun --setup-simplezen ()
  (require 'simplezen)
  (set (make-local-variable 'yas-fallback-behavior)
       '(apply simplezen-expand-or-indent-for-tab)))

(add-hook 'nxml-mode-hook '--setup-simplezen)

(setq sgml-basic-offset 4)



(provide 'setup-nxml-mode)



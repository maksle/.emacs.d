(add-hook 'nxml-mode-hook
          (lambda ()
            (setq
             nxml-child-indent 4
             nxml-outline-child-indent 2)
            (if (string-match-p "/server/docs" (buffer-file-name))
                (set (make-local-variable 'tags-table-list) "/usr/netscape/server/docs")
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



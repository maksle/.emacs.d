
(defun --setup-simplezen ()
  (require 'simplezen)
  (set (make-local-variable 'yas-fallback-behavior)
       '(apply simplezen-expand-or-indent-for-tab)))

;; Finally, prompt the user for a file name.
(setq default-tags-table-function (expand-file-name "/cygdrive/c/usr/netscape/server/docs/TAGS"))

(defun my-nxml-mode-hook ()
  (setq
   sgml-basic-offset 4
   nxml-child-indent 4
   nxml-outline-child-indent 2)

  (when (and (string-match-p "/cygdrive/c/usr/netscape/server/docs/" (buffer-file-name))
             (not (equal default-directory "/cygdrive/c/usr/netscape/server/docs/tmp/")))
    (visit-tags-table "/cygdrive/c/usr/netscape/server/docs/TAGS"  t)
    (require 'etags-update)
    (etags-update-mode))

  (require 'xslt-dep)
  (xslt-dep-mode)

  (--setup-simplezen)

  (define-key nxml-mode-map (kbd "C-c f") 'nxml-reformat-xml)
  (define-key nxml-mode-map (kbd "C-c w") 'nxml-where)

  (tagedit-mode)
  (require 'tagedit-nxml)
  (enable-tagedit-nxml)
  (tagedit-add-paredit-like-keybindings))

(add-hook 'nxml-mode-hook 'my-nxml-mode-hook)

;; (add-hook 'nxml-mode-hook '--setup-simplezen)
;; (setq sgml-basic-offset 4)

(provide 'setup-nxml-mode)


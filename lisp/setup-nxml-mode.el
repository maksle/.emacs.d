<<<<<<< HEAD:setup-nxml-mode.el
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
  (define-key nxml-mode-map (kbd "C-c w") 'nxml-where)

  (require 'tagedit)

  (tagedit-mode)
  (require 'tagedit-nxml)
  (enable-tagedit-nxml))

(add-hook 'nxml-mode-hook 'my-nxml-mode-hook)

;; (add-hook 'nxml-mode-hook '--setup-simplezen)
;; (setq sgml-basic-offset 4)

(provide 'setup-nxml-mode)
=======
(defun --setup-simplezen ()
  (require 'simplezen)
  (set (make-local-variable 'yas-fallback-behavior)
       '(apply simplezen-expand-or-indent-for-tab)))

(defun my-nxml-mode-hook ()
  (setq
   sgml-basic-offset 4
   nxml-child-indent 4
   nxml-outline-child-indent 2)

  (when (string-match-p "/cygdrive/c/usr/netscape/server/docs/" (buffer-file-name))
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
>>>>>>> 0332e1bc324f3d6b0eda0923518911b7fc8683bc:lisp/setup-nxml-mode.el

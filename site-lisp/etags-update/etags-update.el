;; etags-update-mode
;; 
;; Minor mode to update TAGS file on save. TAGS file used is head of
;; tags-table-list or otherwise tags-file-name.

(defvar etu/etags-update-options-alist
  '(("xsl" . "--lang=none --regex=@~/.emacs.d/site-lisp/etags-update/etags.xslt.regex"))
  "Additional parameters you can specify to etags --append
based on the file extension of the buffer/file on which you are
doing etags-update.")

(defun etu/get-tags-table ()
  "Figure out which TAGS table to modify. This gets the car of
tags-table-list, or if it is empty then tags-file-name"
  (let ((tagsfile (if (car tags-table-list)
                      (car tags-table-list)
                    tags-file-name)))
    (unless tagsfile (error "No TAGS table(s) active"))))

(defun etu/etags-update ()
  "Copy tags contents to tmp buffer, remove section(s) for this
buffer from TAGS file, run etags --append for buffer's file, and
if successful overwrite TAGS with the result. The TAGS file
chosen is the car of tags-table-list, or tags-file-name if
tags-table-file is empty."
  (let* ((tagspath (etu/get-tags-table))
         (tagstmppath (concat tagspath "TMP"))
         (thisbuf (buffer-file-name (current-buffer)))
         ;; buffer name relative to TAGS file dir
         (file-section (replace-regexp-in-string
                        (file-name-directory tagspath) ""
                        thisbuf)))
    (with-temp-buffer
      (insert-file-contents tagspath)
      (widen)
      (goto-char (point-min))
      (etu/etags-delete-file-section file-section)
      (write-region (point-min) (point-max) tagstmppath)
      (let ((cmd (format "cd %s; etags -o %s %s -a %s; mv %s %s"
                         (file-name-directory tagstmppath)
                         tagstmppath
                         (cdr (assoc (file-name-extension thisbuf) etags-options-alist))
                         file-section
                         tagstmppath
                         tagspath)))
        (start-process-shell-command "etags-append" "*etags-update*" cmd)
        (set-process-sentinel (get-process "etags-append")
                              (lambda (process status)
                                (if (string= status "finished\n")
                                    (message "Updated TAGS file %s..." (etu/get-tags-table))
                                  (error "Updating TAGS file failed. Event was %s. See buffer %s." event "*etags-update*"))))))))

(defun etu/etags-delete-file-section (filename)
  "Removes the section for filename in the active buffer, which
should be a copy of the TAGS file contents. Filename should be
relative to the TAGS directory path."
  (while (re-search-forward "\f" nil t)
    (if (looking-at-p (concat "\n" filename ",[0-9]+$"))
        (let ((del-start (match-beginning 0))
              (del-end (if (re-search-forward "\f" nil t)
                           (match-beginning 0)
                         (point-max))))
          (delete-region del-start del-end)))))

;;;###autoload
(define-minor-mode etags-update-mode
  "Update etags TAGS file on save. TAGS file should already
  exist. You are responsible for making sure the TAGS table is
  the correct one."
  :lighter " etu"
  (make-local-variable 'etu/etags-update-options-alist)
  (if etags-update-mode
      (add-hook 'after-save-hook 'etu/etags-update nil 'make-it-local)
    (remove-hook 'after-save-hook 'etu/etags-update 'make-it-local)))

(add-hook 'nxml-mode-hook 'etags-update-mode)

(provide 'etags-update-mode)

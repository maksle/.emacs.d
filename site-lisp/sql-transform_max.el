(defun sql-tx/split-line (line &optional sep)
  (setq sep (or sep sql-column-terminator))
  (list (s-split "" line)))

(defun sql-tx/get-table-columns ()
  (let ((table (read-string "Table: ")))
    (sql-send-string 
     (format "select column_name from xls.INFORMATION_SCHEMA.COLUMNS where table_name = '%s'" table))))

(defun sql-tx/result-to-insert-headings ()
  (sql-tx/split-line ))


(defun max/show-output (str)
  (sql-tx/split-line str ""))


(provide 'sql-transform-max)

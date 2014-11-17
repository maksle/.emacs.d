;; (require 'sql-transform-max)

(setq sql-column-terminator "")
(setq sql-ms-program "sqlcmd")
(setq sql-ms-options (list "-w" "65535" "-W" "-s" sql-column-terminator))

;; (add-hook 'sql-interactive-mode-hook
;;           (function (lambda ()

;;                       ;; (setq comint-output-filter-functions
;;                       ;;       (nconc comint-output-filter-functions '(max/show-output)))
;;                       )))

(provide 'setup-sql)

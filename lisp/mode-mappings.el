(add-to-list 'which-func-modes 'csharp-mode)
(add-to-list 'which-func-modes 'c++-mode)
(add-to-list 'which-func-modes 'c-mode)
(add-to-list 'which-func-modes 'python-mode)
(add-to-list 'which-func-modes 'sh-mode)

;; CSS
(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))
(add-to-list 'auto-mode-alist '("\\.less\\'" . less-css-mode))

;; js2
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))
(add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js2-mode))

;; Snippets
(add-to-list 'auto-mode-alist '("snippets" . snippet-mode))
(add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode))

;; Apache config
(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))
(add-to-list 'auto-mode-alist '("isapifilterrules\\.dat\\'" . apache-mode))

;; ASP mode
(autoload 'asp-mode "asp-mode")
(add-to-list 'auto-mode-alist '("\\.asp\\'" . web-mode))

;; nxml
(add-to-list 'auto-mode-alist '("\\.fo\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xslt\\'" . nxml-mode))

(provide 'mode-mappings)

;; Make C-S-backspace feel like it works when on VPN
(if (equal (symbol-name system-type) "windows-nt")
    (global-set-key (kbd "<C-backspace>") 'kill-whole-line))

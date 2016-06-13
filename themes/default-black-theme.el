(deftheme default-black
  "Automatically created 2013-05-20.")

(custom-theme-set-faces
 'default-black
 '(default ((t (:inherit nil :stipple nil :background "Black" :foreground "White" :inverse-video nil :box nil :strike-t*hrough nil :overline nil :underline nil :slant normal :weight normal :width normal :height 135))))
 '(highlight ((((class color) (min-colors 88) (background dark)) (:background "#111111"))))
 '(region ((nil (:background "#464740"))))
 '(hl-line ((nil (:background "#222222"))))
 '(yas-field-highlight-face ((nil (:background "#333399"))))
 '(js2-function-param ((t (:foreground "LightGoldenrod"))))
 '(js2-function-call ((t (:foreground
                          ;; (face-attribute 'font-lock-function-name-face :foreground)
                          "LightBlue"
                          ))))
 ;; '(js2-object-property ((t (:foreground "wheat1"))))
 '(js2-object-property ((t (:foreground "LemonChiffon2"))))
 '(font-lock-warning-face ((nil (:foreground "#ff6666"))))
 '(show-paren-match ((nil (:background "#333399"))))
 '(show-paren-mismatch ((((class color)) (:background "red")))))

(provide-theme 'default-black)

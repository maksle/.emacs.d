(add-hook 'nxml-mode-hook
          (lambda ()
            (setq xd/deps-dot-shell-file "/home/mgrinman/scripts/xslt-dep.sh")
            (setq xd/deps-dot-file "/cygdrive/c/Temp/xslt-deps.dot")
            (setq xd/deps-dot-output "/cygdrive/c/Temp/xslt-deps.png")
            (setq xd/deps-replacements '(("/cygdrive/c/usr/netscape/server/docs/" . "$xls/docs/")))))

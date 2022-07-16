(setq doom-theme 'doom-nord)
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 14))
(add-hook! 'emacs-startup-hook #'doom-init-ui-h)
(defun +rjsx-electric-gt-fragment-a (n)
  (if (or (/= n 1) (not (and (eq (char-before) ?<) (eq (char-after) ?/)))) 't
    (insert ?> ?<)
    (backward-char)))
(advice-add #'rjsx-electric-gt :before-while #'+rjsx-electric-gt-fragment-a)
(add-to-list 'auto-mode-alist '(".*\\.tsx\\'" . rjsx-mode))
(use-package! lsp-tailwindcss
  :init
  (setq lsp-tailwindcss-add-on-mode t))
(setq lsp-html-format-end-with-newline t)

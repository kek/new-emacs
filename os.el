(cond 
 ((eq system-type 'darwin)
  (progn
    (defun my/fix-mac-unicode ()
      (set-fontset-font t '(#x1f000 . #x1faff) (font-spec :family "Apple Color Emoji"))
      (add-to-list 'face-font-rescale-alist (cons "Apple Color Emoji" 0.80) t))
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
    (add-to-list 'default-frame-alist '(ns-appearance . dark))
    (setq mac-command-modifier 'meta
	  mac-option-modifier 'none
	  ns-use-proxy-icon nil
	  frame-title-format nil
          ;; mac-command-modifier 'meta
          mac-option-modifier 'none
	  insert-directory-program "/opt/homebrew/bin/gls")
    (my/fix-mac-unicode)
    (add-hook 'emacs-startup-hook #'my/fix-mac-unicode))))

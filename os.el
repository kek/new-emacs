(cond 
 ((eq system-type 'darwin)
  (progn
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
    (add-to-list 'default-frame-alist '(ns-appearance . dark))
    (setq mac-command-modifier 'meta
	  mac-option-modifier 'none
	  ns-use-proxy-icon nil
	  frame-title-format nil
          ;; mac-command-modifier 'meta
          mac-option-modifier 'none))))

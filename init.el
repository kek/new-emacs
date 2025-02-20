(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'none)

(load (concat user-emacs-directory "packages.el"))

(set-frame-font "Hack Nerd Font Mono" nil t)
(set-face-attribute 'default nil :font "Hack Nerd Font Mono" :height 150)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8d3ef5ff6273f2a552152c7febc40eabca26bae05bd12bc85062e2dc224cde9a"
     default))
 '(make-backup-files nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

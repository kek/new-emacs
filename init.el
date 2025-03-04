(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)
(global-hl-line-mode 1)
(toggle-truncate-lines +1)
 
(defun my/set-font ()
  (set-frame-font "Hack Nerd Font Mono" nil t)
  (let ((font-size (if (eq system-type 'darwin) 140 120)))
    (set-face-attribute 'default nil :font "Hack Nerd Font Mono" :height font-size)))

(defun my/load-file (file)
  (let ((path (concat user-emacs-directory file)))
    (if (file-exists-p path)
	(load path)
      (message "%s not found" path))))

(my/load-file "packages.el")
(my/load-file "os.el")
(my/load-file "keys.el")
;;(setq default-frame-alist '((width . 80) (height . 55) (menu-bar-lines . 1)))

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

(add-to-list 'auto-mode-alist '("\\.kdl\\'" . prog-mode))
(add-to-list 'auto-mode-alist '("\\.jsonc\\'" . js-json-mode))

(require 'org-protocol)
(unless (server-running-p)
  (server-start))


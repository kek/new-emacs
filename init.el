(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)
(global-hl-line-mode 1)
(recentf-mode 1)
(setq history-length 25)
(savehist-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(global-display-line-numbers-mode 1)
(global-display-fill-column-indicator-mode 0)

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

(setq my/home-directory (getenv "HOME"))
(setq my/org-directory (concat my/home-directory "/Documents/org/pages"))

(setq org-capture-templates
      `(
	("n" "Note" entry
	 (file+headline ,(concat my/org-directory "/" "notes.org") "Inbox")
	 "* %? %U"
	 :prepend t
	 :jump-to-captured t
	 )
	("L" "Protocol Link" entry
	 (file+headline ,(concat my/org-directory "/" "notes.org") "Inbox")
	 "* [[%:link][%:description]] %U%?"
	 :prepend t
	 :immediate-finish t
	 :jump-to-captured t)
	)
      )

(unless (server-running-p)
  (server-start))


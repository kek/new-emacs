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
(global-display-line-numbers-mode -1)
(global-display-fill-column-indicator-mode 0)

(defun my/set-font ()
  (set-frame-font "Hack Nerd Font Mono" nil t)
  (let ((font-size (if (eq system-type 'darwin) 150 120)))
    (set-face-attribute 'default nil :font "Hack Nerd Font Mono" :height font-size)))

(defun my/load-file (file)
  (let ((path (concat user-emacs-directory file)))
    (if (file-exists-p path)
	(load path)
      (message "%s not found" path))))

(my/load-file "packages.el")
(my/load-file "os.el")
(my/load-file "keys.el")

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

(add-to-list 'auto-mode-alist '("\\.kdl\\'" . prog-mode))
(add-to-list 'auto-mode-alist '("\\.jsonc\\'" . js-json-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-ts-mode))

(require 'org-protocol)

(setq my/home-directory (getenv "HOME"))
(setq my/org-directory (concat my/home-directory "/Documents/org/pages"))

(setq org-capture-templates
      `(
	("n" "Note" entry
	 (file+headline ,(concat my/org-directory "/" "notes.org") "Inbox")
	 "* %? %U"
	 :prepend t
	 )
	("L" "Protocol Link" entry
	 (file+headline ,(concat my/org-directory "/" "notes.org") "Inbox")
	 "* [[%:link][%:description]] %U%?"
	 :prepend t
	 :immediate-finish t
	 :jump-to-captured t)
	)
      )

(add-hook 'prog-mode-hook (lambda () (setq truncate-lines 1)))
(add-hook 'org-mode-hook (lambda () (visual-line-mode 1)))
(add-hook 'deft-mode-hook (lambda () (truncate-lines -1)))

(unless (server-running-p)
  (server-start))

(load "~/.secrets.el" 'noerror 'nomessage)

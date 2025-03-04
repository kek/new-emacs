(global-set-key (kbd "<f6>") #'magit-status)

(global-set-key (kbd "<f8>")
		(lambda () "Open todo file" (interactive)
		  (find-file (concat deft-directory "/notes.org"))))
(global-set-key (kbd "M-<f8>") #'deft)
(global-set-key (kbd "<f9>") (lambda () "" (interactive) (org-capture nil "n")))

(global-set-key (kbd "<f5>")
		(lambda () "Open init file" (interactive)
		  (find-file (concat user-emacs-directory "init.el"))))

(global-set-key (kbd "M-<f12>") #'recentf)
(global-set-key (kbd "S-<f12>") #'projectile-switch-project)
(global-set-key (kbd "<f12>") #'projectile-find-file-dwim)
(global-set-key (kbd "C-<f12>") #'projectile-invalidate-cache)

(global-set-key (kbd "C-<f5>") #'my/toggle-theme)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(defvar my/theme 'dark)

(defun my/dark-theme ()
  (load-theme 'doom-moonlight t)
  (setq my/theme 'dark))

(defun my/light-theme ()
  (load-theme 'leuven t)
  (setq my/theme 'light))

(defun my/toggle-theme () (interactive)
  (cond ((eq my/theme 'light)
	 (my/dark-theme))
	((eq my/theme 'dark)
	 (my/light-theme))))

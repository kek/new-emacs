(global-set-key (kbd "<f5>") #'deft)
(global-set-key (kbd "<f6>") #'magit-status)
(global-set-key (kbd "<f8>")
		(lambda () "Open todo file" (interactive)
		  (find-file (concat user-emacs-directory "todo.org"))))
(global-set-key (kbd "<f9>")
		(lambda () "Open init file" (interactive)
		  (find-file (concat user-emacs-directory "init.el"))))
(global-set-key (kbd "<M-f12>") #'recentf)
(global-set-key (kbd "<f12>") #'projectile-find-file-dwim)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(defvar my/theme 'dark)

(defun my/dark-theme ()
  (load-theme 'doom-wilmersdorf t)
  (setq my/theme 'dark))

(defun my/light-theme ()
  (load-theme 'doom-earl-grey t)
  (setq my/theme 'light))

(defun my/toggle-theme () (interactive)
  (cond ((eq my/theme 'light)
	 (my/dark-theme))
	((eq my/theme 'dark)
	 (my/light-theme))))

(global-set-key (kbd "C-<f12>") #'my/toggle-theme)

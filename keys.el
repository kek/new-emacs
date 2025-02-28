(global-set-key (kbd "<f5>") #'deft)
(global-set-key (kbd "<f6>") #'magit-status)
(global-set-key (kbd "<f8>")
		(lambda () "Open todo file" (interactive)
		  (find-file (concat user-emacs-directory "todo.org"))))
(global-set-key (kbd "<f9>")
		(lambda () "Open init file" (interactive)
		  (find-file (concat user-emacs-directory "init.el"))))

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

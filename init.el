(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'none)

(load (concat user-emacs-directory "packages.el"))

(set-frame-font "Hack Nerd Font Mono" nil t)
(set-face-attribute 'default nil :font "Hack Nerd Font Mono" :height 140)

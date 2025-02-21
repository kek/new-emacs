(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package which-key :straight t
  :config (which-key-mode 1))

(use-package doom-themes
  :straight t
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-moonlight t)
  (my/set-font)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package exec-path-from-shell :straight t
  :config (progn
	    (exec-path-from-shell-initialize)))

(use-package magit :straight t)

(use-package vertico :straight t
  :config (vertico-mode 1))

(use-package lsp-mode :straight t
  :hook ((elixir-mode . lsp)
	 (erlang-mode . lsp)
	 (lua-mode . lsp)
	 (go-mode . lsp))
  :init
  ;; https://emacs.stackexchange.com/questions/81247/with-lsp-mode-why-do-i-get-an-unknown-notification-about-refreshed-rules-from-s
  (with-eval-after-load 'lsp-mode
    (defun my/lsp-ignore-semgrep-rulesRefreshed (workspace notification)
      "Ignore semgrep/rulesRefreshed notification."
      (when (equal (gethash "method" notification) "semgrep/rulesRefreshed")
	;;(lsp--info "Ignored semgrep/rulesRefreshed notification")
	t)) ;; Return t to indicate the notification is handled
    (advice-add 'lsp--on-notification :before-until #'my/lsp-ignore-semgrep-rulesRefreshed))
  (setq lsp-keymap-prefix "C-c l"))

(use-package lsp-ui :straight t)
(use-package company :straight t
  :init (global-company-mode))

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
  (if (eq system-type 'gnu/linux)
      (load-theme 'doom-sourcerer t)
    (load-theme 'doom-moonlight t))
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
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (lsp-mode . lsp-enable-which-key-integration))

(use-package lsp-ui :straight t)
  
(use-package company :straight t
  :init (global-company-mode))

(use-package go-mode :straight t)

(use-package elixir-mode :straight t)

(setq scroll-conservatively 1)

;; https://github.com/oantolin/orderless
;; https://github.com/minad/vertico
(use-package orderless :straight t
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic substring partial-completion flex))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package deft :straight t)

(use-package lua-mode :straight t)

(use-package multiple-cursors :straight t)

(defun embark-hide-which-key-indicator (fn &rest args)
    "Hide the which-key indicator immediately when using the completing-read prompter."
    (which-key--hide-popup-ignore-command)
    (let ((embark-indicators
           (remq #'embark-which-key-indicator embark-indicators)))
      (apply fn args)))

(defun embark-which-key-indicator ()
  "An embark indicator that displays keymaps using which-key.
The which-key help message will show the type and value of the
current target followed by an ellipsis if there are further
targets."
  (lambda (&optional keymap targets prefix)
    (if (null keymap)
        (which-key--hide-popup-ignore-command)
      (which-key--show-keymap
       (if (eq (plist-get (car targets) :type) 'embark-become)
           "Become"
         (format "Act on %s '%s'%s"
                 (plist-get (car targets) :type)
                 (embark--truncate-target (plist-get (car targets) :target))
                 (if (cdr targets) "…" "")))
       (if prefix
           (pcase (lookup-key keymap prefix 'accept-default)
             ((and (pred keymapp) km) km)
             (_ (key-binding prefix 'accept-default)))
         keymap)
       nil nil t (lambda (binding)
                   (not (string-suffix-p "-argument" (cdr binding))))))))

(use-package embark
  :straight t
  :bind (("C-." . embark-act)
	 ("C-;" . embark-dwim)
	 ("C-h B" . embark-bindings))
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none))))
  :init
  ;; (setq prefix-help-command #'embark-prefix-help-command)
  (setq prefix-help-command #'which-key-C-h-dispatch)
  (setq embark-indicators
	'(embark-which-key-indicator
	  embark-highlight-indicator
	  embark-isearch-highlight-indicator))

  (advice-add #'embark-completing-read-prompter
              :around #'embark-hide-which-key-indicator))

(use-package embark-consult
  :straight t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package projectile :straight t)

(use-package smooth-scroll :straight t
  :config
  (smooth-scroll-mode)
  ;;(setq scroll-step 0)
  (setq scroll-conservatively 101)
  (global-set-key (kbd "C-M-v") #'smooth-scroll/orig-scroll-other-window)
  (global-set-key (kbd "C-S-M-v") #'smooth-scroll/orig-scroll-other-window-down))

(use-package yasnippet :straight t
  :init (yas-global-mode 1))


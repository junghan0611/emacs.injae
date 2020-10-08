(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-package-update-delete-old-versions t)
 '(auto-package-update-prompt-before-update t)
 '(ccls-extra-init-params '(:client (:snippetSupport :json-false)) t)
 '(ccls-sem-highlight-method 'font-lock)
 '(ccls-use-default-rainbow-sem-highlight nil t)
 '(company--transform-candidates nil t)
    '(company-box-icons-functions
         '(company-box-icons--yasnippet company-box-icons--lsp company-box-icons--eglot company-box-icons--elisp company-box-icons--acphp company-box-icons--cider))
 '(company-dabbrev-downcase nil)
 '(company-idle-delay 0)
 '(company-lsp-async t)
 '(company-lsp-cache-candidates nil)
 '(company-lsp-enable-recompletion nil)
 '(company-lsp-enable-snippet t)
 '(company-minimum-prefix-length 1)
 '(company-tooltip-align-annotations nil)
 '(counsel-find-file-ignore-regexp ".ccls-cache/")
 '(create-lockfiles nil)
 '(dart-enable-analysis-server t t)
 '(dart-format-on-save t t)
 '(dart-sdk-path "/Users/nieel/dev/flutter/bin/cache/dart-sdk/" t)
 '(docker-image-run-arguments '("-i" (\, "-t") (\, "--rm")) t)
 '(doom-modeline-mode t)
 '(dumb-jump-default-project "~/build" t)
 '(dumb-jump-force-searcher 'rg t)
 '(dumb-jump-selector 'ivy t)
 '(enable-recursive-minibuffers t)
 '(evil-symbol-word-search t)
 '(evil-want-C-u-scroll t)
 '(evil-want-integration t)
 '(evil-want-keybinding nil)
 '(exec-path-from-shell-arguments nil)
 '(exec-path-from-shell-initialize nil t)
 '(exec-path-from-shell-variables '("PATH"))
 '(flycheck-clang-language-standard "c++17")
 '(git-gutter:added-sign "+" t)
 '(git-gutter:deleted-sign "-" t)
 '(git-gutter:lighter " gg" t)
 '(git-gutter:modified-sign "." t)
 '(git-gutter:window-width 1 t)
 '(ivy-count-format "(%d/%d) ")
 '(ivy-display-style 'fancy)
 '(ivy-format-function 'ivy-format-function-line t)
 '(ivy-height 20)
 '(ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
 '(ivy-posframe-height-alist '((t . 20)))
 '(ivy-posframe-parameters '((internal-border-width . 10)))
 '(ivy-posframe-width 120)
 '(ivy-re-builders-alist '((counsel-M-x . ivy--regex-fuzzy) (t . ivy--regex-plus)) t)
 '(ivy-rich-parse-remote-buffer nil)
 '(ivy-use-selectable-prompt t)
 '(ivy-use-virtual-buffers t)
 '(keypression-cast-command-name t t)
 '(keypression-cast-coommand-name-format "%s  %s" t)
 '(keypression-combine-same-keystrokes t t)
 '(keypression-fade-out-delay 1.0 t)
 '(keypression-font-face-attribute '(:width normal :height 200 :weight bold) t)
 '(keypression-frame-background-mode 'white t)
 '(keypression-frame-justify 'keypression-left-fringe t)
 '(keypression-frames-maxnum 20 t)
 '(keypression-use-child-frame t t)
 '(lsp-completion-enable t)
 '(lsp-enable-snippet t)
 '(lsp-file-watch-threshold nil)
 '(lsp-inhibit-message t t)
 '(lsp-message-project-root-warning t t)
 '(lsp-prefer-flymake nil t)
 '(lsp-ui-flycheck-enable t t)
 '(org-agenda-files nil)
 '(org-pomodoro-ask-upon-killing t t)
 '(org-pomodoro-format "%s" t)
 '(org-pomodoro-long-break-format "%s" t)
 '(org-pomodoro-short-break-format "%s" t)
    '(package-selected-packages
         '(evil explain-pause-mode company-godot-gdscript gdscript-mode emacsql-sqlite3 org-roam keypression tide xref-js2 rjsx-mode aggressive-indent elisp-bug-hunter bug-hunter lsp-ivy ivy-lsp counsel-osx-app ivy-posframe ivy-postframe ns-auto-titlebar forge nadvice base16-theme ivy-rich vterm-toggle web-mode dumb-jump go-mode company-shell flutter dart-mode elpy company-jedi pyenv-mode-auto pyenv-mode pyvenv easy-jekyll gh-md markdown-preview-mode company-racer flycheck-rust dap-mode ivy-rtags auto-yasnippet quick-peek company-lsp lsp-ui lsp-mode company-statistics company-quickhelp poly-org try wgrep google-translate google-this page-break-lines emojify command-log-mode esh-help vterm poet-theme typo olivetti ob-restclient calfw orgtbl-aggregate org-gcal gitattributes-mode gitconfig-mode gitignore-mode counsel-tramp all-the-icons-ivy ivy-yasnippet swiper hydra all-the-icons git-gutter elmacro evil-numbers evil-matchit evil-goggles evil-indent-plus evil-surround esup goto-last-change drag-stuff restart-emacs slime evil-args evil-nerd-commenter evil-traces centaur-tabs epc company-restclient restclient no-littering mmm-mode evil-extra-operator polymode poly-mode window-purpose emacs-purpose purpose parinfer magit-todos magit-todo smeargle evil-lion evil-exchange writeroom-mode disaster all-the-icons-dired evil-iedit-state pdf-tools counsel-spotify company-box company-flx eshell-did-you-mean highlight-indentation ivy-historian historian counsel-world-clock counsel-org-clock ivy-xref counsel-projectile flyspell-correct-ivy ivy-smex counsel ivy org-pomodoro hide-mode-line flycheck-inline spaceline-colors helm-smex smex company-tabnine toml-mode diminish magithub evil-org org-agenda org-mode eshell-up fish-completion esh-autosuggest shell-pop virtualenvwrapper eshell-prompt-extras exec-path-from-shell exec-path-from-eshell symon tabbar dashboard irony rtags helm spaceline smartparens evil-ediff evil-magit evil-smartparens-keybindings ialign helm-swoop flycheck-irony flycheck-rtags flycheck-pos-tip flycheck helm-dash dash-functional buffer-move rust-mode helm-rtags irony-eldoc yasnippet-snippets zenburn-theme yasnippet yaml-mode xpm window-layout which-key use-package spacemacs-theme spaceline-all-the-icons rg rainbow-mode rainbow-delimiters racer python-mode nyan-mode neotree multi-term mode-icons major-mode-icons magit indent-guide helm-projectile helm-descbinds helm-company haskell-mode god-mode git-gutter-fringe flymake-rust fancy-battery eyebrowse evil-smartparens evil-multiedit evil-leader emamux elisp-slime-nav doom-modeline dockerfile-mode docker discover-my-major delight company-rtags company-irony-c-headers company-irony company-c-headers cmake-mode cmake-ide clang-format cargo boxquote beacon ace-window))
 '(projectile-completion-system 'ivy)
 '(python-indent-offset 4 t)
 '(ruby-indent-level 4 t)
 '(ruby-indent-tabs-mode nil t)
 '(scroll-margin 0)
 '(shell-pop-full-span t t)
 '(shell-pop-term-shell "/bin/zsh" t)
 '(spaceline-all-the-icons-icon-set-git-ahead 'commit)
 '(spaceline-all-the-icons-icon-set-modified 'toggle)
 '(spaceline-all-the-icons-icon-set-window-numbering 'square)
 '(spaceline-all-the-icons-primary-separator "|")
 '(spaceline-all-the-icons-separator-type 'slant)
 '(spaceline-all-the-icons-separators-invert-direction t)
 '(spaceline-all-the-icons-window-number-always-visible t)
 '(use-package-compute-statistics t)
 '(yas-snippet-dirs '("~/.emacs.d/yas/")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-error ((t nil)))
 '(evil-ex-substitute-matches ((t (:inherit diff-removed :foreground unspecified :background unspecified))))
 '(evil-ex-substitute-replacement ((t (:inherit diff-added :foreground unspecified :background unspecified))))
 '(evil-traces-change ((t (:inherit diff-removed))))
 '(evil-traces-copy-preview ((t (:inherit diff-added))))
 '(evil-traces-copy-range ((t (:inherit diff-changed))))
 '(evil-traces-delete ((t (:inherit diff-removed))))
 '(evil-traces-global-match ((t (:inherit diff-added))))
 '(evil-traces-global-range ((t (:inherit diff-changed))))
 '(evil-traces-join-indicator ((t (:inherit diff-added))) t)
 '(evil-traces-join-range ((t (:inherit diff-changed))))
 '(evil-traces-move-preview ((t (:inherit diff-added))))
 '(evil-traces-move-range ((t (:inherit diff-removed))))
 '(evil-traces-normal ((t (:inherit diff-changed))))
 '(evil-traces-shell-command ((t (:inherit diff-changed))))
 '(evil-traces-substitute-range ((t (:inherit diff-changed))))
 '(evil-traces-yank ((t (:inherit diff-changed))))
 '(mode-line ((t (:background "#1c1e24" :box nil))))
 '(mode-line-buffer-id ((t nil)))
 '(mode-line-emphasis ((t (:foreground "#51afef"))))
 '(mode-line-highlight ((t (:inherit highlight))))
 '(mode-line-inactive ((t (:background "#1d2026" :foreground "#5B6268" :box nil))))
 '(org-pomodoro-mode-line ((t (:foreground "#ff5555"))))
 '(org-pomodoro-mode-line-break ((t (:foreground "#50fa7b"))))
 '(spaceline-all-the-icons-info-face ((t (:foreground "wheat" :overline "black"))))
 '(spaceline-all-the-icons-sunrise-face ((t (:inherit powerline-active2 :foreground "#f6c175"))))
 '(spaceline-all-the-icons-sunset-face ((t (:inherit powerline-active2 :foreground "#fe7714"))))
 '(spaceline-highlight-face ((t (:background "DarkGoldenrod2" :foreground "#3E3D31" :inherit 'mode-line)))))

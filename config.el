(add-to-list 'load-path "~/.emacs.d/lisp/")
(setq-default custom-file (expand-file-name ".config.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))

(setq *is-mac* (eq system-type 'darwin))
(setq *is-windows* (eq system-type 'windows-nt))
(setq *is-cygwin*  (eq system-type 'cygwin))
(setq *is-linux*   (or (eq system-type 'gnu/linux) (eq system-type 'linux)))
(setq *is-unix*    (or *is-linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)))

(when window-system
    (tool-bar-mode -1)
    (menu-bar-mode -1)
    (if (boundp 'fringe-mode)     (fringe-mode -1))
    (if (boundp 'scroll-bar-mode) (scroll-bar-mode -1))
    (tooltip-mode -1)
    ;; 마우스 사용가능
    (xterm-mouse-mode)
    ;; default window size options
    ;(if (display-graphic-p)
    ;    (progn
    ;    (setq initial-frame-alist
    ;            '(
    ;            (tool-bar-lines . 0)
    ;            (width . 200) ; chars
    ;            (height . 60) ; lines
    ;            (left . 100)
    ;            (top . 60)))
    ;    (setq default-frame-alist
    ;            '(
    ;            (tool-bar-lines . 0)
    ;            (width . 200)
    ;            (height . 60)
    ;            (left . 100)
    ;            (top . 60))))
    ;(progn
    ;    (setq initial-frame-alist '( (tool-bar-lines . 0)))
    ;    (setq default-frame-alist '( (tool-bar-lines . 0)))))
)

(setq scroll-step 1)
(setq scroll-conservatively 10000)

(setq backup-inhibited t)
(setq auto-save-default nil)
(setq make-backup-files nil)

(set-frame-parameter nil 'alpha 0.95)
(setq compilation-window-height 15)
(set-variable 'cursor-type '(hbar . 10))

;; No popup frame
(setq pop-up-frames nil)
(setq ring-bell-function 'ignore)
; layout save setting
(winner-mode t)
;(desktop-save-mode 1)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)
(setq inhibit-splash-screen t)
(setq echo-keystrokes 0.5)
(setq global-hl-line-mode +1)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode)

;; +------------+------------+
;; | 일이삼사오 | 일이삼사오 |
;; |------------+------------|
;; | 1234567890 | 1234567890 |
;; +------------+------------+
;; | abcdefghij | abcdefghij |
;; +------------+------------+
;; text utf-8 setting
(set-language-environment "Korean")
(prefer-coding-system 'utf-8)
(setq locale-coding-system   'utf-8)
(set-terminal-coding-system  'utf-8)
(set-keyboard-coding-system  'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(set-face-attribute   'default            nil       :family "DejaVu Sans Mono" :height 110)
(set-fontset-font nil 'hangul            (font-spec :family "D2Coding" :pixelsize 18))
(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "D2Coding" :pixelsize 18))
(setq face-font-rescale-alist '(("D2coding" . 1.2)))
(setq-default line-spacing 3)
(global-font-lock-mode t)

;; 한글입력할때 완성전까지 안보이는 문제 해결을 위해 내장 한글입력기 사용
; Linux 내장 한글입력기 사용법 
; ~/.Xresources 만들고 그안에 Emacs*useXIM: false 입력
; 터미널에 xrdb ~/.Xresources 하고 xrdb -merge ~/.Xresources 하고 이맥스 다시키면 됨
(setq default-korean-keyboard 'korean-hangul2)
(global-set-key [?\S- ] 'toggle-input-method)
;(global-set-key [kbd "<Hangul>"] 'toggle-input-method)

(defun launch-separate-emacs-in-terminal ()
(suspend-emacs "fg ; emacs -nw"))

(defun launch-separate-emacs-under-x ()
(call-process "sh" nil nil nil "-c" "emacs &"))

(defun restart-emacs ()
    (interactive)
    ;; We need the new emacs to be spawned after all kill-emacs-hooks
    ;; have been processed and there is nothing interesting left
    (let ((kill-emacs-hook (append kill-emacs-hook (list (if (display-graphic-p) #'launch-separate-emacs-under-x
                                                                                 #'launch-separate-emacs-in-terminal)))))
         (save-buffers-kill-emacs))
)

(defun sudo-find-file (file-name)
  "sudo open"
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))
 (use-package sudo :after evil-leader
 :init (evil-leader/set-key "fs" #'sudo-find-file))

(use-package paradox :ensure t :pin melpa
;https://github.com/Malabarba/paradox
:init (setq paradox-github-token "e1a1518b1f89990587ec97b601a1d0801c5a40c6")
)

(use-package move-text :ensure t :pin melpa
;https://github.com/emacsfodder/move-text
:init (move-text-default-bindings)
)

(use-package goto-last-change :ensure t :pin melpa
;https://github.com/camdez/goto-last-change.el
:init (evil-leader/set-key "fl" 'goto-last-change)
)

(use-package esup :ensure t :pin melpa
:init 
)

(server-start)

(use-package beacon :ensure t :init (beacon-mode t)) 
(use-package git-gutter :ensure t
:init 
    (setq-default display-line-numbers-width 2)
    (global-git-gutter-mode t)
    (global-display-line-numbers-mode t)
    (global-hl-line-mode t)
:config
    (setq git-gutter:lighter " gg")
    (setq git-gutter:window-width 1)
    (setq git-gutter:modified-sign ".")
    (setq git-gutter:added-sign    "+")
    (setq git-gutter:deleted-sign  "-")
    (set-face-foreground 'git-gutter:added    "#daefa3")
    (set-face-foreground 'git-gutter:deleted  "#FA8072")
    (set-face-foreground 'git-gutter:modified "#b18cce")
)

(use-package doom-themes :ensure t :pin melpa
:init (load-theme 'doom-one t)
:config
    (doom-themes-neotree-config)
    (doom-themes-org-config)
)

;(load-library "hideshow")
;    (global-set-key (kbd "<C-l>") 'hs-show-block)
;    (global-set-key (kbd "<C-h>") 'hs-hide-block)
;    (add-hook 'c-mode-common-hook     'hs-minor-mode)
;    (add-hook 'emacs-lisp-mode-hook   'hs-minor-mode)
;    (add-hook 'java-mode-hook         'hs-minor-mode)
;    (add-hook 'lisp-mode-hook         'hs-minor-mode)
;    (add-hook 'perl-mode-hook         'hs-minor-mode)
;    (add-hook 'sh-mode-hook           'hs-minor-mode)

;(use-package aggressive-indent :ensure t :pin melpa
;https://github.com/Malabarba/aggressive-indent-mode
;:init (global-aggressive-indent-mode)
      ;exclud mode
      ;(add-to-list 'aggresive-indent-excluded-modes 'html-mode)
;)

(use-package indent-guide :ensure t
:init ;(indent-guide-global-mode)
:config
    (setq indent-guide-char      "|")
    (setq indent-guide-recursive t)
    ;(set-face-background 'indent-guide-face "dimgray")
    ;(setq indent-guide-delay     0.1)
)
(defun my-set-indent (n)
    (setq-default tab-width n)
    ;(electric-indent-mode n)
    (setq c-basic-offset n)
    (setq lisp-indent-offset n)
    (setq indent-line-function 'insert-tab)
)
(my-set-indent 4)
(setq-default indent-tabs-mode nil)
(electric-indent-mode nil)

(defun un-indent-by-removing-4-spaces ()
    "back tab"
    (interactive)
    (save-excursion
    (save-match-data
    (beginning-of-line)
        ;; get rid of tabs at beginning of line
    (when (looking-at "^\\s-+")
    (untabify (match-beginning 0) (match-end 0)))
        (when (looking-at "^    ")
            (replace-match "")))
        )
)
(global-set-key (kbd "<backtab>") 'un-indent-by-removing-4-spaces)
;(use-package highlight-indent-guides :ensure t
;    :init (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;    :config 
;       (setq highlight-indent-guides-method 'character)
;       ;(set-face-background 'highlight-indent-guides-odd-face       "darkgray")
;       ;(set-face-background 'highlight-indent-guides-even-face      "dimgray" )
;       ;(set-face-background 'highlight-indent-guides-character-face "dimgray" )
;)

(use-package paren :ensure t 
:init   (show-paren-mode 1)
:config (setq show-paren-delay 0)
)

(use-package rainbow-delimiters :ensure t
:hook ((prog-mode text-mode) . rainbow-delimiters-mode)
)

(use-package smartparens :ensure t :pin melpa
:init (smartparens-global-mode)
:config 
    (use-package evil-smartparens :ensure t :pin melpa
    :init (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))
)

(use-package which-key :ensure t 
:init   (which-key-mode t) 
:config (which-key-enable-god-mode-support t))

(use-package evil :ensure t :pin melpa
:init
    (setq evil-want-integration t)
    (setq evil-want-keybinding nil)
    (setq evil-want-C-u-scroll t)
    (setq-default evil-symbol-word-search t)
    (evil-mode t)
)
(use-package evil-collection :ensure t :pin melpa
:after evil
:init 
    (setq evil-collection-setup-minibuffer t)
    (evil-collection-helm-setup)
    (evil-collection-magit-setup)
    (evil-collection-neotree-setup)
    (evil-collection-which-key-setup)
    (evil-collection-buff-menu-setup)
    (evil-collection-package-menu-setup)
    (evil-collection-init)
)

(use-package evil-numbers :ensure t :pin melpa 
:after evil
;https://github.com/cofi/evil-numbers
:init
    (global-set-key (kbd "C-c +") 'evil-number/inc-at-pt)
    (global-set-key (kbd "C-c -") 'evil-number/dec-at-pt)
    (evil-leader/set-key "+" 'evil-number/inc-at-pt)
    (evil-leader/set-key "-" 'evil-number/dec-at-pt)
)

(use-package evil-leader :ensure t :defer t :pin melpa
:after (evil which-key)
:init (global-evil-leader-mode t)
:config
    (setq evil-leader/leader "<SPC>")
    (evil-leader/set-key
        "<SPC>" 'helm-smex
        "er"    'restart-emacs
        "ff"    'find-file
        "pl"    'list-processes
        "ef"    (lambda ()(interactive)(find-file "~/.emacs.d/config.org"))
        "wf"    'toggle-frame-fullscreen
        "wh"    'shrink-window-horizontally
        "wj"    'enlarge-window
        "wk"    'shrink-window
        "wl"    'enlarge-window-horizontally
        )
    (which-key-declare-prefixes "SPC b" "Buffer")
    (which-key-declare-prefixes "SPC d" "Debug")
    (which-key-declare-prefixes "SPC e" "Emacs")
    (which-key-declare-prefixes "SPC f" "Find")
    (which-key-declare-prefixes "SPC n" "File Manager")
    (which-key-declare-prefixes "SPC g" "Git")
    (which-key-declare-prefixes "SPC o" "Org")
    (which-key-declare-prefixes "SPC p" "Projectile")
    (which-key-declare-prefixes "SPC t" "Tabbar")
    (which-key-declare-prefixes "SPC u" "Utils")
    (which-key-declare-prefixes "SPC w" "Windows")
    (which-key-declare-prefixes "SPC h" "Hacking")
    (which-key-declare-prefixes "SPC h r" "Rust")
    (which-key-declare-prefixes "SPC h c" "C/C++")
    (which-key-declare-prefixes "SPC h y" "Yasnippet")
    )

(use-package all-the-icons :ensure t)
(use-package doom-modeline :ensure t :pin melpa
:hook (after-init . doom-modeline-init)
:init (setq doom-modeline-height 20)
      (setq doom-modeline-icon t)
      (setq doom-modeline-persp-name t)
      (setq doom-modeline-major-mode-icon t)
      (setq doom-modeline-lsp t)
      (setq doom-modeline-python-executable "python")
      (setq doom-modeline--flycheck-icon t)
      (setq doom-modeline-github t)
      (setq doom-modeline-current-window t)
)

(use-package spaceline :ensure t :after powerline :disabled
:init (setq spaceline-responsive nil)
      (set-face-attribute 'mode-line nil :box nil)
)
(use-package spaceline-config :ensure spaceline
:init
(use-package spaceline-all-the-icons :ensure t 
    :init
    (spaceline-all-the-icons-theme)
    :config
    (spaceline-all-the-icons--setup-git-ahead)
    (spaceline-all-the-icons--setup-neotree)
    (spaceline-all-the-icons--setup-package-updates)
    (spaceline-all-the-icons--window-number)
    (spaceline-toggle-all-the-icons-battery-status-on)
    (spaceline-toggle-all-the-icons-bookmark-on)
    (spaceline-toggle-all-the-icons-buffer-id-on)
    (spaceline-toggle-all-the-icons-flycheck-status-info-on)
    (spaceline-toggle-all-the-icons-flycheck-status-on)
    (spaceline-toggle-all-the-icons-git-ahead-on)
    (spaceline-toggle-all-the-icons-git-status-on)
    (spaceline-toggle-all-the-icons-mode-icon-on)
    (spaceline-toggle-all-the-icons-nyan-cat-on)
    (spaceline-toggle-all-the-icons-org-clock-current-task-on)
    (spaceline-toggle-all-the-icons-projectile-on)
    (spaceline-toggle-all-the-icons-sunrise-on)
    (spaceline-toggle-all-the-icons-sunset-on)
    (spaceline-toggle-all-the-icons-time-on)
    (spaceline-toggle-all-the-icons-weather-on)
    (spaceline-toggle-all-the-icons-vc-icon-on)
    (spaceline-toggle-all-the-icons-window-number-on)
    ;(setq inhibit-compacting-font-caches t)
)
;:init (spaceline-spacemacs-theme)
;:config
;    (custom-set-faces '(mode-line-buffer-id ((t nil)))) ;; blend well with tango-dark
;    (setq powerline-default-separator 'arrow)   ;; bar arrow wave utf-8
;    (spaceline-toggle-buffer-id-on)
;    (spaceline-toggle-input-method-on)
;    (spaceline-toggle-buffer-modified-on)
;    (spaceline-toggle-buffer-encoding-on)
;    (spaceline-toggle-process-on)
;    (spaceline-toggle-projectile-root-on)
;    (spaceline-toggle-version-control-on)
;    (spaceline-toggle-flycheck-error-on)
;    (spaceline-toggle-flycheck-info-on)
;    (spaceline-toggle-flycheck-warning-on)
;    (spaceline-toggle-major-mode-on)
;    (spaceline-toggle-minor-modes-off)
;    (spaceline-toggle-line-column-on)
;    (spaceline-toggle-window-number-on)
;    (spaceline-toggle-buffer-encoding-on)
;    (spaceline-toggle-evil-state-on)
;    (spaceline-toggle-nyan-cat-on)
;    (spaceline-helm-mode 1)
;    (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
;    (setq evil-normal-state-tag   (propertize "COMMAND "))
;    (setq evil-emacs-state-tag    (propertize "EMACS   "))
;    (setq evil-insert-state-tag   (propertize "INSERT  "))
;    (setq evil-replace-state-tag  (propertize "REPLACE "))
;    (setq evil-motion-state-tag   (propertize "MOTION  "))
;    (setq evil-visual-state-tag   (propertize "VISUAL  "))
;    (setq evil-operator-state-tag (propertize "OPERATE "))
)

(use-package nyan-mode :ensure t
:init   (nyan-mode)
:config (setq-default nyan-wavy-trail t)
        (nyan-start-animation)
        (nyan-refresh))
;; mode-icons has bug with spaceline-all-the-icons
;(when window-system
;    (use-package mode-icons :ensure t
;    :init  
;        (setq mode-icons-desaturate-active t)
;        (mode-icons-mode)))
(use-package fancy-battery :ensure t
:init   (fancy-battery-mode)
:config (setq fancy-battery-show-percentage t))

(use-package diminish :ensure t :pin melpa
:init 
    (diminish 'c++-mode "C++ Mode")
    (diminish 'c-mode   "C Mode"  )
)

(use-package helm :defer t :ensure t :diminish helm-mode
:bind ("M-x" . helm-M-x)
:init (helm-mode 1)
;; helm always bottom
(add-to-list 'display-buffer-alist
            `(,(rx bos "*helm" (* not-newline) "*" eos)
                    (display-buffer-in-side-window)
                    (inhibit-same-window . t)
                    (window-height . 0.4)))

(use-package helm-projectile :ensure t 
:after projectile
:init (helm-projectile-on)
))
(use-package helm-company :ensure t
:after helm company
:init
    (define-key company-mode-map   (kbd "C-q") 'helm-company)
    (define-key company-active-map (kbd "C-q") 'helm-company)
)
(use-package helm-descbinds :ensure t 
:after helm
:init (helm-descbinds-mode)
)
(use-package helm-swoop :ensure t :pin melpa
:after helm
:init (evil-leader/set-key "fw" 'helm-swoop)
)

(use-package smex :ensure t :pin melpa
:init (smex-initialize)
)
(use-package helm-smex :ensure t :pin melpa
:bind ("M-x" . #'helm-smex-major-mode-commands)
:init (global-set-key [remap execute-extended-command] #'helm-smex)
      (evil-leader/set-key "fm" #'helm-smex-major-mode-commands)
)

(use-package projectile :defer t :ensure t
:init   (projectile-mode t)
:config (evil-leader/set-key "p" 'projectile-command-map)
)

(use-package neotree :ensure t
:init 
    (setq projectile-switch-project-action 'neotree-projectile-action)
    (setq-default neo-smart-open t)
    (evil-leader/set-key "n" #'neotree-toggle)
:config
    (progn
        (setq-default neo-window-width 30)
        (setq-default neo-dont-be-alone t)
        (setq-local display-line-numbers 0)
        (setq neo-force-change-root t)
        (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
    )
    (setq neo-show-hidden-files t)
)

(use-package ace-window :ensure t
:init   (evil-leader/set-key "wo" 'ace-window)
:config (setq aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8))
)

(use-package eyebrowse :ensure t
:init (eyebrowse-mode t)
:config 
    (evil-leader/set-key
        "w;" 'eyebrowse-last-window-config
        "w0" 'eyebrowse-close-window-config
        "w1" 'eyebrowse-switch-to-window-config-1
        "w2" 'eyebrowse-switch-to-window-config-2
        "w3" 'eyebrowse-switch-to-window-config-3
        "w4" 'eyebrowse-switch-to-window-config-4
        "w5" 'eyebrowse-switch-to-window-config-5
        "w6" 'eyebrowse-switch-to-window-config-6
        "w7" 'eyebrowse-switch-to-window-config-7
    )
)

(use-package exwm :ensure t :pin melpa
:if window-system
:commands (exwm-init)
:config
    (use-package exwm-config 
    :init (exwm-config-default))

    (setq exwm-workspace-number 0)
    (exwm-input-set-key (kbd "s-h") 'windmove-left)
    (exwm-input-set-key (kbd "s-j") 'windmove-down)
    (exwm-input-set-key (kbd "s-k") 'windmove-up)
    (exwm-input-set-key (kbd "s-l") 'windmove-right)
    (exwm-input-set-key (kbd "s-s") 'split-window-right)
    (exwm-input-set-key (kbd "s-v") 'split-window-vertically)
    (exwm-input-set-key (kbd "s-d") 'delete-window)
    (exwm-input-set-key (kbd "s-q") '(lambda () (interactive) (kill-buffer (current-buffer))))
    (exwm-input-set-key (kbd "s-e") 'exwm-exit)
    (advice-add 'split-window-right :after 'windmove-right)
    (advice-add 'split-window-vertically :after 'windmove-down)


    ;; 's-N': Switch to certain workspace
    (dotimes (i 10)
        (exwm-input-set-key (kbd (format "s-%d" i))
                            `(lambda ()
                            (interactive)
                            (exwm-workspace-switch-create ,i))))
    ;; 's-r': Launch application
    (exwm-input-set-key (kbd "s-r")
                        (lambda (command)
                            (interactive (list (read-shell-command "$ ")))
                            (start-process-shell-command command nil command)))

)

(use-package magit :ensure t  :pin melpa
:init   (evil-leader/set-key "gs" 'magit-status)
:config (setq vc-handled-backends nil)
)
(use-package evil-magit :ensure t :pin melpa
:after (evil magit)
:init  (evil-magit-init)
)
(use-package magithub :ensure t
:after magit
:init (magithub-feature-autoinject t)
      (evil-leader/set-key "gd" 'magithub-dashboard)
      (setq magithub-clone-default-directory "~/github")   
)

(use-package evil-ediff :ensure t :pin melpa
:init (evil-ediff-init)
)

(use-package undo-tree :ensure t :diminish undo-tree-mode
:init
    ;(global-set-key (kbd "C-u") #'undo-tree-undo)
    ;(global-set-key (kbd "C-r") #'undo-tree-redo)
    (evil-leader/set-key "uu"    'undo-tree-undo)
    (evil-leader/set-key "ur"    'undo-tree-undo)
    (defalias 'redo 'undo-tree-redo)
    (defalias 'undo 'undo-tree-undo)
    (global-undo-tree-mode)
)

(use-package org
:init (setq org-directory            (expand-file-name "~/Dropbox/org"))
      (setq org-default-notes-file   (concat org-directory "/notes/notes.org"))
      (setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
      (evil-leader/set-key
          "oa" 'org-agenda
          "ob" 'org-iswitchb
          "oc" 'org-capture
          "oe" 'org-edit-src-code
          "ok" 'org-edit-src-exit
          "ol" 'org-store-link
      )
)

(use-package org-journal :ensure t :pin melpa
:after org
:init (setq org-journal-dir (expand-file-name "~/Dropbox/org/journal")
            org-journal-file-format "%Y-%m-%d.org"
            org-journal-date-format "%Y-%m-%d (%A)"
      )
      (add-to-list 'org-agenda-files (expand-file-name "~/Dropbox/org/journal"))
:config
    (setq org-journal-enable-agenda-integration t
          org-icalendar-store-UID t
          org-icalendar-include0tidi "all"
          org-icalendar-conbined-agenda-file "~/calendar/org-journal.ics")
      (org-journal-update-org-agenda-files)
      (org-icalendar-combine-agenda-files)
)

(defun org-journal-find-location () (org-journal-new-entry t) (goto-char (point-min)))

(use-package org-capture
:after org
:init (setq org-reverse-note-order t)
      (add-to-list 'org-agenda-files (expand-file-name "~/Dropbox/org/notes"))
      (setq org-capture-templates
          '(("t" "Todo" entry (file+headline "~/Dropbox/org/notes/notes.org" "Todos")
             "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
            ("l" "Link" entry (file+headline "~/Dropbox/org/notes/notes.org" "Links")
             "* TODO %?\nAdded: %U\n" :prepend t :kill-buffer t)
            ("j" "Journal" entry (function org-journal-find-location)
             "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?")
            ("a" "Appointment" entry (file "~/Dropbox/org/agenda/gcal.org")
             "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
           )
      )
)

(use-package org-agenda 
:init (use-package evil-org :ensure t :pin melpa
      :after (org evil)
      :init (add-hook 'org-mode-hook 'evil-org-mode)
            (add-hook 'evil-org-mode-hook (lambda () (evil-org-set-key-theme)))
            (setq org-agenda-files '("~/Dropbox/org/agenda"))
            (require 'evil-org-agenda)
            (evil-org-agenda-set-keys)
      )
)

(use-package org-gcal :ensure t :pin melpa
:after org-agenda
:init (setq org-gcal-client-id "354752650679-2rrgv1qctk75ceg0r9vtaghi4is7iad4.apps.googleusercontent.com"
            org-gcal-client-secret "j3UUjHX4L0huIxNGp_Kw3Aj4"
            org-gcal-file-alist '(("8687lee@gmail.com" . "~/Dropbox/org/agenda/gcal.org")))
      (add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync)))
      (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync)))
)

;(use-package calfw :ensure t :pin melpa 
;:commands cfw:open-calendar-buffer
;:config (use-package calfw-org
;        :config (setq cfw:org-agenda-schedule-args '(:deadline :timestamp :sexp))
;        )
;)
;(use-package calfw-gcal :ensure t :pin melpa
;:init (require 'calfw-gcal))

(use-package org-babel
:init (org-babel-do-load-languages
          'org-babel-load-languages
          '((emacs-lisp . t)
            (python . t)
            (org . t)
            (shell  . t)
            (C   . t)))
)
;; 스펠체크 넘어가는 부분 설정
(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

(use-package rainbow-mode :ensure t
    :hook (prog-mode
           text-mode
           html-mode
           css-mode
           lisp-mode
           emacs-lisp-mode)
    :init (rainbow-mode)
)

(use-package docker          :ensure t :init (evil-leader/set-key "ud" 'docker)) 
(use-package dockerfile-mode :ensure t 
    :init (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package eshell
:init (setq eshell-buffer-maximum-lines 1000)
)

(use-package exec-path-from-shell :ensure t :pin melpa
:init ;(exec-path-from-shell-copy-env "PATH")
      (when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))
)

(use-package eshell-prompt-extras :ensure t :pin melpa
:init
    (use-package virtualenvwrapper :ensure t :pin melpa
    :init (venv-initialize-eshell))
    (autoload 'epe-theme-lambda "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil
          eshell-prompt-function 'epe-theme-lambda)
)

(use-package esh-autosuggest :ensure t :pin melpa
:hook (eshell-mode .  esh-autosuggest-mode)
)

(use-package eshell-up :ensure t :pin melpa
:init (require 'eshell-up)
      (add-hook 'eshell-mode-hook (lambda () (eshell/alias "up" "eshell-up $1")
                                        (eshell/alias "pk" "eshell-up-peek $1")))
)

(use-package shell-pop :ensure t :pin melpa
:init (setq shell-pop-shell-type '("eshell" "* eshell *" (lambda () (eshell))))
      (evil-leader/set-key "ut" 'shell-pop)
      ;(global-set-key (kbd "<C-t>") 'shell-pop)
)



(use-package buffer-move :ensure t :pin melpa
:init
    (evil-leader/set-key
        "bs" 'ibuffer
        "br" 'eval-buffer
        "bh" 'buf-move-left
        "bj" 'buf-move-down
        "bk" 'buf-move-up
        "bl" 'buf-move-right
    )
)

(setq ibuffer-saved-filter-groups
    '(("home"
          ("emacs-config" (or (filename . ".emacs.d")
                              (filename . "emacs-config")))
          ("org-mode"     (or (mode . org-mode)
                              (filename ."OrgMode")))
          ("code"         (or (directory . "~/dev/")
                              (mode . prog-mode)
                              (mode . c++-mode)
                              (mode . c-mode)
                              (mode . yaml-mode)
                              (mode . toml-mode)
                              (mode . lisp-mode)
                              (mode . emacs-lisp-mode)))
          ("magit"        (or (name . "\*magit")))
          ("Help"         (or (name . "\*Help\*")
                              (name . "\*Apropos\*")
                              (name . "\*info\*")))
     ))
)
(add-hook 'ibuffer-mode-hook '(lambda () (ibuffer-switch-to-saved-filter-groups "home")))

(use-package dash :ensure t :pin melpa
:init (dash-enable-font-lock)
)
(use-package dash-functional :ensure t :pin melpa
:after dash
)
;; if you want use helm-dash you use this command helm-dash-install-docset
(use-package helm-dash :ensure t :pin melpa
:after helm dash
)

(use-package ialign :ensure t :pin melpa 
:init (evil-leader/set-key "ta" 'ialign))

(use-package page-break-lines :ensure t :pin melpa)
(use-package dashboard :ensure t :pin melpa
:init (dashboard-setup-startup-hook)
:config 
    (setq dashboard-banner-logo-title "Happy Hacking")
    ;(setq dashboard-startup-banner "") ;banner image change
    (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
    (setq show-week-agenda-p t)
    (setq dashboard-items '((recents   . 5)
                            (bookmarks . 5)
                            (projects  . 5)
                            (agenda    . 5)))
)

(use-package tabbar :ensure t :pin melpa
:after (powerline evil-leader)
:init 
      (defvar my/tabbar-left  "/"  "Separator on left side of tab")
      (defvar my/tabbar-right "\\" "Separator on right side of tab")
      (defun my/tabbar-tab-label-function (tab)
          (powerline-render (list my/tabbar-left (format " %s  " (car tab)) my/tabbar-right)))
      (require 'tabbar)
      (setq my/tabbar-left  (powerline-wave-right 'tabbar-default nil 24))
      (setq my/tabbar-right (powerline-wave-left  nil 'tabbar-default 24))
      (tabbar-mode 1)
      (setq tabbar-tab-label-function 'my/tabbar-tab-label-function)
:config
      (setq tabbar-use-images nil)
      (setq tabbar-scroll-left-button  nil)
      (setq tabbar-scroll-right-button nil)
      (setq tabbar-home-button nil)
      (evil-leader/set-key "th" 'tabbar-forward-tab)
      (evil-leader/set-key "tl" 'tabbar-backward-tab)
)

(use-package symon :ensure t :pin melpa
:init ;(symon-mode)
)

(use-package google-translate :ensure t :pin melpa
:init (require 'google-translate-smooth-ui)
      ;(require 'google-translate-default-ui)
      ;(evil-leader/set-key "ft" 'google-translate-at-point)
      ;(evil-leader/set-key "fT" 'google-translate-query-translate)
      (setq google-translate-translation-directions-alist
          '(("en" . "ko")
              ("ko" . "en")
              ("jp" . "ko")
              ("ko" . "jp")))
      (evil-leader/set-key "ft" 'google-translate-smooth-translate)
:config

)

(use-package esup :ensure t :pin melpa)

(use-package flyspell :ensure t :pin melpa
:init
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
    (add-hook 'text-mode-hook 'flyspell-mode)
    (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
)

(use-package helm-flyspell :ensure t :pin melpa
:after (helm flyspell)
:init (evil-leader/set-key "s" 'helm-flyspell-correct)
)

(use-package helm-ag :ensure t :pin melpa
    :init (evil-leader/set-key "fgt" 'helm-do-ag-this-file
                               "fgb" 'helm-do-ag-buffers
                               "fgr" 'helm-do-ag-project-root))
(use-package wgrep :ensure t :pin melpa
:config (setq wgrep-auto-save buffer t)
       ;(setq wgrep-enable-key "r")
)

(use-package iedit :ensure t :pin melpa
:init (evil-leader/set-key "fi" 'iedit-mode)
)

(use-package helm-system-packages :ensure t :pin melpa
:init (require 'em-tramp)
      (setq password-cache t)
      (setq password-cache-expiry 3600)
      (evil-leader/set-key "up" 'helm-system-packages))

(use-package company :ensure t
:init (global-company-mode 1)
:config 
    (setq company-idle-delay 0)
    (setq company-minimum-prefix-length 1)
    (setq company-show-numbers t)
    (define-key company-active-map (kbd "M-n") 0)
    (define-key company-active-map (kbd "M-p") 0)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)
)
(use-package company-quickhelp :ensure t :pin melpa
:init
    ;(evil-leader/set-key "hch" 'company-quickhelp-manual-begin)
    (company-quickhelp-mode)
)

(use-package company-statistics :ensure t :pin melpa
:init (company-statistics-mode)
)

;(use-package company-tabnine :ensure t :pin melpa
;:init (add-to-list 'company-backend #'company-tabnine)
;)

(use-package lsp-mode :ensure t :pin melpa
:init 
)

(use-package lsp-ui :ensure t :pin melpa
:after lsp-mode
:config (require 'lsp-clients)
)


(use-package company-lsp :ensure t :pin melpa
:after (company lsp-mode)
:init  (add-to-list 'company-backends #'company-lsp)
)

(use-package flycheck :ensure t :pin melpa
:init (global-flycheck-mode t)
      (setq flycheck-clang-language-standard "c++17")
)
(use-package flycheck-pos-tip :ensure t :pin melpa
:commands flycheck
:init (flycheck-pos-tip-mode))

(use-package flycheck-inline :ensure t :pin melpa
:commands flycheck
:init (global-flycheck-inline-mode)
:config
      (setq flycheck-inline-display-function
          (lambda (msg pos)
              (let* ((ov (quick-peek-overlay-ensure-at pos))
                  (contents (quick-peek-overlay-contents ov)))
              (setf (quick-peek-overlay-contents ov)
                      (concat contents (when contents "\n") msg))
              (quick-peek-update ov)))
          flycheck-inline-clear-function #'quick-peek-hide)
)

(use-package yasnippet :ensure t :pin melpa
;https://github.com/joaotavora/yasnippet
:init
  (use-package yasnippet-snippets :ensure t)
  (evil-leader/set-key "hyl" 'company-yasnippet)
  (setq yas-snippet-dirs '("~/.emacs.d/yas/"))
  (yas-global-mode t)
  (yas-reload-all t)
)
(use-package auto-yasnippet :ensure t :pin melpa
;https://github.com/abo-abo/auto-yasnippet
:after yasnippet
:init (evil-leader/set-key "hyc" 'aya-create)
      (evil-leader/set-key "hye" 'aya-expand)
)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(use-package company-c-headers :ensure t
:after company
:init (add-to-list 'company-backends 'company-c-headers)
)
(use-package clang-format :ensure t
:init (evil-leader/set-key "hcf" 'clang-format-regieon)
)

(use-package rtags :ensure t
:after (helm flycheck)
:init
    (setq rtags-autostart-diagnostics t)
    (rtags-diagnostics)
    (setq rtags-completions-enabled t) (rtags-enable-standard-keybindings)
    (evil-leader/set-key "hcs" 'rtags-find-symbol
                         "hcr" 'rtags-find-references)
)
(use-package helm-rtags :ensure t :after (helm rtags)
:init (setq rtags-display-result-backend 'helm))

(use-package company-rtags :ensure t :after (company rtags)
:init (add-to-list 'company-backend 'company-rtags))
(use-package flycheck-rtags :ensure t
    :init
    (defun my-flycheck-rtags-setup ()
        (flycheck-select-checker 'rtags)
        (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
        (setq-local flycheck-check-syntax-automatically nil))
    (add-hook 'c-mode-hook    #'my-flycheck-rtags-setup)
    (add-hook 'c++-mode-hook  #'my-flycheck-rtags-setup)
    (add-hook 'objc-mode-hook #'my-flycheck-rtags-setup)
    (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard   "c++17")))
    (add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++17")))
)

(use-package cmake-ide :ensure t 
:init
    (require 'subr-x)
    (cmake-ide-setup)
    (setq cmake-ide-flags-c++ (append '("-std=c++17")))
    (defadvice cmake-ide--run-cmake-impl
      (after copy-compile-commands-to-project-dir activate)
      (if (file-exists-p (concat project-dir "/compile_commands.json"))
      (progn 
      (cmake-ide--message "[advice] found compile_commands.json" )
      (copy-file (concat project-dir "compile_commands.json") cmake-dir)
      (cmake-ide--message "[advice] copying compile_commands.json to %s" cmake-dir))
      (cmake-ide--message "[advice] couldn't find compile_commands.json" )))
)

(use-package irony :ensure t :diminish irony-mode
:init 
    (setq irony-additional-clang-options '("-std=c++17"))
    (setq irony-cdb-search-directory-list (quote ("." "build" "bin")))
    (add-hook 'c++-mode-hook   'irony-mode)
    (add-hook 'c-mode-hook     'irony-mode)
    (add-hook 'objc-mode-hook  'irony-mode)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
)
(use-package irony-eldoc :ensure t :after (irony eldoc)
    :hook irony-mode
)
(use-package company-irony :ensure t :after company
:init (add-to-list 'company-backends 'company-irony)
)
(use-package flycheck-irony :ensure t :after flycheck
:init (flycheck-irony-setup)
)
(use-package company-irony-c-headers :ensure t
:after company
:init (add-to-list 'company-backends 'company-irony-c-headers)
)

(use-package dap-mode :ensure t :pin melpa
:init (evil-leader/set-key "dr" 'dap-debug)
      (evil-leader/set-key "de" 'dap-debug)
:config (require 'dap-lldb)
)



(setq gdb-show-main t)
(evil-leader/set-key "db" 'gud-break)
(evil-leader/set-key "dn" 'gud-next)
(evil-leader/set-key "di" 'gud-step)
(evil-leader/set-key "df" 'gud-finish)
(evil-leader/set-key "dt" '(lambda () (call-interactively 'gud-tbreak)
                                   (call-interactively 'gud-cont  )))
(use-package gdb-mi
:load-path "lisp/emacs-gdb"
:init (fmakunbound 'gdb)
      (fmakunbound 'gdb-enable-debug)
)

(use-package eldoc :ensure t :diminish eldoc-mode :after rtags)

(defun fontify-string (str mode)
    "Return STR fontified according to MODE."
    (with-temp-buffer
        (insert str)
        (delay-mode-hooks (funcall mode))
        (font-lock-default-function mode)
        (font-lock-default-fontify-region
        (point-min) (point-max) nil)
        (buffer-string)
    )
)

(defun rtags-eldoc-function ()
(let ((summary (rtags-get-summary-text)))
    (and summary
        (fontify-string
        (replace-regexp-in-string
        "{[^}]*$" ""
        (mapconcat
            (lambda (str) (if (= 0 (length str)) "//" (string-trim str)))
            (split-string summary "\r?\n")
            " "))
        major-mode))))

(defun rtags-eldoc-mode ()
    (interactive)
    (setq-local eldoc-documentation-function #'rtags-eldoc-function)
    (eldoc-mode 1)
)

(add-hook 'c-mode-hook 'rtags-eldoc-mode)
(add-hook 'c++-mode-hook 'rtags-eldoc-mode)

(use-package elisp-slime-nav :ensure t :diminish elisp-slime-nav-mode
:hook ((emacs-lisp-mode ielm-mode) . elisp-slime-nav-mode)
)
(add-hook 'emacs-lisp-mode-hook 'prettify-symbols-mode)
(add-hook 'lisp-mode-hook       'prettify-symbols-mode)

(use-package rust-mode :ensure t :pin melpa
:mode (("\\.rs\\'" . rust-mode))
:init (evil-leader/set-key "hrf" 'rust-format-buffer)
;:config (setq rust-format-on-save t)
;(add-hook 'rust-mode-hook (lambda () (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))
)
(use-package flycheck-rust :ensure t :pin melpa :after flycheck
:init (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
)
(use-package racer :ensure t :pin melpa
:init
    (add-hook 'rust-mode-hook  #'racer-mode)
    (add-hook 'racer-mode-hook #'company-mode) 
    (add-hook 'racer-mode-hook #'eldoc-mode) 
)
(use-package company-racer :ensure t :pin melpa
:init (add-to-list 'company-backends 'company-racer)
)

(use-package cargo :ensure t :pin melpa
:init (add-hook 'rust-mode-hook 'cargo-minor-mode)
      (evil-leader/set-key "hrb" 'cargo-process-build
                           "hrr" 'cargo-process-run
                           "hrt" 'cargo-process-test)
)

(use-package haskell-mode :ensure t)

(use-package yaml-mode :ensure t
:mode (("\\.yaml\\'" . yaml-mode)
       ("\\.yml\\'"  . yaml-mode))
)

(use-package toml-mode :ensure t :pin melpa
:mode ("\\.toml\\'" . toml-mode))

(use-package cmake-mode :ensure t :pin melpa
:mode (("\\.cmake\\'"    . cmake-mode)
       ("CMakeLists.txt" . cmake-mode))
:init (setq cmake-tab-width 4)      
)

(use-package markdown-mode :ensure t :pin melpa
:commands (markdown-mode gfm-mode)
:mode (("\\README.md\\'" . gfm-mode)
       ("\\.md\\'"       . markdown-mode)
       ("\\.markdown\\'" . markdown-mode))
:init (setq markdown-command "multimarkdown")
)

(use-package markdown-preview-mode :ensure t :pin melpa)
(use-package gh-md :ensure t :pin melpa
:init (evil-leader/set-key "hmr" 'gh-md-render-buffer)
)

(use-package easy-jekyll :ensure t :pin melpa
:init (setq easy-jekyll-basedir "~/dev/blog/")
      (setq easy-jekyll-url "https://injae.github.io")
      (setq easy-jekyll-sshdomain "blogdomain")
      (setq easy-jekyll-root "/")
      (setq easy-jekyll-previewtime "300")
)

(use-package pyenv-mode :ensure t :pin melpa
:init
    (defun projectile-pyenv-mode-set ()
        "Set pyenv version matching project name."
        (let ((project (projectile-project-name)))
            (if (member project (pyenv-mode-versions))
                (pyenv-mode-set project)
                (pyenv-mode-unset)
            )
        )
    )
    (add-hook 'projectile-switch-project-hook 'projectile-pyenv-mode-set)
    (add-hook 'python-mode-hook 'pyenv-mode)
)
(use-package pyenv-mode-auto :ensure t :pin melpa)
(use-package python-mode
:interpreter ("python" . python-mode)
:mode   ("\\.py\\'" . python-mode)
        ("\\.wsgi$" . python-mode)
:init   (setq-default indent-tabs-mode nil)
:config (setq python-indent-offset 4)
)

(use-package anaconda-mode :ensure t :pin melpa
:init   (add-hook 'python-mode-hook 'anaconda-mode)
        (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

(use-package company-anaconda :ensure t :pin melpa :after (company-mode anaconda-mode)
:init (add-hook 'python-mode-hook 'anaconda-mode)
      (add-to-list 'company-backends '(company-anaconda :with company-capf)))

(use-package i3wm :ensure t :pin melpa)

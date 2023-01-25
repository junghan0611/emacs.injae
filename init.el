;;; init.el --- Emacs Configuration
;; -*- lexical-binding: t -*-
;;; Commentary:
;; This config start here
;;; Code:

(eval-when-compile
    (add-to-list 'load-path (expand-file-name "~/.emacs.d/straight/build/use-package"))
    ;(add-to-list 'load-path (expand-file-name "~/.emacs.d/straight/build/use-package-ensure-system-package"))
    ;(add-to-list 'load-path (expand-file-name "~/.emacs.d/straight/build/general"))
    ;(add-to-list 'load-path (expand-file-name "~/.emacs.d/straight/build/bind-key"))
    (require 'use-package)
    ;(require 'use-package-ensure-system-package)
    ;(require 'general)
    ;(require 'bind-key)
    )

(use-package straight
    :custom (straight-use-package-by-default t))

(use-package esup) ; emacs config profiling
(use-package use-package)
(use-package gcmh
    :functions gcmh-mode
    :config (gcmh-mode t))
;(use-package gcmh :hook (after-init . gcmh-mode))


(use-package use-package-ensure-system-package)
(use-package exec-path-from-shell
    :functions exec-path-from-shell-initialize
    :config (exec-path-from-shell-initialize)
)

;;; font Setting
;; +------------+------------+
;; | 일이삼사오 | 일이삼사오 |
;; +------------+------------+
;; | ABCDEFGHIJ | ABCDEFGHIJ |
;; +------------+------------+
;; | 1234567890 | 1234567890 |
;; +------------+------------+
;; | abcdefghij | abcdefghij |
;; +------------+------------+

(setq user-full-name "InJae Lee")
(setq user-mail-address "8687lee@gmail.com")

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/module/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/module/prog/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/private/"))

(setq-default custom-file "~/.emacs.d/custom-variable.el")
(when (file-exists-p custom-file) (load-file custom-file))

(use-package module-lisp-util :straight nil
    :config
    ;;; Emacs 기본설정
    (load-modules-with-list "~/.emacs.d/module/" '(
        "emacs" "font" "evil"
        "git" "grep-util" "extension"
        "project-manage" "completion" "window"
        "buffer" "ui" "org"
        "terminal" "edit" "flycheck"
        "search" "multi-mode" "util"
    ))
    ;;; programming 설정
    (load-modules-with-list "~/.emacs.d/module/prog/" '(
        "lsp" "snippet" "highlight"
        "prog-search" "doc" "ssh"
        "coverage" "copilot" "tools"
        ;; language
        "cpp" "lisp" "csharp"
        "rust" "haskell" "python"
        "flutter" "web" "ruby"
        "jvm" "go" "nix"
        "config-file" "docker"
    ))
)

;; 개인 설정
(defvar private-config-file "~/.emacs.d/private/token.el")
(when (file-exists-p private-config-file)
    (load-file private-config-file))

;(use-package token :straight (:host github :repo "injae/private_config"))

(use-package filenotify :straight nil
    :after org
    :preface
    (defvar env-org-file (expand-file-name "~/.emacs.d/env.org"))
    (defun update-env-org-file (event)
        (funcall-interactively 'org-babel-tangle-file env-org-file))
    :config
    (file-notify-add-watch env-org-file
        '(change attribute-change) 'update-env-org-file)
    )
;;; init.el ends here

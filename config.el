(setq user-full-name "Injae Lee")
(setq user-mail-address "8687lee@gmail.com")

;;; config.el --- Emacs Configuration -*- lexical-binding: t -*-
;;; Commentary:
;; This config start here
;;; Code:

(add-to-list 'load-path "~/.emacs.d/lisp/")

(use-package emacs-gc-setting :no-require t
:init (setq gc-cons-threshold 100000000); emacs speed up setting in 16GB RAM
      (setq read-process-output-max (* 1024 1024))
      ;(run-with-idle-timer 2 t (lambda () (garbage-collect)))  ; 2초마다, repeat
)
(use-package esup :ensure t :pin melpa)



;(use-package bug-hunter :ensure t :pin melpa)
;(use-package explain-pause-mode :quelpa (explain-pause-mode :fetcher github :repo "lastquestion/explain-pause-mode")
;    :config (explain-pause-mode t)
;)

(setq ad-redefinition-action 'accept)
(setq max-lisp-eval-depth 10000)
(setq max-specpdl-size 32000)
;(setq debug-on-error t) ; debug option

(setq *is-mac*     (eq system-type 'darwin))
(setq *is-windows* (eq system-type 'windows-nt))
(setq *is-cygwin*  (eq system-type 'cygwin))
(setq *is-linux*   (or (eq system-type 'gnu/linux) (eq system-type 'linux)))
(setq *is-unix*    (or *is-linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)))

(use-package scroll-bar :no-require t
:if window-system
:init (scroll-bar-mode -1)
:config
    (setq scroll-step 1)
    (setq scroll-conservatively 10000)
)

(use-package tool-bar :no-require t
:if window-system
:init (tool-bar-mode -1)
)

(use-package menu-bar :no-require t
:if window-system
:init (menu-bar-mode -1)
)

(use-package tooltip-mode :no-require t
:if window-system
:init (tooltip-mode -1)
)

;(use-package modern-fringe-mode  :no-require t
;:if window-system
;:init (fringe-mode -1)
;)

(use-package mouse :no-require t
:if window-system
:init (xterm-mouse-mode)
)

(use-package ns-auto-titlebar :ensure t :pin melpa
:if *is-mac*
:config (ns-auto-titlebar-mode)
        (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
        (add-to-list 'default-frame-alist '(ns-appearance . dark)) ;; assuming you are using a dark theme
        (setq ns-use-proxy-icon nil)
        (setq frame-title-format nil)
)

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
;; emacs large file setting
(use-package so-long-mode :no-require t
;; default text parsing direction left -> right 
:if (version<= "27.1" emacs-version)
:config
    (setq bidi-paragraph-direction 'left-to-right)
    (setq bidi-inhibit-bpa t)
    (global-so-long-mode 1)
)

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
; 한글과 영어의 글자 간격문제 해결을 위한 방법 and Fira Code 지정 방법 아직 맥에서만 적용
(set-face-attribute   'default            nil       :family "Fira Code" :height 120)
(set-fontset-font nil 'hangul            (font-spec :family "D2Coding"  :pixelsize 18))
(set-fontset-font nil 'japanese-jisx0208 (font-spec :family "D2Coding"  :pixelsize 18))
(setq face-font-rescale-alist '(("D2coding" . 1.16)))
(when *is-mac*
    (progn
        (require 'ucs-normalize)
        (set-file-name-coding-system 'utf-8-hfs)
        (setq default-process-coding-system '(utf-8-hfs . utf-8-hfs))
        (set-terminal-coding-system  'utf-8-hfs)
        ))

(setq-default line-spacing 3)
(global-font-lock-mode t)

;; 한글입력할때 완성전까지 안보이는 문제 해결을 위해 내장 한글입력기 사용
; Linux 내장 한글입력기 사용법
; ~/.Xresources 만들고 그안에 Emacs*useXIM: false 입력
; 터미널에 xrdb ~/.Xresources 하고 xrdb -merge ~/.Xresources 하고 이맥스 다시키면 됨
(setq default-korean-keyboard 'korean-hangul2)
;(global-set-key [S-SPC] 'toggle-input-method) ; Ivy모드를 사용하면 S-SPC를 ivy-minibuffer-map에서 remapping 해줘야 한다.
;(global-set-key [?\S- ] 'toggle-input-method) ; Ivy모드를 사용하면 S-SPC를 ivy-minibuffer-map에서 remapping 해줘야 한다.
(global-set-key (kbd "S-SPC") 'toggle-input-method) ; Ivy모드를 사용하면 S-SPC를 ivy-minibuffer-map에서 remapping 해줘야 한다.
(global-set-key (kbd "<f17>") 'toggle-input-method) ; macos shift-space setting Karabiner를 사용해야된다.
;(global-set-key [kbd "<Hangul>"] 'toggle-input-method)

(use-package restart-emacs :ensure t :pin melpa :defer t)

(defun launch-separate-emacs-in-terminal () (suspend-emacs "fg ; emacs -nw"))
(defun launch-separate-emacs-under-x () (call-process "sh" nil nil nil "-c" "emacs &"))
(defun -restart-emacs ()
    (interactive)
    ;; We need the new emacs to be spawned after all kill-emacs-hooks
    ;; have been processed and there is nothing interesting left
    (let ((kill-emacs-hook (append kill-emacs-hook (list (if (display-graphic-p) #'launch-separate-emacs-under-x
                                                                                 #'launch-separate-emacs-in-terminal)))))
            (save-buffers-kill-emacs))
)

(defun -reload-emacs ()
    (interactive)
    (load-file (expand-file-name "~/.emacs.d/config.el"))
)

(use-package paradox :ensure t :pin melpa
;https://github.com/Malabarba/paradox
:commands (package-list-packages)
:config (paradox-enable)
)

(use-package drag-stuff :ensure t :pin melpa :defer t
:after evil
:init (drag-stuff-global-mode t)
        (drag-stuff-define-keys)
)

(use-package server :config (unless (server-running-p) (server-start)))

;(setq warning-minimum-level :error)

; large date blob read
(setq read-process-output-max (* 1024 1024)) ; 1mb
  
(defun new-buffer-save (name buffer-major-mode)
    (interactive)
    (let ((buffer (generate-new-buffer name)))
         (switch-to-buffer buffer)
         (set-buffer-major-mode buffer)
         (funcall buffer-major-mode)
         (setq buffer-offer-save t))
)

(defun new-buffer (name buffer-major-mode)
    (interactive)
    (let ((buffer (generate-new-buffer name)))
         (switch-to-buffer buffer)
         (set-buffer-major-mode buffer)
         (funcall buffer-major-mode))
)

(defun new-no-name-buffer ()
    (interactive)
    (new-buffer "untitled" 'text-mode)
)

(use-package hungry-delete :ensure t :pin melpa :defer t :disabled
; 공백 지울때 한꺼번에 다지워짐
:init (global-hungry-delete-mode)
)

(use-package face-picker :no-require t
:preface
(defun what-face (pos)
     (interactive "d")
     (let ((face (or (get-char-property (pos) 'read-face-name)
                     (get-char-property (pos) 'face))))
          (if face (message "Face: %s" face) (message "No face at %d" pos))))
)

; text random
(defun randomize-region (beg end)
(interactive "r")
(if (> beg end)
    (let (mid) (setq mid end end beg beg mid)))
(save-excursion
    ;; put beg at the start of a line and end and the end of one --
    ;; the largest possible region which fits this criteria
    (goto-char beg)
    (or (bolp) (forward-line 1))
    (setq beg (point))
    (goto-char end)
    ;; the test for bolp is for those times when end is on an empty
    ;; line; it is probably not the case that the line should be
    ;; included in the reversal; it isn't difficult to add it
    ;; afterward.
    (or (and (eolp) (not (bolp)))
        (progn (forward-line -1) (end-of-line)))
    (setq end (point-marker))
    (let ((strs (shuffle-list
                (split-string (buffer-substring-no-properties beg end)
                            "\n"))))
    (delete-region beg end)
    (dolist (str strs)
        (insert (concat str "\n"))))))

(defun shuffle-list (list)
"Randomly permute the elements of LIST.
All permutations equally likely."
(let ((i 0)
j
temp
(len (length list)))
    (while (< i len)
    (setq j (+ i (random (- len i))))
    (setq temp (nth i list))
    (setcar (nthcdr i list) (nth j list))
    (setcar (nthcdr j list) temp)
    (setq i (1+ i))))
list)

(use-package modern-fringes :ensure t :pin melpa :disabled
:config (modern-fringes-mode)
        (modern-fringes-invert-arrows)
)

;(use-package composite 
;:defer t
;;:if (version<= "27.0" emacs-version) 
;:hook (emacs-lisp-mode)
;:config
;    (let ((alist '((?λ . ,(regexp-opt '("lambda"))
;                  ))))
;         (dolist (char-regexp alist)
;             (set-char-table-range composition-function-table (car char-regexp)
;                                   `([,(cdr char-regexp) 0 font-shape-gstring]))))
;)

(use-package keypression :ensure t :pin melpa
:commands keypression-mode
:custom (keypression-use-child-frame t)
        (keypression-fade-out-delay 1.0)
        (keypression-frame-justify 'keypression-left-fringe)
        (keypression-cast-command-name t)
        (keypression-cast-coommand-name-format "%s  %s")
        (keypression-frame-background-mode 'white)
        (keypression-combine-same-keystrokes t)
        (keypression-frames-maxnum 20)
        (keypression-font-face-attribute '(:width normal :height 200 :weight bold))
)

(use-package evil :ensure t :pin melpa
:custom (evil-want-keybinding nil)
        (evil-want-integration t)
        (evil-want-C-u-scroll t)
        (evil-symbol-word-search t)
:init   (evil-mode 1)
:config (define-key evil-normal-state-map (kbd "q") 'nil)
        (evil-ex-define-cmd "k" 'kill-this-buffer)
)

(use-package general :ensure t :pin melpa
:after evil
:init (setq general-override-states '(insert emacs  hybrid   normal
                                      visual motion override operator replace))
:config
      (general-evil-setup :with-shortname-maps)
      (general-create-definer leader :keymaps '(global override) :states '(n v ) :prefix "SPC")
      (leader "<SPC>" 'counsel-M-x
              "e"     '(:wk "Emacs")
              "b"     '(:wk "Buffer")
              "r"     '(repeat :wk "Repeat Before Command")
              "s"     '(:wk "Spell Check")
              "d"     '(:wk "Debug")
              "n"     '(:wk "File Manger")
              "f"     '(:wk "Find")
              "g"     '(:wk "Git")
              "o"     '(:wk "Org")
              "p"     '(:wk "Paren")
              "t"     '(:wk "Tabbar")
              "u"     '(:wk "Utils")
              "w"     '(:wk "Windows")
              "h"     '(:wk "Hacking")
              "l"     '(:wk "Lisp")
              "hr"    '(:wk "Rust")
              "er"    '(restart-emacs :wk "Restart")
              "el"    '(-reload-emacs :wk "Reload")
              "ff"    '(find-file :wk "Find File")
              "fu"    '(browse-url :wl "Browse url")
              "ep"    '(list-processes :wl "Process")
              "ef"    '((lambda ()(interactive)(find-file "~/.emacs.d/config.org")) :wk "configure file")
              "wf"    '(toggle-frame-fullscreen :wk "FullScreen")
              "wh"    '(shrink-window-horizontally :wk "Right size up")
              "wj"    '(enlarge-window :wk "Right size down")
              "wk"    '(shrink-window :wk "Bottom size up")
              "wl"    '(enlarge-window-horizontally :wk "Bootom size down"))
)

(use-package evil-visualstar :ensure t :pin melpa
; vim visual mode에서 * #를 사용해서 같은 단어 검색가능
:after evil
:config (global-evil-visualstar-mode t)
)

(use-package evil-surround :ensure t :pin melpa
; @call-function
; visual mode S- or gS-
; normal mode ys- or yS-
; change surround cs-
; delete surround ds-
; @select area
; {call-function}- - ;현재부터 단어 끝까지
; {call-function}-i- ;현재 단어
; {call-function}-s- ;현재 줄
; @wrap function
; {select-area}-w
; ${target}( 바꾸고싶은거 ), ${change}(바뀔거)
; 감싸기:     => y-s-i-w-${change}( "(", "{", "[")
; 전부 감싸기 => y-s-s-${change}
; 바꾸기: => c-s-${target}( "(", "{", "["), ${change}
; 벗기기: => d-s-${target}( "(", "{", "[")
:after  evil
:config (global-evil-surround-mode 1)
)

(use-package evil-exchange :ensure t :pin melpa
:after evil
:config (evil-exchange-install)
)

(use-package evil-indent-plus :ensure t :pin melpa
:after evil
:config (evil-indent-plus-default-bindings)
)

(use-package evil-goggles :ensure t :pin melpa :after evil
:config (evil-goggles-mode)
        (setq evil-goggles-pulse t)
        (setq evil-goggles-duration 0.500)
)

(use-package evil-traces :ensure t :pin melpa :after evil
; move: m +{n}, delete: +{n},+{n}d, join: .,+{n}j glboal: g/{target}/{change}
:config (evil-traces-use-diff-faces)
        (evil-traces-mode)
)

(use-package evil-mc :ensure t :pin melpa :disabled
:after evil
:preface
      (defun user-evil-mc-make-cursor-here ()
          (evil-mc-pause-cursors)
          (evil-mc-make-cursor-here))
:general (leader "emh" #'evil-mc-make-cursors-here
                 "ema" #'evil-mc-make-all-cursors
                 "emp" #'evil-mc-pause-cursors
                 "emr" #'evil-mc-resume-cursors
                 "emu" #'evil-mc-undo-all-cursors)
:config (global-evil-mc-mode 1)
)

(use-package evil-nerd-commenter :ensure t :pin melpa :after evil
:general (leader "c" '(:wk "comment")
                 "ci" 'evilnc-comment-or-uncomment-lines
                 "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
                 "cc" 'evilnc-copy-and-comment-lines
                 "cp" 'evilnc-comment-or-uncomment-paragraphs
                 "cr" 'comment-or-uncomment-region
                 "cv" 'evilnc-toggle-invert-comment-line-by-line
                 "\\" 'evilnc-comment-operator)
)

(use-package evil-args :ensure t :pin melpa :after evil
; change argument: c-i-a, delete arguemnt: d-a-a
:config (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
        (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)
        (define-key evil-normal-state-map "L" 'evil-forward-arg)
        (define-key evil-normal-state-map "H" 'evil-backward-arg)
        (define-key evil-motion-state-map "L" 'evil-forward-arg)
        (define-key evil-motion-state-map "H" 'evil-backward-arg)
        (define-key evil-normal-state-map "K" 'evil-jump-out-args)
)


(use-package evil-multiedit :ensure t :pin melpa :disabled)
(use-package evil-iedit-state :ensure t :pin melpa :after (evil iedit))

(use-package evil-matchit :ensure t :pin melpa
:after evil
:config (global-evil-matchit-mode 1)
)

(use-package evil-lion :ensure t :pin melpa
; gl ${operator}
:config (evil-lion-mode)
)

(use-package evil-escape :ensure t :pin melpa :disabled
:config (setq-default evil-escape-key-sequence "jk")
)

(use-package evil-smartparens :ensure t :pin melpa
:after (evil smartparens)
:hook (smartparens-enable . evil-smartparens-mode)
;:init (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode))
)

(use-package evil-numbers :ensure t :pin melpa
;https://github.com/cofi/evil-numbers
:after evil
:general (leader "="     '(evil-numbers/inc-at-pt :wk "++")
                 "-"     '(evil-numbers/dec-at-pt :wk "--"))
         (nmap   "C-c +" '(evil-numbers/inc-at-pt :wk "++")
                 "C-c -" '(evil-numbers/dec-at-pt :wk "--"))
         (       "C-c +" '(evil-numbers/inc-at-pt :wk "++")
                 "C-c =" '(evil-numbers/inc-at-pt :wk "++")
                 "C-c -" '(evil-numbers/dec-at-pt :wk "--"))
)

(use-package evil-extra-operator :ensure t :pin melpa :after (evil fold-this)
:config (global-evil-extra-operator-mode 1)
)

(use-package evil-collection :ensure t :pin melpa
:after (evil)
:custom (evil-collection-setup-minibuffer t)
:init  (add-hook 'magit-mode-hook     (lambda () (evil-collection-magit-setup)     (evil-collection-init)))
       (add-hook 'neotree-mode-hook   (lambda () (evil-collection-neotree-setup)   (evil-collection-init)))
       (add-hook 'evil-mc-mode-hook   (lambda () (evil-collection-evil-mc-setup)   (evil-collection-init)))
       (add-hook 'which-key-mode-hook (lambda () (evil-collection-which-key-setup) (evil-collection-init)))
:config
       (evil-collection-pdf-setup)
       (evil-collection-occur-setup)
       (evil-collection-wgrep-setup)
       (evil-collection-buff-menu-setup)
       (evil-collection-package-menu-setup)
       ;(evil-collection-eshell-setup)
       (evil-collection-vterm-setup) 
       (evil-collection-which-key-setup)
       (evil-collection-evil-mc-setup)
       (evil-collection-calc-setup)
       (evil-collection-init)
)

(use-package buffer-zoom :no-require t
:general (leader "tu" 'text-scale-increase
                 "td" 'text-scale-decrease)
)

(use-package sudo-mode :no-require t
:preface
(defun sudo-find-file (file-name)
    "sudo open"
    (interactive "FSudo Find File: ")
    (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
        (find-file tramp-file-name)))
:general (leader "fs" #'sudo-find-file)
)

(use-package goto-last-change :ensure t :pin melpa :defer t
;https://github.com/camdez/goto-last-change.el
:general (leader "fl" 'goto-last-change)
)

(use-package no-littering :ensure t :pin melpa
:config (require 'recentf)
        (add-to-list 'recentf-exclude no-littering-var-directory)
        (add-to-list 'recentf-exclude no-littering-etc-directory)
        (setq auto-save-file-name-transforms `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
)

(use-package elmacro :ensure t :pin melpa :disabled :config (elmacro-mode))

(use-package beacon :ensure t :pin melpa :init (beacon-mode t))
(use-package git-gutter :ensure t :pin melpa :defer t
:init
    (setq-default display-line-numbers-width 3)
    (global-display-line-numbers-mode t)
    (global-hl-line-mode t)
:custom
    (git-gutter:lighter       " gg")
    (git-gutter:window-width  1)
    (git-gutter:modified-sign ".")
    (git-gutter:added-sign    "+")
    (git-gutter:deleted-sign  "-")
:config
    (global-git-gutter-mode t)
    (set-face-foreground 'git-gutter:added    "#daefa3")
    (set-face-foreground 'git-gutter:deleted  "#FA8072")
    (set-face-foreground 'git-gutter:modified "#b18cce")
)

(setq custom-safe-themes t)
(use-package doom-themes :ensure t :pin melpa
:init    (load-theme   'doom-vibrant t)
         ;(enable-theme 'doom-nord)
:config (doom-themes-org-config)
)

; 자동으로 Dark mode Light mode 변환
(use-package mac-dark-mode :no-require t :disabled
:if *is-mac*
:preface 
(defun set-system-dark-mode ()
    (interactive)
    (if (string= (shell-command-to-string "printf %s \"$( osascript -e \'tell application \"System Events\" to tell appearance preferences to return dark mode\' )\"") "true")
        (load-theme 'doom-one t) ; dark-mode
        (load-theme 'doom-city-lights t)) ; light-mode
)
:config (run-with-idle-timer 60 t (lambda () (set-system-dark-mode)))  ; 1분마다, repeat
)

(use-package all-the-icons :ensure t :pin melpa
:config  (all-the-icons-dired-mode)
)
(use-package doom-modeline :ensure t :pin melpa
:hook   (after-init . doom-modeline-init)
:init   (setq find-file-visit-truename t)
        (setq inhibit-compacting-font-caches t)
        (setq doom-modeline-height 30)
        (setq doom-modeline-icon t) ; current version has error
        (setq doom-modeline-persp-name t)
        (setq doom-modeline-major-mode-icon t)
        (setq doom-modeline-enable-word-count t)
        (setq doom-modeline-lsp t)
        (setq doom-modeline-current-window t)
        (setq doom-modeline-env-version t)
        (setq doom-modeline-env-enable-python t)
        (setq doom-modeline-python-executable "python")
        (setq doom-modeline-env-enable-ruby t)
        (setq doom-modeline-env-ruby-executable "ruby")
        (setq doom-modeline-env-enable-elixir t)
        (setq doom-modeline-env-elixir-executable "iex")
        (setq doom-modeline-env-enable-go t)
        (setq doom-modeline-env-go-executable "go")
        (setq doom-modeline-env-enable-perl t)
        (setq doom-modeline-env-perl-executable "perl")
        (setq doom-modeline-env-enable-rust t)
        (setq doom-modeline-env-rust-executable "rustc")
        (setq doom-modeline-github t)
        (setq doom-modeline-iconer-state-icon t)
        (setq doom-modeline--battery-status t)
        (setq doom-modeline--flycheck-icon t)
        (setq doom-modeline-current-window t)
        (setq doom-modeline-major-mode-color-icon t)
)

(use-package hide-mode-line :ensure t :pin melpa
:after (neotree)
:hook  (neotree-mode . hide-mode-line-mode)
)

(use-package nyan-mode :ensure t :pin melpa
;:after  (doom-modeline)
:config (nyan-mode)
        (setq-default nyan-wavy-trail t)
        (nyan-start-animation)
        (nyan-refresh)
)
(use-package fancy-battery :ensure t :pin melpa
:hook   (after-init . fancy-battery-mode)
:config (fancy-battery-default-mode-line)
        (setq fancy-battery-show-percentage t)
)

(use-package diminish :ensure t :pin melpa :defer t
:init
    (diminish 'c++-mode "C++ Mode")
    (diminish 'c-mode   "C Mode"  )
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

(use-package aggressive-indent :ensure t :pin melpa :disabled
; https://github.com/Malabarba/aggressive-indent-mode
:config (electric-indent-mode nil)
;exclud mode
;(add-to-list 'aggresive-indent-excluded-modes 'html-mode)
)

(use-package smart-tabs-mode :ensure t :pin melpa :defer t :disabled
:config (smart-tabs-insinuate 'c 'c++)
)

(use-package indent-guide :ensure t :disabled
; 문자로 표시하기 때문에 예쁘지 않음
:hook (prog-mode text-mode)
:config
    (setq indent-guide-char      " ")
    ;(setq indent-guide-recursive t)
    (setq indent-guide-delay     0.1)
    (set-face-background 'indent-guide-face "dimgray")
    (indent-guide-mode)
)

(use-package highlight-indentation :ensure t :pin melpa :disabled
:hook   (prog-mode text-mode)
:config ;(highlight-indentation-mode)
)


(use-package highlight-indent-guides :ensure t :disabled
:hook (prog-mode text-mode)
:config
    (highlight-indent-guides-mode)
    (setq highlight-indent-guides-delay 0)
    (setq highlight-indent-guides-auto-enabled nil)
    (set-face-background 'highlight-indent-guides-odd-face       "darkgray")
    (set-face-background 'highlight-indent-guides-even-face      "dimgray")
    (set-face-background 'highlight-indent-guides-character-face "dimgray")
    (setq highlight-indent-guides-method 'column)
)

(use-package indent4-mode :no-require t
:preface
    (defun my-set-indent (n)
        (setq-default tab-width n)
        ;(electric-indent-mode n)
        (setq c-basic-offset n)
        (setq lisp-indent-offset n)
        (setq indent-line-function 'insert-tab)
    )
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
:config
    (global-set-key (kbd "<backtab>") 'un-indent-by-removing-4-spaces)
    (electric-indent-mode nil)
    (my-set-indent 4)
    (setq-default indent-tabs-mode nil)
)

(use-package paren :ensure t :pin melpa
:init   (show-paren-mode 0)
        (electric-pair-mode 0)
:config (setq show-paren-delay 0)
)

(use-package rainbow-delimiters :ensure t :pin melpa
:hook ((prog-mode text-mode) . rainbow-delimiters-mode)
)

(use-package smartparens :ensure t :pin melpa
:general (leader "pr " 'sp-rewrap-sexp
                 "pll" 'sp-forward-slurp-sexp
                 "phh" 'sp-backward-slurp-sexp
                 "plh" 'sp-forward-barf-sexp
                 "phl" 'sp-backward-barf-sexp)
:init (smartparens-global-mode)
)
; elisp double quote problem fix setting
(use-package smartparens-config :ensure smartparens)

(use-package hydra :ensure t :pin melpa :defer t)

(use-package which-key :ensure t :pin melpa
:init   (which-key-mode t)
:config (setq which-key-allow-evil-operators t)
        (setq which-key-show-operator-state-maps t)
        ;(which-key-setup-minibuffer)
        
)

(use-package avy :ensure t :pin melpa
:general (leader "jl" '(avy-goto-line :wk "Jump to line")
                 "jw" '(avy-goto-char :wk "Jump to word"))
)

(use-package ivy :ensure t :pin melpa
:after evil-collection
 ;ivy S-SPC remapping toogle-input-method
:general ("M-x" 'counsel-M-x )
         (:keymaps 'ivy-minibuffer-map
             "S-SPC" 'toggle-input-method
             "<f17>" 'toggle-input-method)
:custom (ivy-use-virtual-buffers      t)
        (ivy-use-selectable-prompt    t)
        (enable-recursive-minibuffers t)
        (ivy-height 20)
        (ivy-count-format "(%d/%d) ")
        (ivy-display-style 'fancy)
        (ivy-re-builders-alist '((counsel-M-x . ivy--regex-fuzzy) (t . ivy--regex-plus)))
        (ivy-format-function 'ivy-format-function-line)
:config (ivy-mode 1)
        (setq ivy-initial-inputs-alist nil)
)

(use-package counsel
:after ivy
:config (counsel-mode)
)

(use-package swiper :ensure t :pin melpa
:after ivy
:general ("C-s"    'swiper)
         ("C-S-s"  'swiper-all)

:config (setq swiper-action-recenter t)
        (setq swiper-goto-start-of-match t)
        (setq swiper-stay-on-quit t)
)

(use-package ivy-posframe :ensure t :pin melpa
:after ivy
:custom (ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
        (ivy-posframe-height-alist            '((t . 20)))
        (ivy-posframe-parameters              '((internal-border-width . 10)))
        (ivy-posframe-width 120)
:config (ivy-posframe-mode t)
)

(use-package counsel-osx-app :ensure t :pin melpa
:after counsel
:general (leader "fa" '(counsel-osx-app :wk "Execute OSX App"))
)

(use-package counsel-fd :ensure t :pin melpa :disabled
:after counsel
:commands (counsel-fd-dired-jump counsel-fd-file-jump)
)


(use-package ivy-yasnippet :ensure t :pin melpa
:after (ivy yasnippet)
:general  ("C-c C-y" 'ivy-yasnippet)
:config (advice-add #'ivy-yasnippet--preview :override #'ignore)
)

(use-package historian :ensure t :pin melpa
:after  (ivy)
:config (historian-mode)
)

(use-package ivy-historian :ensure t :pin melpa
:after  (ivy historian)
:config (ivy-historian-mode)
)

(use-package all-the-icons-ivy :ensure t :pin melpa
:config (all-the-icons-ivy-setup)
)

(use-package ivy-xref :ensure t :pin melpa :disabled
:after (ivy xref)
:config (setq xref-show-xrefs-function #'ivy-xref-show-xrefs)
)

(use-package lsp-ivy :ensure t :pin melpa
:general (leader "hs" '(lsp-ivy-workspace-symbol :wk "Search Symbol")
                 "hS" '(lsp-ivy-global-workspace-symbol :wk "Search Global Symbol"))
)

(use-package counsel-projectile :ensure t :pin melpa
:after  (counsel projectile)
:custom (projectile-completion-system 'ivy)
        (counsel-find-file-ignore-regexp ".ccls-cache/")
:general (leader "fp" '(counsel-projectile-find-file :wk "Search in Project")
                 "fG" '(counsel-projectile-rg        :wk "Grep in Project"))
:config (counsel-projectile-mode 1)

)
(use-package counsel-world-clock :ensure t :pin melpa
:after (counsel)
:general (:keymaps 'counsel-mode-map "C-c c k"  'counsel-world-clock)
)

(use-package counsel-tramp :ensure t :pin melpa
:after counsel
:commands counsel-tramp
:general ("C-c s" 'counsel-tramp)
:init (setq tramp-default-method "ssh")
)

(use-package counsel-org-clock :ensure t :pin melpa :after (counsel org))

(use-package all-the-icons-ivy-rich :ensure t :pin melpa
:config (all-the-icons-ivy-rich-mode t)
)

(use-package ivy-rich :ensure t :pin melpa
:config (ivy-rich-mode 1)
)

(use-package smex :ensure t :pin melpa
:general (leader "fm" #'smex-major-mode-commands)
:init (smex-initialize)
)

(use-package projectile :ensure t :pin melpa
:after ivy
:init   (projectile-mode t)
:config (setq projectile-require-project-root nil)
        (setq projectile-enable-caching t)
        (setq projectile-globally-ignored-directories
            (append '(".ccls-cache" ".git" "__pycache__") projectile-globally-ignored-directories))
        (setq projectile-completion-system 'ivy)
        ;(setq projectile-globally-ignored-files
        ;    (append '() projectile-globaly-ignore-files))
)

(use-package neotree :ensure t :pin melpa
:after (projectile all-the-icons)
:commands (neotree-toggle)
:general (leader "n" #'neotree-toggle)
:init
    (setq projectile-switch-project-action 'neotree-projectile-action)
    (setq-default neo-smart-open t)
:config
    (setq-default neo-window-width 30)
    (setq-default neo-dont-be-alone t)
    (add-hook 'neotree-mode-hook (lambda () (display-line-numbers-mode -1) ))
    (setq neo-force-change-root t)
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
    (setq neo-show-hidden-files t)
)
(use-package all-the-icons-dired :ensure t :pin melpa
:after all-the-icons
:init  (add-hook 'dired-mode-hook 'all-the-dired-mode))

(defun copy-file-name-to-clipboard ()
    "Copy the current buffer file name to the clipboard."
    (interactive)
    (let ((filename (if (equal major-mode 'dired-mode) default-directory (buffer-file-name))))
        (when filename
        (kill-new filename)
            (message "Copied buffer file name '%s' to the clipboard." filename)))
)

(use-package ace-window :ensure t :pin melpa
:commands (ace-window)
:general (leader "wo" 'ace-window)
:config (setq aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8))
)

(use-package eyebrowse :ensure t :pin melpa :defer t
:init (eyebrowse-mode t)
:general (leader "w;" 'eyebrowse-last-window-config
                 "w0" 'eyebrowse-close-window-config
                 "w1" 'eyebrowse-switch-to-window-config-1
                 "w2" 'eyebrowse-switch-to-window-config-2
                 "w3" 'eyebrowse-switch-to-window-config-3
                 "w4" 'eyebrowse-switch-to-window-config-4
                 "w5" 'eyebrowse-switch-to-window-config-5
                 "w6" 'eyebrowse-switch-to-window-config-6
                 "w7" 'eyebrowse-switch-to-window-config-7)
)

(use-package window-purpose :ensure t :pin melpa :disabled)

(use-package exwm :ensure t :pin melpa :disabled
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

(use-package magit :ensure t :pin melpa
:commands magit-status
:general (leader "gs" 'magit-status)
:config (setq vc-handled-backends nil)
)

(use-package forge :ensure t :pin melpa :after magit)


(use-package evil-magit :ensure t :pin melpa
:after (evil magit)
:config  (evil-magit-init)
)

(use-package magithub :ensure t :pin melpa 
:after magit
:general (leader "gd" 'magithub-dashboard)
:init (magithub-feature-autoinject t)
        (setq magithub-clone-default-directory "~/github")
)

(use-package magit-todos :ensure t :pin melpa :after magit :disabled)


;; git history view mode
(use-package smeargle :ensure t :pin melpa
:commands smeagle
)

;(use-package magit-delta :ensure t :pin melpa
;:after magit
;:ensure-system-package 
;    :config
;    )



(use-package gitignore-mode :ensure t :pin melpa :commands gitignore-mode)
(use-package gitconfig-mode :ensure t :pin melpa :commands gitconfig-mode)
(use-package gitattributes-mode :ensure t :pin melpa :commands gitattributes-mode)

(use-package evil-ediff :ensure t :pin melpa
:after evil
:config (evil-ediff-init)
)

(use-package undo-tree :ensure t :pin melpa :diminish undo-tree-mode
:commands (undo-tree-undo undo-tree-redo)
:general (leader "uu" 'undo-tree-undo
                 "ur" 'undo-tree-redo)
:init
    (evil-define-key 'normal 'global (kbd "C-r") #'undo-tree-redo)
    (evil-define-key 'normal 'global "u" #'undo-tree-undo)
    (defalias 'redo 'undo-tree-redo)
    (defalias 'undo 'undo-tree-undo)
:config
    (global-undo-tree-mode)
)

;(use-package undo-propose :ensure t :pin melpa
;:after evil
;:commands undo-propose
;:init   (evil-define-key 'normal 'global (kbd "C-r") #'undo-propose)
;        (evil-define-key 'normal 'global "u" #'undo-only)
;:config (global-undo-tree-mode -1)
;)

(use-package org
:general (leader "oa" 'org-agenda
                 "ob" 'org-iswitchb
                 "oc" 'org-capture
                 "oe" 'org-edit-src-code
                 "ok" 'org-edit-src-exit
                 "ol" 'org-store-link)
:init   (setq org-directory          (expand-file-name     "~/Dropbox/org   "))
        (setq org-default-notes-file (concat org-directory "/notes/notes.org"))
:config (setq org-startup-indented   nil)
)

(use-package org-superstar :ensure t :pin melpa
:after org
:hook (org-mode . org-superstar-mode)
:custom (org-superstar-special-todo-items t)
;:custom-face 
;    (org-level-1 ((t (:inherit outline-1 :height 1.3))))
;    (org-level-2 ((t (:inherit outline-2 :height 1.2))))
;    (org-level-3 ((t (:inherit outline-3 :height 1.1))))
;    (org-level-4 ((t (:inherit outline-4 :height 1.0))))
;    (org-level-5 ((t (:inherit outline-5 :height 1.0))))
)

(use-package org-journal :ensure t :pin melpa :disabled
:after org
:preface
    (defun org-journal-find-location ()
        (org-journal-new-entry t)
        (goto-char (point-min)))
:config
    (setq org-journal-dir (expand-file-name "~/Dropbox/org/journal")
            org-journal-file-format "%Y-%m-%d.org"
            org-journal-date-format "%Y-%m-%d (%A)")
    (add-to-list 'org-agenda-files (expand-file-name "~/Dropbox/org/journal"))
    (setq org-journal-enable-agenda-integration t
            org-icalendar-store-UID t
            org-icalendar-include0tidi "all"
            org-icalendar-conbined-agenda-file "~/calendar/org-journal.ics")
    (org-journal-update-org-agenda-files)
    (org-icalendar-combine-agenda-files)
)

(use-package org-capture
:after org
:config (setq org-reverse-note-order t)
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
:after org
:config (use-package evil-org :ensure t :pin melpa
        :after (org evil)
        :init (add-hook 'org-mode-hook 'evil-org-mode)
            (add-hook 'evil-org-mode-hook (lambda () (evil-org-set-key-theme)))
            (setq org-agenda-files '("~/Dropbox/org/agenda"))
            (require 'evil-org-agenda)
            (evil-org-agenda-set-keys)
        )
)

(use-package org-pomodoro :ensure t :pin melpa
:after org-agenda
:custom
    (org-pomodoro-ask-upon-killing t)
    (org-pomodoro-format "%s")
    (org-pomodoro-short-break-format "%s")
    (org-pomodoro-long-break-format  "%s")
:custom-face
    (org-pomodoro-mode-line         ((t (:foreground "#ff5555"))))
    (org-pomodoro-mode-line-break   ((t (:foreground "#50fa7b"))))
:hook
    (org-pomodoro-started  . (lambda () (notifications-notify
        :title "org-pomodoro"
        :body "Let's focus for 25 minutes!"
        :app-icon "~/.emacs.d/img/001-food-and-restaurant.png")))
    (org-pomodoro-finished . (lambda () (notifications-notify
        :title "org-pomodoro"
        :body "Well done! Take a break."
        :app-icon "~/.emacs.d/img/004-beer.png")))
:general (:keymaps 'org-agenda-mode-map "p"  'org-pomodoro)
)

(use-package org-table-auto-align-mode :load-path "lisp/org-table-auto-align-mode"
:after org
:hook (org-mode . org-table-auto-align-mode)
)

(use-package org-gcal :ensure t :pin melpa :disabled
:after org-agenda
:custom (org-gcal-client-id     "")
        (org-gcal-client-secret "")
        (org-gcal-file-alist    '(("8687lee@gmail.com" . "~/Dropbox/org/agenda/gcal.org")))
:config (add-hook 'org-agenda-mode-hook            (lambda () (org-gcal-sync)))
        (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync)))
)

(use-package orgtbl-aggregate :ensure t :pin melpa :defer t)

(use-package toc-org :ensure t :pin melpa :after org
:hook (org-mode . toc-org-mode)
;:config (add-hook 'org-mode-hook 'toc-org-mode)
)


(use-package calfw :ensure t :pin melpa
:commands cfw:open-calendar-buffer
:config (use-package calfw-org :config (setq cfw:org-agenda-schedule-args '(:deadline :timestamp :sexp)))
)
(use-package calfw-gcal :ensure t :pin melpa :disabled
:init (require 'calfw-gcal))

(use-package ob-restclient :ensure t :pin melpa
:after  (org restclient)
:config (org-babel-do-load-languages 'org-babel-load-languages '((restclient . t)))
)

(use-package org-babel :no-require t
:after org
:config (org-babel-do-load-languages
        'org-babel-load-languages
        '((emacs-lisp . t)
        (python     . t)
        (org        . t)
        (shell      . t)
        (C          . t)))
)
;; 스펠체크 넘어가는 부분 설정
(add-to-list 'ispell-skip-region-alist '(":\\(PROPERTIES\\|LOGBOOK\\):" . ":END:"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_SRC" . "#\\+END_SRC"))
(add-to-list 'ispell-skip-region-alist '("#\\+BEGIN_EXAMPLE" . "#\\+END_EXAMPLE"))

(use-package olivetti :ensure t :pin melpa
:commands (olivetti-mode)
:config (setq olivetti-body-width 120))
(use-package typo :ensure t :pin melpa
:commands (type-mode))
(use-package poet-theme :ensure t :pin melpa :defer t)
(use-package writeroom-mode :ensure t :pin melpa
:commands (writeroom-mode)
:config (setq writeroom-width 100)
)
(define-minor-mode writer-mode
    "poet use writer mode"
    :lighter " writer"
    (if writer-mode
        (progn
            ;(olivetti-mode 1)
            ;(typo-mode 1)
            (beacon-mode 0)
            (display-line-numbers-mode 0)
            (git-gutter-mode 0)
            (writeroom-mode 1))
        ;(olivetti-mode 0)
        ;(typo-mode 0)
        (beacon-mode 1)
        (display-line-numbers-mode 1)
        (git-gutter-mode 1)
        (writeroom-mode 0)))

(use-package mu4e :ensure t :pin melpa :disabled :commands (mu4e))

(use-package rainbow-mode :ensure t :pin gnu
:hook   (prog-mode text-mode)
:config (rainbow-mode)
)

(use-package docker :ensure t :pin melpa 
:commands docker
:general (leader "hud" 'docker)
:custom (docker-image-run-arguments '("-i", "-t", "--rm"))
)

(use-package dockerfile-mode :ensure t :pin melpa
:mode   ("Dockerfile\\'" . dockerfile-mode))

(use-package vterm :ensure t :pin melpa ;:disabled ;macport version not working
:general (leader "tn" 'vterm)
:custom (vterm-always-compile-module t)
:config (add-hook 'vterm-mode-hook (lambda () (display-line-numbers-mode 0)))
)

(use-package vterm-toggle :ensure t :pin melpa :disabled
:after vterm
:general (leader "ut" 'vterm-toggle
                 "tl" 'vterm-toggle-forward
                 "th" 'vterm-toggle-backward
                 "tn" 'vterm)
:config (setq vterm-toggle-fullscreen-p nil)
        (add-to-list 'display-buffer-alist
                     '((lambda(bufname _) (with-current-buffer bufname (equal major-mode 'vterm-mode)))
                                     (display-buffer-reuse-window display-buffer-in-direction)
                                     (direction . bottom)
                                     (reusable-frames . visible)
                                     (window-height . 0.3)))
)

(use-package vterm-with-centaur-tab :no-require t
:after (vterm-toggle centaur-tabs)
:preface (defun vmacs-awesome-tab-buffer-groups ()
          "`vmacs-awesome-tab-buffer-groups' control buffers' group rules. "
          (list
           (cond
            ((derived-mode-p 'eshell-mode 'term-mode 'shell-mode 'vterm-mode) "Term")
            ((string-match-p (rx (or "\*Helm"
                                     "\*helm"
                                     "\*tramp"
                                     "\*Completions\*"
                                     "\*sdcv\*"
                                     "\*Messages\*"
                                     "\*Ido Completions\*"))
                                     (buffer-name))
             "Emacs")
            (t "Common"))))
        ;(defun vmacs-term-mode-p(&optional args)
        ;    (derived-mode-p 'eshell-mode 'term-mode 'shell-mode 'vterm-mode))
:config (setq centaur-tabs-buffer-groups-function   'vmacs-awesome-tab-buffer-groups)
        ;(setq vterm-toggle--vterm-buffer-p-function 'vmacs-term-mode-p)
)

(use-package shell-pop :ensure t :pin melpa
:custom (shell-pop-shell-type '("term" "vterm" (lambda () (vterm))))
        ;(shell-pop-universal-key "C-1")
        (shell-pop-term-shell "/bin/zsh")
        (shell-pop-full-span t)
        ;(shell-pop-shell-type '("ansi-term" "*ansi-term*" (lambda () (ansi-term shell-pop-term-shell))))
        ;(shell-pop-shell-type '("eshell" "* eshell *" (lambda () (eshell))))
:general (leader "ut"'shell-pop)
:init    (global-set-key (kbd "<C-t>") 'shell-pop)
)

(use-package with-editor :ensure t :pin melpa
:hook ((shell-mode term-exec eshll-mode) . with-editor-export-editor)
)

(use-package vterm-command :no-require t
:after (vterm)
:preface
(defun run-in-vterm-kill (process event)
  "A process sentinel. Kills PROCESS's buffer if it is live."
  (let ((b (process-buffer process)))
    (and (buffer-live-p b)
         (kill-buffer b))))

(defun run-in-vterm (command)
  "Execute string COMMAND in a new vterm.
Interactively, prompt for COMMAND with the current buffer's file
name supplied. When called from Dired, supply the name of the file at point.

Like `async-shell-command`, but run in a vterm for full terminal features.

The new vterm buffer is named in the form `*foo bar.baz*`, the
command and its arguments in earmuffs.

When the command terminates, the shell remains open, but when the
shell exits, the buffer is killed."
  (interactive
   (list
    (let* ((f (cond (buffer-file-name)
                    ((eq major-mode 'dired-mode)
                     (dired-get-filename nil t))))
           (filename (concat " " (shell-quote-argument (and f (file-relative-name f))))))
      (read-shell-command "Terminal command: "
                          (cons filename 0)
                          (cons 'shell-command-history 1)
                          (list filename)))))
  (with-current-buffer (vterm (concat "*" command "*"))
    (set-process-sentinel vterm--process #'run-in-vterm-kill)
    (vterm-send-string command)
    (vterm-send-return)))
)

(use-package eshell
:commands eshell
:config (setq eshell-buffer-maximum-lines 1000)
        ;(require 'xterm-color)
        (add-hook 'eshell-mode-hook (lambda () (setq pcomplete-cycle-completions     nil)))
        ;(add-hook 'eshell-mode-hook (lambda () (setq xterm-color-preserve-properties t) (setenv "TERM" "xterm-256color")))
        (add-to-list 'eshell-preoutput-filter-functions 'xterm-color-filter)
        (setq eshell-output-filter-functions (remove 'eshell-handle-asni-color eshell-output-filter-functions))
        (setq eshell-cmpl-cycle-completions nil)
)

(use-package exec-path-from-shell :ensure t :pin melpa
:if     (memq window-system '(mac ns x))
:custom (exec-path-from-shell-variables '("PATH"))
        (exec-path-from-shell-initialize)
)

(use-package eshell-did-you-mean :ensure t :pin melpa
:after  eshell
:config (eshell-did-you-mean-setup)
)

(use-package esh-help :ensure t :pin melpa
:after (eshell eldoc)
:config (setup-esh-help-eldoc)
)

(use-package eshell-prompt-extras :ensure t :pin melpa
:after eshell
:config
    (autoload 'epe-theme-lambda   "eshell-prompt-extras")
    (setq eshell-highlight-prompt nil)
    (setq eshell-prompt-function  'epe-theme-lambda)
)

(use-package fish-completion :ensure t :pin melpa
:after eshell
:config (when (and (executable-find "fish")
                   (require 'fish-completion nil t))
              (global-fish-completion-mode))
)

(use-package esh-autosuggest :ensure t :pin melpa
:after eshell
:hook (eshell-mode . esh-autosuggest-mode)
)

(use-package eshell-up :ensure t :pin melpa
:after eshell
:config (add-hook 'eshell-mode-hook (lambda () (eshell/alias "up" "eshell-up $1")
                                          (eshell/alias "pk" "eshell-up-peek $1")))
)

(use-package execute-shell :no-require t
:after eshell
:preface
(defun background-shell-command (command)
    "run shell commmand background"
    (interactive "sShell Command : ")
    (call-process-shell-command "command" nil 0))
:config (add-to-list 'display-buffer-alist
        (cons "\\*Async Shell Command\\*.*" (cons #'display-buffer-no-window nil)))
)

(use-package command-log-mode :ensure t :pin melpa :defer t)

(use-package emojify :ensure t :pin melpa :defer t
:if window-system
:config (global-emojify-mode 1)
        (setq emojify-display-style 'image)
        (setq emojify-emoji-styles  '(unicode))
        (setq emojify-emoji-set "emojione-v2.2.6")
)

(use-package buffer-move :ensure t :pin melpa :defer t
:general (leader "b s" 'switch-to-buffer
                 "b r" 'eval-buffer
                 "b h" 'buf-move-left
                 "b j" 'buf-move-down
                 "b k" 'buf-move-up
                 "b l" 'buf-move-right
                 "b m" 'switch-to-buffer
                 "b n" 'next-buffer
                 "b p" 'previous-buffer)
:init
    (global-set-key (kbd "C-x C-b") 'switch-to-buffer)
    (setq ibuffer-saved-filter-groups
        '(("home"
                ("emacs-config" (or (filename . ".emacs.d")
                                    (filename . "emacs-config")))
                ("org-mode"     (or (mode . org-mode)
                                    (filename ."OrgMode")))
                ("code"         (or (filename . "~/dev")
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
)

(use-package all-the-icons-ibuffer :ensure t :pin melpa
:after all-the-icons
:hook (ibuffer-mode . all-the-icons-ibuffer-mode)
)


(use-package ibuffer-projectile :ensure t :pin melpa :disabled
:after (projectile)
:init  (add-hook 'ibuffer-hook (lambda () (ibuffer-projectile-set-filter-groups)
                                     (unless (eq ibuffer-sorting-mode 'alphabetic)
                                             (ibuffer-do-sort-by-alphabetic))))
)

(use-package org-roam :ensure t :pin melpa 
:hook (after-init . org-roam-mode)
:custom (org-roeam-directory "~/GoogleDrive/Org/")
;:general (leader "on" '(org-roam-mode-map :wk "Note"))
)

(use-package org-roam-server :ensure t :pin melpa :after (org-roam)
:commands org-roam-server-mode
:config
    (setq org-roam-server-host "127.0.0.1"
          org-roam-server-port 8080
          org-roam-server-export-inline-images t
          org-roam-server-authenticate nil
          org-roam-server-network-poll t
          org-roam-server-network-arrows nil
          org-roam-server-network-label-truncate t
          org-roam-server-network-label-truncate-length 60
          org-roam-server-network-label-wrap-length 20)
)

(use-package dash :ensure t :pin melpa :defer t
:init (dash-enable-font-lock)
)
(use-package dash-functional :ensure t :pin melpa
:after dash
)

(use-package ialign :ensure t :pin melpa :defer t
:general (leader "ta" 'ialign))

(use-package page-break-lines :ensure t :pin melpa :defer t)
(use-package dashboard :ensure t :pin melpa
:init (dashboard-setup-startup-hook)
:config
    (setq dashboard-banner-logo-title "We are Emacsian!")
    (setq dashboard-startup-banner "~/.emacs.d/image/emacs_icon.png") ;banner image change
    (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)
    (setq dashboard-show-shortcuts nil)
    (setq dashboard-set-navigator t)
    ;(setq dashboard-center-content t)
    (setq dashboard-set-init-info t)
    (setq show-week-agenda-p t)
    (setq dashboard-items '((recents   . 5)
                            (bookmarks . 5)
                            (projects  . 5)
                            (agenda    . 5)))
    (add-hook 'dashboard-mode-hook (lambda () (display-line-numbers-mode -1) ))
)

(use-package centaur-tabs :ensure t :pin melpa
:custom (centaur-tabs-background-color (face-background 'default))
        (centaur-tabs-set-icons t)
        (centaur-tabs-set-close-button t)
        (centaure-tabs-set-bar t)
        (centaur-tabs-style "zigzag")
        ;(centaur-tabs-set-bar 'left) with tabs-stype "bar"
:init   (centaur-tabs-mode t)
:config (setq centaur-tabs-height 26)
        (centaur-tabs-headline-match)
        (centaur-tabs-group-by-projectile-project)
:general (leader "th" 'centaur-tabs-backward
                 "tl" 'centaur-tabs-forward)
)

(use-package symon :ensure t :pin melpa :defer t)

(use-package google-this :ensure t :pin melpa
:commands google-this
:general (leader "fw" '(google-this :wk "Search Word"))
:config  (google-this-mode 1)
)
(use-package osa :load-path "lisp/osa")
(use-package osa-chrome :load-path "lisp/osa-chrome"
:after osa
:commands osa-chrome
:general (leader "fc" '(osa-chrome :wk "Chrome manage"))
)

(use-package google-translate :ensure t :pin melpa
:commands (google-translate-smooth-translate)
:general (leader "ft" 'google-translate-smooth-translate)
:custom (google-translate-default-source-language "auto")
        (google-translate-default-target-language "ko")
        (google-translate-translation-directions-alist
            '(("en" . "ko")
              ("ko" . "en")
              ("jp" . "ko")
              ("ko" . "jp")))
:config (require 'google-translate-smooth-ui)
)

(use-package flyspell :ensure t :pin melpa :defer t :disabled
:config
    (add-hook 'prog-mode-hook 'flyspell-prog-mode)
    (add-hook 'text-mode-hook 'flyspell-mode)
    (setq ispell-program-name "hunspell")
    (setq ispell-dictionary "en_US")
;:init
;    (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
:general (leader "sk" '((lambda () (interactive) (ispell-change-dictionary "ko_KR") (flyspell-buffer)) :wk "Spell Dictionary Korean")
                 "se" '((lambda () (interactive) (ispell-change-dictionary "en_US") (flyspell-buffer)) :wk "Spell Dictionary English"))
)

(use-package flyspell-correct-ivy :ensure t :pin melpa 
:after (flyspell ivy)
:general  (:keymaps 'flyspell-mode-map "C-c $" 'flyspell-correct-word-generic)
          (:keymaps 'flyspell-mode-map [remap flyspell-correct-word-before-point]  'flyspell-correct-previous-word-generic)
          (leader "ss" '(flyspell-correct-word-generic :wk "Suggestion"))
)

(use-package wgrep :ensure t :pin melpa
:after evil-collection
:config (setq wgrep-auto-save-buffer t)
        (evil-collection-wgrep-setup)
       ;(setq wgrep-enable-key "r")
)

(use-package iedit :ensure t :pin melpa
:general (leader "fi" 'iedit-mode)
)

; package testing 
(use-package try :ensure t :pin melpa :defer t)

(use-package org-use-package :no-require t
:after (evil org)
:preface
(defun org-use-package-install ()
    "org babel emacs config evaluate"
    (interactive)
    (org-babel-tangle)
    (org-babel-execute-maybe)
    (undo-tree-undo))
:general (leader "oi" 'org-use-package-install
                 "ot" 'polymode-next-chunk
                 "oh" 'polymode-previous-chunk
                 "or" 'save-buffer)
)

(setq helm-mode nil)
(use-package helm :if helm-mode :config (load-file "~/.emacs.d/lisp/helm-mode.el"))

(use-package pdf-tools :ensure t :pin melpa :defer t)

(use-package smeargle :ensure t :pin melpa)

(use-package polymode :ensure t :pin melpa
:init (add-hook 'polymode-init-inner-hook #'evil-normalize-keymaps)
)
(use-package poly-org :ensure t :pin melpa :hook (org-mode . poly-org-mode)
:init (evil-set-initial-state 'poly-org-mode 'normal)
)

(use-package tldr :ensure t :pin melpa
:commands tldr
:custom (tldr-enabled-categories '("common" "linux" "osx" "sunos"))
)

(if (fboundp 'mac-auto-operator-composition-mode) (mac-auto-operator-composition-mode))
;(use-package fira-code :no-require t
;:if *is-mac*
;:config (if (fboundp 'mac-auto-operator-composition-mode) (mac-auto-operator-composition-mode))
;)
;(use-package fira-code-mode :load-path "lisp/fira-code-mode"
;:custom (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x")) ;; List of ligatures to turn off
;
;:hook prog-mode ;; Enables fira-code-mode automatically for programming major modes  
;)

; 오직 company-complete-selection으로 만 해야지 snippet 자동완성이 작동됨
(use-package company :ensure t :pin melpa
:custom
    ;(company-show-numbers t)
    (company-idle-delay 0)
    (company--transform-candidates nil)
    (company-minimum-prefix-length 1)
    (company-tooltip-align-annotations nil)
:init   (global-company-mode 1)
:config (add-to-list 'company-backends '(company-capf :with company-yasnippet))
        (setq company-dabbrev-downcase nil)
        (company-tng-configure-default)

)

(use-package company-quickhelp :ensure t :pin melpa
:unless (featurep 'lsp)
:general (:keymaps 'company-active-map "C-c h"  'company-quickhelp-manual-begin)
:custom (company-quickhelp-delay nil)
:config (company-quickhelp-mode)
)

(use-package company-dict :ensure t :pin melpa :disabled
:after company
:custom (company-dict-dir (concat user-emacs-directory "dict/"))
        (company-dict-enable-yasnippet t)
        (company-dict-enable-fuzzy t)
:config (add-to-list 'company-backends 'company-dict)
        (define-key evil-insert-state-map (kbd "C-x C-k") 'company-dict)
        (setq company-dict-minor-mode-list t)
)


(use-package company-statistics :ensure t :pin melpa
:after company
:config (company-statistics-mode)
)

;company-quickhelp speed up setting
(use-package company-posframe :ensure t :pin melpa
:after company
:config (company-posframe-mode)
)

(use-package company-flx :ensure t :pin melpa
:after company
:config (company-flx-mode 1)
)


(use-package company-fuzzy :ensure t :pin melpa :disabled
:after company
:config (company-fuzzy-mode)
        (setq company-fuzzy-sorting-backend 'flx)
        ;(setq company-fuzzy-prefix-ontop t)
)

; deep learning completion
(use-package company-tabnine :ensure t :pin melpa :disabled 
:config
    (add-to-list 'company-backends #'company-tabnine)
    (setq company-tabnine-annotations t)
    (setq company-tabnine-always-trigger nil)
)

(use-package company-box :ensure t :pin melpa :diminish ""
:hook   (company-mode . company-box-mode)
:custom (company-box-max-candidates 30)
:config (setq company-box-icons-unknown 'fa_question_circle)
        (setq company-box-color-icon t)
        (setq company-box-backends-colors nil)
        (setq company-box-icons-yasnippet 'fa_bookmark)
        (setq company-box-icons-lsp
            '((1 . fa_text_height) ;; Text
                (2 . (fa_tags :face font-lock-function-name-face)) ;; Method
                (3 . (fa_tag :face font-lock-function-name-face)) ;; Function
                (4 . (fa_tag :face font-lock-function-name-face)) ;; Constructor
                (5 . (fa_cog :foreground "#FF9800")) ;; Field
                (6 . (fa_cog :foreground "#FF9800")) ;; Variable
                (7 . (fa_cube :foreground "#7C4DFF")) ;; Class
                (8 . (fa_cube :foreground "#7C4DFF")) ;; Interface
                (9 . (fa_cube :foreground "#7C4DFF")) ;; Module
                (10 . (fa_cog :foreground "#FF9800")) ;; Property
                (11 . md_settings_system_daydream) ;; Unit
                (12 . (fa_cog :foreground "#FF9800")) ;; Value
                (13 . (md_storage :face font-lock-type-face)) ;; Enum
                (14 . (md_closed_caption :foreground "#009688")) ;; Keyword
                (15 . md_closed_caption) ;; Snippet
                (16 . (md_color_lens :face font-lock-doc-face)) ;; Color
                (17 . fa_file_text_o) ;; File
                (18 . md_refresh) ;; Reference
                (19 . fa_folder_open) ;; Folder
                (20 . (md_closed_caption :foreground "#009688")) ;; EnumMember
                (21 . (fa_square :face font-lock-constant-face)) ;; Constant
                (22 . (fa_cube :face font-lock-type-face)) ;; Struct
                (23 . fa_calendar) ;; Event
                (24 . fa_square_o) ;; Operator
                (25 . fa_arrows)) ;; TypeParameter
            )
        ;(company-box-show-single-candidate t)
        ;(setq company-box-icons-alist 'company-box-icons-all-the-icons)
        ;(company-box-doc-delay 0.5)
)

(use-package lsp-mode :ensure t :pin melpa
:commands lsp
:general (leader "hh" '(lsp-execute-code-action :wk "wizard"))
:hook   ((lsp-mode . lsp-enable-which-key-integration))
:custom (lsp-inhibit-message t)
        (lsp-message-project-root-warning t)
        (lsp-enable-snippet t)
        (lsp-enable-file-watchers nil)
        (lsp-enable-completion-at-point t)
        (lsp-prefer-flymake nil)
        (create-lockfiles nil)
        (lsp-file-watch-threshold nil)
        (lsp-response-timeout 25)
        (lsp-completion-provider :capf)
:config (lsp-ui-mode)
        (lsp-lens-mode)
)
(use-package lsp-ui :ensure t :pin melpa
:commands lsp-ui-mode
:after  (lsp-mode flycheck)
:custom (scroll-margin 0)
        (lsp-ui-flycheck-enable t)
        (lsp-ui-sideline-show-diagnostics t)
        ;(lsp-ui-sideline-show-hover t)
        (lsp-ui-sideline-show-code-actions t)
:config (lsp-ui-sideline-mode)
        (lsp-ui-peek-mode)
)

(use-package flycheck :ensure t :pin melpa
:after  company
:custom (flycheck-clang-language-standard "c++17")
:config (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
        (global-flycheck-mode t)
        (setq flycheck-clang-language-standard "c++17")
)
(use-package flycheck-pos-tip :ensure t :pin melpa :disabled
:if (not (featurep 'lsp))
:after  flycheck
:config (flycheck-pos-tip-mode))

(use-package quick-peek :ensure t :pin melpa :after flycheck :disabled)
(use-package flycheck-inline :ensure t :pin melpa :disabled
:if (not (featurep 'lsp))
:after (flycheck quick-peek)
:config
    (setq flycheck-inline-display-function
        (lambda (msg pos)
            (let* ((ov (quick-peek-overlay-ensure-at pos))
                (contents (quick-peek-overlay-contents ov)))
            (setf (quick-peek-overlay-contents ov)
                    (concat contents (when contents "\n") msg))
            (quick-peek-update ov)))
        flycheck-inline-clear-function #'quick-peek-hide)
    (global-flycheck-inline-mode)
)

(use-package yasnippet :ensure t :pin melpa
;https://github.com/joaotavora/yasnippet
:after (company)
:custom (yas-snippet-dirs '("~/.emacs.d/yas/"))
:general (leader  "hy"  '(:wk "Yasnippet")
                  "hyl" 'company-yasnippet)
:config (yas-global-mode t)
        (yas-reload-all t)
)

(use-package yasnippet-snippets :ensure t :pin melpa :after yasnippet)
(use-package auto-yasnippet :ensure t :pin melpa
;https://github.com/abo-abo/auto-yasnippet
:after yasnippet
:general (leader "hyc" 'aya-create
                 "hye" 'aya-expand)
)

(use-package cpp-mode ;:load-path "lisp/cpp-mode"
:no-require t
:mode (("\\.h\\'" . c++-mode))
;:commands cpp-mode
:general (leader "hc" '(:wk "C/C++"))
;:hook (c-mode-common . 'cpp-mode)
:init (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;      (add-hook 'c++-mode-hook  'cpp-mode)
;      (add-hook 'c-mode-hook    'cpp-mode)
;      (add-hook 'objc-mode-hook 'cpp-mode)
)

(use-package ccls :ensure t :pin melpa ; with lsp or eglot mode
:hook   ((c-mode-common) . (lambda () (lsp)))
:custom (ccls-sem-highlight-method 'font-lock)
        (ccls-use-default-rainbow-sem-highlight)
        (ccls-extra-init-params '(:client (:snippetSupport :json-false)))
:config ;(setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
        ;(setq ccls-initialization-options '(:clang (:extraArgs ["-isystem/usr/local/opt/llvm/include/c++/v1"
        ;                                                        "-isystem/usr/local/Cellar/llvm/10.0.0_3/lib/clang/10.0.0/include"
        ;                                                       ; "-isystem/Library/Developer/CommandLineTools/usr/include/c++/v1/"   
        ;                                                        "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/"
        ;                                                        "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks"
        ;                                                       ; "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/"
        ;                                                       ]
        ;                                            :resourceDir "/usr/local/Cellar/llvm/10.0.0_3/lib/clang/10.0.0")))
)

(use-package cppm :no-require t
:after c++-mode
:general (leader "hcb" (lambda () (eshell-command "cppm build"))
                 "hcr" (lambda () (eshell-command "cppm run  ")))
)

(use-package company-c-headers :ensure t :pin melpa
:after  (company c++-mode)
:config (add-to-list 'company-backends 'company-c-headers)
)
(use-package clang-format :ensure t :pin melpa
:after  (c++-mode)
:init   (add-hook 'c++-mode-hook 'clang-format)
:general (leader "hccf" 'clang-format-regieon)
)

(use-package irony :ensure t :pin melpa :diminish irony-mode :disabled ; no lsp or eglot mode 
:after (c++-mode)
:hook  (c++-mode . irony-mode)
;:custom ((irony-cdb-search-directory-list (quote ("." "build" "bin")))
;         (irony-additional-clang-options '("-std=c++17")))
:config
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    (setq irony-additional-clang-options '("-std=c++17"))
    (setq irony-cdb-search-directory-list (quote ("." "build" "bin")))
)

(use-package irony-eldoc :ensure t :pin melpa
:after (irony eldoc)
:config (add-hook 'irony-mode-hook #'irony-eldoc)
)

(use-package company-irony :ensure t :pin melpa
:after  (company irony)
:config (add-to-list 'company-backends 'company-irony)
)

(use-package flycheck-irony :ensure t :pin melpa :after (flycheck irony) :config (flycheck-irony-setup))

(use-package company-irony-c-headers :ensure t :pin melpa
:after  (company-c-headers irony)
:config (add-to-list 'company-backends 'company-irony-c-headers)
)

(use-package rtags :ensure t :pin melpa :disabled
:after  c++-mode
:custom (rtags-verify-protocol-version nil "rtags version bug fix")
:preface
(defun setup-flycheck-rtags ()
    (interactive)
    (flycheck-select-checker 'rtags)
    ;; RTags creates more accurate overlays.
    (setq-local flycheck-highlighting-mode nil)
    (setq-local flycheck-check-syntax-automatically nil))
:config
    (rtags-enable-standard-keybindings)
    (setq rtags-autostart-diagnostics t)
    (rtags-diagnostics)
    (setq rtags-completions-enabled t)
    (rtags-start-process-unless-running)
:general (leader "hcfs" 'rtags-find-symbol
                 "hcfr" 'rtags-find-references)
)

(use-package ivy-rtags :ensure t :pin melpa
:after  (ivy rtags)
:config (setq rtags-display-result-backend 'ivy)
)

(use-package company-rtags :ensure t :pin melpa
:after  (company rtags)
:config (add-to-list 'company-backends 'company-rtags))

(use-package flycheck-rtags :ensure t :pin melpa
:after (flycheck rtags)
:preface
    (defun my-flycheck-rtags-setup ()
        (flycheck-select-checker 'rtags)
        (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
        (setq-local flycheck-check-syntax-automatically nil))
:config
    (add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
    (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard   "c++17")))
    (add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++17")))
    ;(add-hook 'c-mode-hook    #'my-flycheck-rtags-setup)
    ;(add-hook 'c++-mode-hook  #'my-flycheck-rtags-setup)
    ;(add-hook 'objc-mode-hook #'my-flycheck-rtags-setup)
    ;(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard   "c++17")))
    ;(add-hook 'c++-mode-hook (lambda () (setq flycheck-clang-language-standard "c++17")))
)

(use-package cmake-ide :ensure t :pin melpa
:after (rtags)
:config
    (require 'subr-x)
    (cmake-ide-setup)
    (setq cmake-ide-flags-c++ (append '("-std=c++17")))
    ;(defadvice cmake-ide--run-cmake-impl
    ;  (after copy-compile-commands-to-project-dir activate)
    ;  (if (file-exists-p (concat project-dir "/build/compile_commands.json"))
    ;  (progn
    ;      (cmake-ide--message "[advice] found compile_commands.json" )
    ;      (copy-file (concat project-dir "compile_commands.json") cmake-dir)
    ;      (cmake-ide--message "[advice] copying compile_commands.json to %s" cmake-dir))
    ;      (cmake-ide--message "[advice] couldn't find compile_commands.json" ))
    ;)
)

(use-package lsp-treemacs :ensure t :pin melpa :disabled
:after lsp-mode
:config (lsp-metals-treeview-enable t)
        (setq lsp-metals-treeview-show-when-views-received t)
) 

(use-package dap-mode :ensure t :pin melpa
:after lsp-mode
:commands (dap-debug)
:general (leader "dd" 'dap-debug)
:custom (dap-lldb-debug-program `("/Users/nieel/.vscode/extensions/lanza.lldb-vscode-0.2.2/bin/darwin/bin/lldb-vscode")) 
:config (require 'dap-gdb-lldb) ; gdb mode
        (dap-mode 1)
        (dap-tooltip-mode 1)
        (dap-ui-mode 1)
        (dap-auto-configure-mode)
)

(use-package dap-ui-setting :no-require t
:after dap-mode
:preface
  (defun my/window-visible (b-name)
      "Return whether B-NAME is visible."
      (-> (-compose 'buffer-name 'window-buffer)
          (-map (window-list))
          (-contains? b-name)))

  (defun my/show-debug-windows (session)
      "Show debug windows."
      (let ((lsp--cur-workspace (dap--debug-session-workspace session)))
          (save-excursion
          ;; display locals
          (unless (my/window-visible dap-ui--locals-buffer)
              (dap-ui-locals))
          ;; display sessions
          (unless (my/window-visible dap-ui--sessions-buffer)
              (dap-ui-sessions)))))

  (defun my/hide-debug-windows (session)
      "Hide debug windows when all debug sessions are dead."
      (unless (-filter 'dap--session-running (dap--get-sessions))
          (and (get-buffer dap-ui--sessions-buffer)
              (kill-buffer dap-ui--sessions-buffer))
          (and (get-buffer dap-ui--locals-buffer)
              (kill-buffer dap-ui--locals-buffer))))
:config
    (add-hook 'dap-terminated-hook 'my/hide-debug-windows)
    (add-hook 'dap-stopped-hook 'my/show-debug-windows)
)

(use-package gdb-mi :load-path "lisp/emacs-gdb"
:commands gdb-executable
:general (leader "de" 'gdb-executable
                 "dn" 'gdb-next
                 "di" 'gdb-step
                 "df" 'gdb-finish)
:config (setq-default gdb-show-main t)
        (setq-default gdb-many-windows t)
        (fmakunbound 'gdb)
        (fmakunbound 'gdb-enable-debug)
    ;(evil-leader/set-key "dt" '(lambda () (call-interactively 'gub-tbreak) (call-interactively 'gud-cont)))
)

; only c/c++
(use-package disaster :ensure t :pin melpa :commands disaster)

(use-package eldoc :ensure t :pin melpa :diminish eldoc-mode :commands eldoc-mode)
(use-package eldoc-rtags :no-require t
:after (eldoc rtags)
:preface
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
        "rtags eldoc extensions"
        (interactive)
        (setq-local eldoc-documentation-function #'rtags-eldoc-function)
        (eldoc-mode 1)
    )
:config
    (add-hook 'c-mode-hook   'rtags-eldoc-mode)
    (add-hook 'c++-mode-hook 'rtags-eldoc-mode)
)

(use-package emacs-lisp :no-require t
:general (leader "le" '(eval-print-last-sexp :wk "Elisp Evaluate"))
)

(use-package scratch-comment :ensure t :pin melpa
:general (:keymaps 'lisp-interaction-mode-map "C-j" 'scratch-comment-eval-sexp)
)
  
(use-package slime :ensure t :pin melpa :disabled
:commands slime
:config
    (setq inferior-lisp-program (or (executable-find "sbcl")
                                    (executable-find "/usr/bin/sbcl")
                                    (executable-find "/usr/sbin/sbcl" )))
    (require 'slime-autoloads)
    (slime-setup '(slime-fancy))
)
(use-package elisp-slime-nav :ensure t :pin melpa :diminish elisp-slime-nav-mode
:after slime
:hook ((emacs-lisp-mode ielm-mode) . elisp-slime-nav-mode)
)

(use-package prettify-symbols :no-require t :hook ((emacs-lisp-mode lisp-mode org-mode) . prettify-symbols-mode))

(use-package paredit :ensure t :pin melpa :disabled
:init
(add-hook 'emacs-lisp-mode-hook #'paredit-mode)
;; enable in the *scratch* buffer
(add-hook 'lisp-interaction-mode-hook #'paredit-mode)
(add-hook 'ielm-mode-hook #'paredit-mode)
(add-hook 'lisp-mode-hook #'paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'paredit-mode)
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode t)))
)

(use-package parinfer :ensure t :pin melpa :disabled
:after (evil)
:general ("C-,"  'parinfer-toggle-mode)
:init 
(add-hook 'emacs-lisp-mode-hook  #'parinfer-mode)
(add-hook 'common-lisp-mode-hook #'parinfer-mode)
(add-hook 'lisp-mode-hook        #'parinfer-mode)
;(add-hook 'clojure-mode-hook     #'parinfer-mode)
;(add-hook 'scheme-mode-hook      #'parinfer-mode)
:config
(setq parinfer-extensions '(defaults evil paredit pretty-parens)) ;lispy smart-tab smart-yank
)

(use-package rust-mode :ensure t :pin melpa
:ensure-system-package (rustup . "curl https://sh.rustup.rs -sSf | sh")
:mode (("\\.rs\\'" . rust-mode))
:hook (rust-mode . lsp)
:general (leader "hrf" 'rust-format-buffer)
:config  (setq lsp-rust-rls-command '("rustup", "run", "nightly", "rls"))
         (setq lsp-rust-server 'rust-analyzer)
         (setq lsp-rust-analyzer-cargo-watch-enable nil) ;; large project에서 cargo crate를 check하는것을 방지
         ;(lsp-rust-analyzer-inlay-hints-mode t) ; display type hint 
         ;(setq rust-format-on-save t)
         ;(add-hook 'rust-mode-hook (lambda () (local-set-key (kbd "C-c <tab>") #'rust-format-buffer)))
)

(use-package flycheck-rust :ensure t :pin melpa
:after  (flycheck rust-mode)
:config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
)

(use-package racer :ensure t :pin melpa :disabled
:ensure-system-package ((racer . "rustup toolchain add nightly")
                        (racer . "rustup component add rust-src")
                        (racer . "cargo +nightly install racer"))
:after (rust-mode eldoc)
:hook  ((rust-mode  . racer-mode)
        (racer-mode . eldoc-mode))
;:init  (add-hook 'racer-mode-hook  #'eldoc-mode)
)

(use-package company-racer :ensure t :pin melpa
:after  (company racer)
:config (add-to-list 'company-backends 'company-racer)
)

(use-package cargo :ensure t :pin melpa
:after  rust-mode
:hook (rust-mode . cargo-minor-mode)
:commands cargo-minor-mode
:general (leader "hrb" 'cargo-process-build
                 "hrr" 'cargo-process-run
                 "hrt" 'cargo-process-test)
)

;(use-package rustic :ensure t :pin melpa
;:commands (rustic-mode)
;:mode   ("\\.rs" . rustic-mode)
;:config ;(add-hook 'rustic-mode-hook 'racer-mode)
;        (setq lsp-rust-rls-command '("rustup", "run", "nightly", "rls"))
;        (add-hook 'rustic-mode-hook 'lsp)
;)

(use-package haskell-mode :ensure t :pin melpa :defer t)

(use-package yaml-mode :ensure t :pin melpa
:commands yaml-mode
:mode (("\\.yaml\\'" . yaml-mode)
        ("\\.yml\\'"  . yaml-mode))
)

(use-package toml-mode :ensure t :pin melpa
:commands toml-mode
:mode (("\\.toml\\'" . toml-mode)
       ("Pipfile\\'" . toml-mode))
    )

(use-package cmake-mode :ensure t :pin melpa
;:ensure-system-package (cmake-language-server . "pip3 install cmake-language-server")
:commands cmake-mode
:mode (("\\.cmake\\'"    . cmake-mode)
       ("CMakeLists.txt" . cmake-mode))
:init (setq cmake-tab-width 4)
)

(use-package markdown-mode :ensure t :pin melpa
:commands (markdown-mode gfm-mode)
:mode   (("\\README.md\\'" . gfm-mode)
         ("\\.md\\'"       . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
:general (leader "hm" '(:wk "Markdown"))
:config (setq markdown-command "multimarkdown")
)

(use-package markdown-preview-mode :ensure t :pin melpa :defer t)
(use-package gh-md :ensure t :pin melpa :defer t
:general (leader "hmr" 'gh-md-render-buffer)
)

(use-package easy-jekyll :ensure t :pin melpa
:commands easy-jekyll
:config (setq easy-jekyll-basedir "~/dev/blog/")
        (setq easy-jekyll-url "https://injae.github.io")
        (setq easy-jekyll-sshdomain "blogdomain")
        (setq easy-jekyll-root "/")
        (setq easy-jekyll-previewtime "300")
)

(use-package python-mode
:mode   ("\\.py\\'" . python-mode)
        ("\\.wsgi$" . python-mode)
:interpreter ("python" . python-mode)
:ensure-system-package ((pyenv . "brew install pyenv")
                        (pipenv . "pip install pipenv"))
:custom (python-indent-offset 4)
)

(use-package pyvenv :ensure t :pin melpa
:after  python-mode
:hook   (python-mode . pyvenv-mode)
:config (pyvenv-tracking-mode)
)

(use-package pyenv-mode :ensure t :pin melpa
:after  python-mode
:hook  (python-mode . pyenv-mode)
:preface
    (defun projectile-pyenv-mode-set ()
        "Set pyenv version matching project name."
        (let ((project (projectile-project-name)))
            (if (member project (pyenv-mode-versions))
                (pyenv-mode-set project)
                (pyenv-mode-unset)
            )
        )
    )
:config (add-hook 'projectile-switch-project-hook 'projectile-pyenv-mode-set)
)
(use-package pyenv-mode-auto :ensure t :pin melpa :after pyenv-mode)

(use-package lsp-pyright :ensure t :pin melpa 
:hook (python-mode . (lambda () (require 'lsp-pyright) (lsp)))
)

(use-package pip-requirements :ensure t :pin melpa :after python-mode
:hook (python-mode . pip-requirements-mode)
)
(use-package pipenv :ensure t :pin melpa :after python-mode
    :hook (python-mode . pipenv-mode)
    :config (setq pipenv-projectile-after-switch-function #'pipenv-projectile-after-switch-extended)
    )

(use-package elpy :ensure t :pin melpa :disabled
:ensure-system-package (jedi . "pip install --user jedi flake8 autopep8 black yapf importmagic")
:after python-mode
:hook (python-mode . elpy-enable)
:config (eldoc-mode 0)
)

(use-package anaconda-mode :ensure t :pin melpa :disabled
:after  python-mode
:config (add-hook 'python-mode-hook 'anaconda-mode)
        (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

(use-package company-anaconda :ensure t :pin melpa :disabled
:after  (company-mode anaconda-mode))

;(use-package virtualenvwrapper
;:after  python-mode
;:custom (venv-project-home expand-file-name (or (getenv "PROJECT_HOME") "~/dev/") :group 'virtualenvwrapper)
;:preface (defun workon-venv ()
;             "change directory to project in eshell"
;             (eshell/cd (concat venv-project-home venv-current-name)))
;:config (venv-initialize-interactive-shells) ;; if you want interactive shell support
;        (venv-initialize-eshell) ;; if you want eshell support
;        (setq venv-location "~/dev/flask/.virtualenvs/")
;        (setq venv-project-home "~/dev/")
;        (add-hook 'venv-postactivate-hook (lambda () (workon-venv)))
;)

(use-package dart-mode :ensure t :pin melpa
:after lsp
:mode ("\\.dart\\'" . dart-mode)
:custom (dart-format-on-save t)
        (dart-enable-analysis-server t)
        (dart-sdk-path (expand-file-name "~/dev/flutter/bin/cache/dart-sdk/"))
:init (add-hook 'dart-mode-hook 'lsp)
)

(use-package flutter :ensure t :pin melpa
:after dart-mode
:general (:keymaps 'dart-mode-map "C-M-x" 'flutter-run-or-hot-reload)
:custom (flutter-sdk-path (expand-file-name "~/dev/flutter/"))
)

(use-package i3wm :ensure t :pin melpa :defer t :disabled)

(use-package company-shell :ensure t :pin melpa :defer t
:after (company eshell)
:init (add-to-list 'company-backends '(company-shell company-shell-env company-fish-shell))
)

(use-package go-mode :ensure t :pin melpa
:mode ("\\.go\\''" . go-mode)
)

(use-package dumb-jump :ensure t :pin melpa
:after  company
:custom (dumb-jump-selector 'ivy)
        (dumb-jump-force-searcher 'rg)
        (dumb-jump-default-project "~/build")
:general (leader "hd"  '(:wk "Definition Jump")
                 "hdo" 'dumb-jump-go-other-window
                 "hdj" 'dumb-jump-go
                 "hdi" 'dumb-jump-go-prompt
                 "hdx" 'dumb-jump-go-prefer-external
                 "hdz" 'dumb-jump-go-prefer-external-other-window)
)

(use-package web-mode :ensure t :pin melpa
:commands (web-mode)
:mode     (("\\.html?\\'"  . web-mode)
           ("\\.xhtml$\\'" . web-mode)
           ("\\.tsx$"      . web-mode)
           ("\\.vue\\'"    . web-mode))
:custom (web-mode-enable-engine-detection t)
        (web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
)

(use-package js2-mode :ensure t :pin melpa
:mode (("\\.js\\'" . js2-mode))
)

(use-package js2-refactor :ensure t :pin melpa :disabled
:after js2-mode
:hook (js2-mode . js2-refactor)
)

(use-package rjsx-mode :ensure t :pin melpa :disabled
:after js2-mode
:mode (("\\.jsx$" . rjsx-mode)
       ("components/.+\\.js$" . rjsx-mode))
:hook (js2-mode . rjsx-mode)
:preface
(defun +javascript-jsx-file-p ()
    "Detect React or preact imports early in the file."
    (and buffer-file-name
         (string= (file-name-extension buffer-file-name) "js")
         (re-search-forward "\\(^\\s-*import +React\\|\\( from \\|require(\\)[\"']p?react\\)"
                            magic-mode-regexp-match-limit t)
         (progn (goto-char (match-beginning 1))
                (not (sp-point-in-string-or-comment)))))
:init (add-to-list 'magic-mode-alist '(+javascript-jsx-file-p . rjsx-mode))
)

(use-package xref-js2 :ensure t :pin melpa
:after (js2-mode xref)
:config (add-hook 'js2-mode-hook (lambda () (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
)

(use-package skewer-mode :ensure t :pin melpa
:after js2-mode
:hook (js2-mode  . skewer-mode)
      (css-mode  . skewer-css-mode)
      (html-mode . skewer-html-mode)
)

(use-package typescript-mode :ensure t :pin melpa
:mode (("\\.ts\\'"  . typescript-mode)
       ("\\.tsx\\'" . typescript-mode))
)

(use-package tide :ensure t :pin melpa
:after (typescript-mode company flycheck)
:hook ((typescript-mode . tide-setup)
       (typescript-mode . tide-hl-identifier-mode)
       (before-save . tide-format-before-save))
)

(use-package json-mode :ensure t :pin melpa
:commands json-mode
:mode (("\\.json\\'"       . json-mode)
       ("/Pipfile.lock\\'" . json-mode))
)

(use-package json-reformat :ensure t :pin melpa
:commands json-reformat-region
)

(use-package restclient :ensure t :pin melpa
:preface 
(defun new-restclient-buffer ()
    "restclient buffer open"
    (interactive)
    (new-buffer "*RC Client*" #'restclient-mode)
    (restclient-response-mode))
:commands new-restclient-buffer
)

(use-package company-restclient :ensure t :pin melpa
:after  (company restclient)
:config (add-to-list 'company-backends 'company-restclient)
)

(use-package ruby-mode :ensure t :pin melpa
:mode "\\.rb\\'"
:mode "Rakefile\\'"
:mode "Gemfile\\'"
:mode "Berksfile\\'"
:mode "Vagrantfile\\'"
:interpreter "ruby"
:custom (ruby-indent-level 4)
        (ruby-indent-tabs-mode nil)
)

(use-package rvm :ensure t :pin melpa
:after ruby-mode
:ensure-system-package (rvm . "curl -sSL https://get.rvm.io | bash -s stable")
:config (rvm-use-default)
)

(use-package yari :ensure t :pin melpa :after ruby-mode)

(use-package rubocop :ensure t :pin melpa :disabled
:ensure-system-package (rubocop . "sudo gem install rubocop")
:after ruby-mode
:init (add-hook 'ruby-mode-hook 'rubocop-mode)
)

(use-package robe :ensure t :pin melpa
:after (ruby-mode company)
:ensure-system-package (pry . "sudo gem install pry pry-doc")
:init (add-hook 'ruby-mode-hook 'robe-mode)
:config (push 'company-robe company-backends)
)

(use-package ruby-tools :ensure t :pin melpa
:after ruby-mode
:init (add-hook 'ruby-mode-hook 'ruby-tools-mode)
)

(use-package gdscript-mode :ensure t :pin melpa
:custom (gdscript-godot-executable "/usr/local/Caskroom/godot/3.2.2/Godot.app/Contents/MacOS/Godot")
:hook (gdscript-mode . lsp)
)
;(use-package company-godot-gdscript :quelpa (company-godot-gdscript :fetcher github :repo "francogarcia/company-godot-gdscript.el") :disabled
;:after (gdscript-mode company)
;:config (add-to-list 'company-backends 'company-godot-gdscript)
;)

(use-package lsp-java :ensure t :pin melpa :config (add-hook 'java-mode-hook 'lsp))
(use-package dap-java :ensure nil)
(use-package gradle-mode :ensure t :pin melpa :config (add-hook 'java-mode-hook 'gradle-mode))
(use-package groovy-mode :ensure t :pin melpa 
:mode (".gradle\\'" . groovy-mode)
)

; brew install rust base system command
(use-package rust-system-command :no-require t
:if *is-mac*
:ensure-system-package (rg    . "brew install ripgrep")    
:ensure-system-package (exa   . "brew install exa")    
:ensure-system-package (bat   . "brew install bat")    
:ensure-system-package (fd    . "brew install fd")    
:ensure-system-package (procs . "brew install procs")    
:ensure-system-package (ytop  . "brew install ytop")    
)

; brew cask install karabiner-elements
(use-package karabiner :no-require t
:if *is-mac*
)

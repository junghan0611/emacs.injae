;;; eldoc-eval-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "eldoc-eval" "eldoc-eval.el" (23422 42167 838149
;;;;;;  900000))
;;; Generated autoloads from eldoc-eval.el

(defvar eldoc-in-minibuffer-mode nil "\
Non-nil if Eldoc-In-Minibuffer mode is enabled.
See the `eldoc-in-minibuffer-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `eldoc-in-minibuffer-mode'.")

(custom-autoload 'eldoc-in-minibuffer-mode "eldoc-eval" nil)

(autoload 'eldoc-in-minibuffer-mode "eldoc-eval" "\
Show eldoc for current minibuffer input.

\(fn &optional ARG)" t nil)

(autoload 'eldoc-eval-expression "eldoc-eval" "\
Eval expression with eldoc support in mode-line.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; eldoc-eval-autoloads.el ends here

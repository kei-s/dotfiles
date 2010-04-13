;; inhibit-startup-message
(setq inhibit-startup-message t)

;; set load-path
(setq load-path (cons "~/.emacs.d" load-path))

;; Enable font-lock-mode globally
(if (not (featurep 'xemacs))
    (global-font-lock-mode t))

;; Always display line and column number
(line-number-mode t)
(column-number-mode t)

;; Show parentheses
(show-paren-mode t)
(setq show-paren-style 'expression)

;; Show mark region
(transient-mark-mode t)

(set-language-environment "japanese")
;;(set-input-method "japanese-anthy")

;; Set default coding systems utf-8
(set-default-coding-systems 'utf-8)

;; backspace by C-h
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

;; rails-mode
(setq auto-mode-alist (cons '("\\.rhtml$" . ruby-mode) auto-mode-alist))
(setq load-path (cons "~/.emacs.d/emacs-rails" load-path))

(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

(setq hippie-expand-try-functions-list
      '(try-complete-abbrev
        try-complete-file-name
        try-expand-dabbrev))

(setq rails-use-mongrel t)
(require 'snippet)
(require 'rails)

;; subversion
(require 'psvn)

;; ruby-mode
(add-hook 'ruby-mode-hook
	  (lambda()
	    (add-hook 'local-write-file-hooks
		      '(lambda()
			 (save-excursion
			   (untabify (point-min) (point-max))
			   (delete-trailing-whitespace)
			   )))
	    (set (make-local-variable 'indent-tabs-mode) nil)
	    (set (make-local-variable 'tab-width) 2)
	    (imenu-add-to-menubar "IMENU")
	  ))

;; js2-mode
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist (cons "\\.\\(js\\|as\\|json\\|jsn\\|jsm\\)\\'" 'js2-mode))
(add-hook 'js2-mode-hook
	  (lambda()
	    (set (make-local-variable 'indent-tabs-mode) nil)
	    ))

;; actionscript-mode
(autoload 'actionscript-mode "actionscript-mode" "actionscript" t)
(add-to-list 'auto-mode-alist (cons "\\.\\(as\\)\\'" 'actionscript-mode))
(add-hook 'actionscript-mode-hook
	  (lambda()
	    (add-hook 'local-write-file-hooks
		      '(lambda()
			 (save-excursion
			   (untabify (point-min) (point-max))
			   (delete-trailing-whitespace)
			   )))
	    (set (make-local-variable 'indent-tabs-mode) nil)
	    (set (make-local-variable 'tab-width) 2)
	    (imenu-add-to-menubar "IMENU")
	  ))


;; sgml-mode
(add-hook 'sgml-mode-hook
	  (lambda()
	    (add-hook 'local-write-file-hooks
		      '(lambda()
			 (save-excursion
			   (untabify (point-min) (point-max))
			   (delete-trailing-whitespace)
			   )))
	    (set (make-local-variable 'indent-tabs-mode) nil)
	    (set (make-local-variable 'tab-width) 2)
	  ))

;; for Carbon Emacs
(if window-system (progn
		    (setq default-input-method "MacOSX")
		    ;; set alpha value
		    (set-frame-parameter nil 'alpha 85)
		    ;; color theme
		    (require 'color-theme)
		    (color-theme-initialize)
		    (color-theme-arjen)
		    ;; hide toolbar
		    (tool-bar-mode nil)
		    ;; full Screen
		    (defun my-mac-toggle-max-window ()
		      (interactive)
		      (if (frame-parameter nil 'fullscreen)
			  (set-frame-parameter nil 'fullscreen nil)
			(set-frame-parameter nil 'fullscreen 'fullboth)))
		    (global-set-key "\C-cm" 'my-mac-toggle-max-window)
		    ))

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

(defun reload-dotemacs()
  "Reload the .emacs file"
  (interactive)
  (load-file "~/.emacs"))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(js2-basic-offset 2)
 '(js2-cleanup-whitespace t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(js2-keyword-face ((t (:foreground "DodgerBlue")))))

(require 'outputz)
(setq outputz-key "xAuArU1SNvRH")      ;; 復活の呪文
(setq outputz-uri "http://macbook.kei-s.jp/emacs/%s") ;; 適当なURL。%sにmajor-modeの名前が入るので、major-modeごとのURLで投稿できます。
(global-outputz-mode t)

;; Tramp  Over SSH
(require 'tramp)


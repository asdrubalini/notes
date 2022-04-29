;; Emacs Straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Disable package.el in favor of straight.el
(setq package-enable-at-startup nil)

(straight-use-package 'use-package)

;; Don't make backups
(setq make-backup-files nil)

;; Publish planning information by default
(setq org-export-with-planning t)

;; Fontify source
(setq org-html-htmlize-output-type 'css)

(use-package evil
  :straight t
  :ensure t
  :config
  (evil-mode 1))

;; Org mode
(use-package org-contrib
  :straight t
  :ensure t)

;; This is required to highlight code blocks properly
(use-package htmlize
  :straight t
  :ensure t)

(use-package ox-publish
  :straight t
  :ensure t)

("org-notes"
  :base-directory "./"
  :base-extension "org"
  :publishing-directory "./publish"
  :recursive t
  :publishing-function org-html-publish-to-html
  :headline-levels 4
  :auto-preamble t
 )

("org" :components ("org-notes"))

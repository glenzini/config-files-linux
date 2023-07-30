;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(setq user-full-name "Gabriele Lenzini"
      user-mail-address "gabriele.lenzini@uni.lu")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
 (setq doom-theme 'doom-moonlight)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(setq org-directory "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! org
  (setq org-agenda-files
     (quote(
       "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org"
       "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//misc"
       "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//reviews"
       "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//projects"
       "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//uni"
       "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//people"
       "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//papers"
       "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//roam"
       ))))

;; don't load everything
(custom-set-variables
 '(org-agenda-custom-commands
   '(("c" "Custom agenda, include only urgent tag"
      ((agenda ""))
      ((org-agenda-tag-filter-preset '("urgent")))))))

;; -------------- refile setting
(setq org-refile-targets '((org-agenda-files :maxlevel . 6)))
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-use-outline-path 'file)
(setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-refile-use-cache t)

;; Save org buffers after refiling!
(advice-add 'org-refile :after 'org-save-all-org-buffers)

;; ---------------- org-roam

(after! org
      (setq org-roam-directory "~/IRiSC Dropbox/Gabriele Lenzini (gabriele.lenzini)/00-Admin/4-LogBook/org/roam/")
      (setq org-roam-db-autosync-mode t)
      (setq org-link-file-path-type 'adaptive)
)

;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)

;; #### spell checker
;; ispell
(setq ispell-program-name "aspell")

;; #### auto-save
;; auto save interval
(setq auto-save-interval 30)

;; ---------------------
;; Setting for org-mode
;; --------------------

;; Usee C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; --------------------------
;; Priority faces

(use-package org-fancy-priorities
  :after org
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '((?A . "HIGH")
                                    (?B . "MEDIUM")
                                    (?C . "LOW")))
  (setq org-priority-faces '((?A . (:foreground "firebrick" :weight 'bold))
                             (?B . (:foreground "dark orange"))
                             (?C . (:foreground "forest green")))))

;; --------------------------
;; TODO sequence

(after! org (setq org-todo-keywords
      (quote((sequence "TODO(t)"
                       "STARTED(s)"
                       "HOLD(h@/!)"
                       "|"
                       "DONE(d@)"
                       "CANCELLED(c@/!)"))))
)

;; TODO color
(after! org (setq org-todo-keyword-faces
      (quote(
        ("TODO" :foreground "firebrick" :weight bold)
        ("STARTED" :foreground "goldenrod" :weight bold)
        ("DONE" :foreground "forest green" :weight bold)
        ("HOLD" :foreground "dark orange" :weight bold)
        ("CANCELLED" :foreground "snow4" :weight bold))))
)

;; capture noted after Hold and Done
(after! org (setq org-log-done 'note))
(after! org (setq org-use-fast-todo-selection 'auto))

;; --------------------------
;; Capture log note

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(after! org (setq org-capture-templates
      '(("t" "Add Todo" entry (file
                 "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
             ("n" "Add Note" entry (file
                  "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//notes.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
             ("j" "Journal" entry (file+datetree
                  "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//journal.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
             ("m" "Meeting" entry (file
                  "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
            )))

;; #### tags
(after! org (setq org-tag-persistent-alist
                  (quote(
                      (:startgroup . nil)
                      ("@irisc" . ?i)
                      ("@snt" . ?s)
                      ("@project" . ?s)
                      (:endgroup . nil)
                      ("mail" . ?m)
                      ("writing" . ?w)
                      ("reading" . ?r)
                      ("organizing" . ?o)
                      ("urgent" . ?u)
                      ))))

(setq org-default-notes-file
      "~//IRiSC Dropbox//Gabriele Lenzini (gabriele.lenzini)//00-Admin//4-LogBook//org//refile.org")

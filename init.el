;; -*- coding: utf-8 -*-
;; M-x eval-buffer to set this configuration valid.

;; record start time for analyze performance
(setq emacs-load-start-time (current-time))

;; color and background
(set-background-color "white")
(set-foreground-color "black")
(set-face-foreground 'region "green")
(set-face-background 'region "blue")

;; start server mode
(server-start)

;; set plugin path then can require 'something
(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))
(require 'init-color-theme)


;; Which functionality to enable (use t or nil for true and false)
(setq *win32* (eq system-type 'windows-nt) )


;; remove the start page
;;(kill-buffer "*GNU emacs*")




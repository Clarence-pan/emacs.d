;; -*- coding: utf-8 -*-
(echo "Custom initializing...")

;; for more help info, use M-x describe-variable
  ;; 去掉开始页
(setq inhibit-startup-screen t)
;; tab的宽度
(setq tab-width 4)
(setq tab-stop-list '(0 4 8 12 16 20))
(setq w3m-command "w3m.cmd")
(setq browse-url-generic-program "chrome.cmd")

;; color and background
;; 定义颜色和背景
(set-background-color "white")
(set-foreground-color "black")
(set-face-foreground 'region "green")
(set-face-background 'region "blue")

;; start server mode
;; 设置为服务器模式 -- 能加快启动速度，客户端用emacsclient来打开
(server-start)

;; set plugin path then can require 'something
;; 设置插件目录
(add-to-list 'load-path (expand-file-name "~/.emacs.d/init"))
(require 'init-color-theme)

;; 设置org-mode时候全用缩进模式，更好看
;; org-mode startup indent-mode
(setq org-startup-indented t)

;; 操作系统探测
;; OS detection
(setq *win32* (eq system-type 'windows-nt) )

;; 图像模式
;; iimage mode
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)


;; remove the urgly toolbar
;; 去除工具栏
(tool-bar-mode -1)

;;系统剪贴板快捷键（C-c C-c复制，C-c C-v粘贴）
;;(global-set-key "\C-c\C-c" 'clipboard-kill-ring-save)
;;(global-set-key "\C-cc" 'clipboard-kill-ring-save)
;;(global-set-key "\C-c\C-v" 'clipboard-yank)
;;(global-set-key "\C-cv" 'clipboard-yank)

;;允许使用C-z作为命令前缀
;;(define-prefix-command 'ctl-z-map)
;;(global-set-key (kbd "C-z") 'ctl-z-map)

;;用C-z i快速打开~/.emacs文件。
(defun open-init-file ( )
  "Open the initial file of emacs"
  (interactive)
  (find-file "~/.emacs.d/init.el") )
;;(global-set-key (kbd "C-z i") 'open-init-file)
;;(global-set-key (kbd "C-z e") 'eval-buffer)

;;用C-z w快速打开工作目录
;;(defun open-work-dir ( )
;;  "Open working directory"
;;  (interactive)
;;  (find-file "d:/usr/work"))
;;(global-set-key (kbd "C-z w") 'open-work-dir)

;;用更好的ibuffer来管理buffer
;;(require 'ibuffer)
;;(global-set-key (kbd "C-x C-b") 'ibuffer)

;;默认进入text-mode，而不是没有什么功能的fundamental-mode
;;(setq default-major-mode 'text-mode)
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;默认显示行号
(global-linum-mode 1)

;;设置初始目录为rails项目目录
;;(setq default-directory "d:\\rails")

;;设定语言环境为utf-8
(setq current-language-environment "UTF-8")
;(setq default-input-method "chinese-py")
;(setq locale-coding-system 'utf-8)
;(set-terminal-coding-system 'utf-8)
;(set-keyboard-coding-system 'utf-8)
;(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;打开一个新的shell
(defun shell-new (name)
  "Open new shell with specific name."
  (interactive "sBuffer name: ")
  (shell name)
  )

;; C-z k 快速打开keys帮助文档
(defun open-key-info-file ()
  (interactive)
  (split-window-horizontally)
  (find-file-other-window "~/notes/emacs-keys.org")
  ;;(outline-mode)
  ;;(hide-body)
  )
;;(global-set-key (kbd "C-z k") 'open-key-info-file)

;; C-z v 切换到viper模式
;;(global-set-key (kbd "C-z v") 'toggle-viper-mode)

;;启动0.5秒后自动最大化 （windows下）
;;(run-with-idle-timer 0.1 nil 'w32-send-sys-command 61488)
(defun maximize-window ()
  "Make the window maximized"
  (interactive)
  (w32-send-sys-command 61488))
;;(global-set-key (kbd "C-z x") 'maximize-window)

;; 参考文档
;; http://kidneyball.iteye.com/blog/1014537

(global-set-key (kbd "S-SPC") 'ace-jump-char-mode)
(global-set-key (kbd "<f6>") 'ido-switch-buffer)
(global-set-key (kbd "<f9>") 'smex)

(defun shell-execute (command-args)
  "Run shell command"
  (interactive
   (progn
    (list (read-shell-command (concat default-directory "# ")))))
  (compilation-start command-args nil))

(global-set-key (kbd "<f5>") 'shell-execute)
(global-set-key (kbd "<C-f5>") 'git-commit)
(global-set-key (kbd "<C-S-f5>") 'git-commit-backup)

(defun git-commit-backup (command-args)
  "Run git commit from current directory"
  (interactive
   (progn
     (list (read-shell-command (concat default-directory "# ") "git commit . -m backup"))))
  (shell-execute command-args))

(defun git-commit (command-args)
  "Run git commit from current directory"
  (interactive
   (progn
     (list (read-shell-command (concat default-directory "# ") "git commit ."))))
  (shell-execute command-args))

;; xgrep
(setq xgrep-find-command "find . ( -path ./.svn -o -path ./.git -o -path ./.idea -o -path ./.project ) -prune -o -type f -name \\*.\\* -print0 | xargs -0 grep -nH --color=always -e ")
(defun xgrep (command-args)
  "Run grep with options -- instead of `grep-find'.
`cd' might be needed to change the default-directory before this command."
  (interactive
   (progn
     (list (read-shell-command
             (concat  "Run grep (" default-directory "): " ) xgrep-find-command))))
  (compilation-start command-args 'grep-mode))


;; 开始打开文件列表
;; open init.el on startup
;;(find-file "~/.emacs.d/init.el")
;; open TODO list on startup
(find-file "~/notes/TODO.org")
;;(setq browse-url-browser-function 'browse-url-default-browser)
(message "Custom initialized.")
(hl-line-mode t)
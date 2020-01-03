;;; init-local.el --- Load personnal config -*- lexical-binding: t -*-
;;; Commentary:


;;; Code:

(setq delete-auto-save-files t)         ; delete unnecessary autosave files
(setq delete-old-versions t)            ; delete oldversion file
(setq normal-erase-is-backspace-mode t) ; make delete work as it should
(fset 'yes-or-no-p 'y-or-n-p)           ; 'y or n' instead of 'yes or no'
(setq default-major-mode 'text-mode)    ; change default major mode to text
(setq ring-bell-function 'ignore)       ; turn the alarm totally off
(setq make-backup-files nil)            ; no backupfile

;; FIXME: wanted 99.9% of the time, but can cause your death 0.1% of
;; the time =). Todo: save buffer before reverting
                                        ;(global-auto-revert-mode t)            ; auto revert modified files

(auto-image-file-mode)                  ; to see picture in emacs
(dynamic-completion-mode)               ; dynamic completion
(show-paren-mode t)                     ; match parenthesis
(setq-default indent-tabs-mode nil)	; don't use fucking tabs to indent

(global-undo-tree-mode)
;; Color compilation terminal.
(require 'ansi-color)
;; Lol.
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;;
;; Language agnostic navigation bindings.
;;
(global-unset-key (kbd "C-z"))

;; Search.
(global-set-key [(control f)] 'isearch-forward-regexp)  ; search regexp
(global-set-key [(control r)] 'query-replace-regexp)    ; replace regexp
(define-key
  isearch-mode-map
  [(control n)]
  'isearch-repeat-forward)                              ; next occurence
(define-key
  isearch-mode-map
  [(control p)]
  'isearch-repeat-backward)                             ; previous occurence
(define-key
  isearch-mode-map
  [(control z)]
  'isearch-cancel)                                      ; quit and go back to start point
(define-key
  isearch-mode-map
  [(control f)]
  'isearch-exit)                                        ; abort
(define-key
  isearch-mode-map
  [(control r)]
  'isearch-query-replace)                               ; switch to replace mode
(define-key
  isearch-mode-map
  [S-insert]
  'isearch-yank-kill)                                   ; paste
(define-key
  isearch-mode-map
  [(control e)]
  'isearch-toggle-regexp)                               ; toggle regexp
(define-key
  isearch-mode-map
  [(control l)]
  'isearch-yank-line)                                   ; yank line from buffer
(define-key
  isearch-mode-map
  [(control w)]
  'isearch-yank-word)                                   ; yank word from buffer
(define-key
  isearch-mode-map
  [(control c)]
  'isearch-yank-char)                                   ; yank char from buffer

;; Undo / Redo.
(global-set-key [(control z)] 'undo-tree-undo)          ; tree undo
(global-set-key [(control Z)] 'undo-tree-redo)          ; tree redo

;; Window navigation.
(global-set-key [M-left] 'windmove-left)                ; move to left window
(global-set-key [M-right] 'windmove-right)              ; move to right window
(global-set-key [M-up] 'windmove-up)                    ; move to upper window
(global-set-key [M-down] 'windmove-down)
(global-set-key [(control tab)] 'other-window)          ; Ctrl-Tab = Next buffer
(global-set-key [C-S-iso-lefttab]
                '(lambda () (interactive)
                   (other-window -1)))                  ; Ctrl-Shift-Tab = Previous buffer

;; Buffer navigation.
(global-set-key [C-home] 'beginning-of-buffer)          ; go to the beginning of buffer
(global-set-key [C-end] 'end-of-buffer)                 ; go to the end of buffer
(global-set-key [(meta g)] 'goto-line)                  ; goto line #
(global-set-key [(control G)] 'rgrep)                   ; perform a rgrep.

(defun build ()
  "Build or rebuild."
  (interactive)
  (if (string-equal compile-command "")
      (compile ".")
    (recompile)))

;;
(global-set-key [(meta =)] 'stat-region)
(global-set-key [(control return)] 'dabbrev-expand)     ; auto completion
(global-set-key [(control c) (c)] 'build)
(global-set-key [(control c) (e)] 'next-error)

(global-set-key [(control delete)]
                'kill-word)                             ; kill word forward
(global-set-key [(meta ~)] 'python-command)             ; run python command
(global-set-key [(control c) (control c)]
                'comment-region)                        ; comment

;;
;; Look for a .compile.emacs file.
;;
;; (setq compile-command "")

(provide 'init-local)

;;; init-local.el ends here

;;; my-eshell.el --- Custom eshell helpers -*- lexical-binding: t; -*-

(defun my/eshell-here ()
  "Open a new eshell in the current buffer's directory."
  (interactive)
  (let ((default-directory
         (or (and (buffer-file-name)
                  (file-name-directory (buffer-file-name)))
             default-directory)))
    (eshell t)))

;; Keybinding personalizado (ajústalo si quieres)
(global-set-key (kbd "C-c h") #'my/eshell-here)

(provide 'my-eshell)
;;; my-eshell.el ends here

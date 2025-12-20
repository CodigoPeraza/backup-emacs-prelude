;;; cron.el --- Cron / crontab integration -*- lexical-binding: t; -*-

;; Asegura que crontab-mode esté disponible
(use-package crontab-mode
  :ensure t
  :mode
  (("\\`crontab\\'" . crontab-mode)
   ("\\.cron\\'"    . crontab-mode)))

;; Fallback defensivo: nunca fallar al abrir crontab
(with-eval-after-load 'files
  (add-to-list 'safe-local-variable-values
               '(mode . crontab)))

(provide 'cron)
;;; cron.el ends here

;;; my-dired.el --- Custom Dired behavior -*- lexical-binding: t; -*-

;; Permitir reutilizar el mismo buffer Dired al cambiar de directorio con `a`
(put 'dired-find-alternate-file 'disabled nil)

;;; my-dired.el ends here

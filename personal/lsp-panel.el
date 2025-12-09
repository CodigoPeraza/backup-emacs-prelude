;; ================================
;; PANEL LSP LATERAL (IMENU-LIST)
;; ================================
(use-package imenu-list
  :ensure t
  :bind (("C-c l" . imenu-list-smart-toggle))
  :config
  (setq imenu-list-focus-after-activation t)
  (setq imenu-list-auto-resize t)
  (setq imenu-list-position 'right))

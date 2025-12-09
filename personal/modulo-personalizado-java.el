;; ~/.emacs.d/personal/prelude-java-config.el

;; Este hook asegura que lsp-mode se active de forma asíncrona (deferred)
;; inmediatamente después de que java-mode se haya cargado.
(add-hook 'java-mode-hook #'lsp-deferred)

;; ... Aquí irían otros ajustes de Java si los necesitas ...

(provide 'prelude-java-config)

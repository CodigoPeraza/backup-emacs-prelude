;;; gptel-copilot.el --- IA tipo Copilot para Emacs -*- lexical-binding: t; -*-
(require 'gptel)

;; -------------------- UTILIDAD: NOMBRE DEL LENGUAJE --------------------

(defun my/gptel-get-mode-name ()
  "Obtiene nombre correcto del lenguaje basado en major-mode."
  (pcase major-mode
    ('java-mode "Java")
    ('python-mode "Python")
    ('rust-mode "Rust")
    ('js-mode "JavaScript")
    ('typescript-mode "TypeScript")
    ('c-mode "C")
    ('c++-mode "C++")
    ('emacs-lisp-mode "Emacs Lisp")
    ('csharp-mode "C#")
    (_ (capitalize
        (replace-regexp-in-string
         "-mode$" ""
         (symbol-name major-mode))))))

;; ======================= GENERADOR (C-c w) =======================

(defun my/gptel-smart-send ()
  "Modo Copilot estricto: selecciona comentario → genera código → lo inserta debajo."
  (interactive)
  (unless (use-region-p)
    (user-error "Debes seleccionar la instrucción o comentario primero."))

  (let* ((lang (my/gptel-get-mode-name))
         (beg (region-beginning))
         (end (region-end))
         (insertion-point (copy-marker end))
         (instruction (buffer-substring-no-properties beg end)))

    (when (> (length instruction) 2000)
      (user-error "Región demasiado grande para modo Copilot (máx 2000 chars)"))

    (message "🧠 Pensando...")

    (let ((final-prompt
           (format
            "CONTEXTO: Lenguaje %s.
ROL: Generador de código estricto (Silent Mode).
REGLAS:
1. Solo devuelve código ejecutable.
2. NUNCA uses bloques de markdown (```).
3. Sin explicaciones, sin 'Aquí tienes', sin saludos.
4. Usa español para nombres de variables y comentarios si es necesario.
5. NUNCA generes clases ni métodos main a menos que se pidan explícitamente.
INSTRUCCIÓN:
%s"
            lang instruction)))

      (deactivate-mark)

      ;; Forzamos Qwen solo para este envío
      (let ((gptel-model "qwen2.5-coder"))
        (gptel-request
         final-prompt
         :callback
         (lambda (response _info)
           (cond
            ((not response)
             (message "❌ Error: No hubo respuesta de la IA."))
            (t
             (let ((clean (string-trim response)))
               (if (string-empty-p clean)
                   (message "⚠️ La IA devolvió una respuesta vacía.")
                 (save-excursion
                   (goto-char insertion-point)
                   (insert "\n\n" clean)
                   (indent-region insertion-point (point))
                   (message "✅ Código generado.")))))
            )
           (set-marker insertion-point nil)))))))

;; ======================= REFACTOR (C-c y) =======================

(defun my/gptel-smart-refactor ()
  "Refactoriza el bloque seleccionado usando IA y lo reemplaza."
  (interactive)
  (unless (use-region-p)
    (user-error "Debes seleccionar el código a refactorizar primero."))

  (let* ((lang (my/gptel-get-mode-name))
         (beg (region-beginning))
         (end (region-end))
         (code (buffer-substring-no-properties beg end))
         (instruction (read-string "¿Qué transformación deseas aplicar?: ")))

    (when (> (length code) 4000)
      (user-error "Bloque demasiado grande para refactor con IA (máx 4000 chars)"))

    (message "🛠️ Refactorizando con IA...")

    (let ((final-prompt
           (format
            "CONTEXTO: Lenguaje %s.

ROL: Refactorizador de código estricto (Silent Mode).

REGLAS:
1. Devuelve SOLO el código refactorizado.
2. NO uses markdown ni comillas invertidas.
3. NO expliques nada.
4. Mantén el mismo comportamiento del código original.
5. Usa español para nombres de variables y comentarios si aplica.
6. NO generes clases ni métodos main a menos que se pidan explícitamente.

TRANSFORMACIÓN SOLICITADA:
%s

CÓDIGO ORIGINAL:
%s"
            lang instruction code)))

      (deactivate-mark)

      ;; Forzamos uso de Qwen solo aquí
      (let ((gptel-model "qwen2.5-coder"))
        (gptel-request
         final-prompt
         :callback
         (lambda (response _info)
           (cond
            ((not response)
             (message "❌ Error: No hubo respuesta de la IA."))
            (t
             (let ((clean (string-trim response)))
               (if (string-empty-p clean)
                   (message "⚠️ La IA devolvió una respuesta vacía.")
                 (save-excursion
                   (goto-char beg)
                   (delete-region beg end)
                   (insert clean)
                   (indent-region beg (point))
                   (message "✅ Refactor completado."))))))))))))

;; ======================= ATAJOS =======================

(global-set-key (kbd "C-c w") #'my/gptel-smart-send)
(global-set-key (kbd "C-c y") #'my/gptel-smart-refactor)

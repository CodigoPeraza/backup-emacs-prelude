(message ">>> Cargando ai.el <<<")
(setq gptel-backend
      (gptel-make-ollama "Ollama"
                         :host "localhost:11434"
                         :models '("llama3" "qwen2.5-coder")))

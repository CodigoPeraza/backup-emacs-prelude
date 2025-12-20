;;; terminal.el --- Sysadmin helpers -*- lexical-binding: t; -*-
(defun open-host-terminal ()
  "Abrir la terminal nativa del SO host en el directorio actual."
  (interactive)
  (let ((dir (expand-file-name default-directory)))
    (cond
     ;; GNU/Linux
     ((eq system-type 'gnu/linux)
      (let ((terminal
             (seq-find #'executable-find
                       '("x-terminal-emulator"
                         "gnome-terminal"
                         "konsole"
                         "xfce4-terminal"
                         "alacritty"
                         "kitty"
                         "foot"
                         "wezterm"
                         "xterm"))))
        (if terminal
            (start-process "host-terminal" nil terminal
                           ;; flags comunes para directorio
                           (cond
                            ((string-match-p "gnome-terminal" terminal) "--working-directory")
                            ((string-match-p "konsole" terminal) "--workdir")
                            ((string-match-p "xfce4-terminal" terminal) "--working-directory")
                            ((string-match-p "wezterm" terminal) "start" "--cwd")
                            ((string-match-p "alacritty" terminal) "--working-directory")
                            ((string-match-p "kitty" terminal) "--directory")
                            ((string-match-p "foot" terminal) "--working-directory")
                            (t "-e"))
                           dir)
          (error "No se encontró una terminal gráfica instalada"))))

     ;; macOS
     ((eq system-type 'darwin)
      (start-process "host-terminal" nil
                     "open" "-a" "Terminal" dir))

     ;; Windows
     ((eq system-type 'windows-nt)
      (start-process "host-terminal" nil
                     "wt.exe" "-d" dir))

     (t
      (error "Sistema operativo no soportado")))))

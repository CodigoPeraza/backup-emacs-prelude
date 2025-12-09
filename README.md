# Mi Configuración Personalizada de Emacs Prelude

Estas son mis configuraciones personalizadas basadas en [Emacs Prelude](https://github.com/bbatsov/prelude) de Bozhidar Batsov.

## 📋 Tabla de Contenidos

- [Descripción General](#-descripción-general)
- [Módulos Habilitados](#-módulos-habilitados)
- [Configuraciones Personalizadas](#-configuraciones-personalizadas)
- [Atajos de Teclado](#-atajos-de-teclado)
- [Instalación](#-instalación)
- [Restauración](#-restauración)
- [Requisitos](#-requisitos)

---

## 🎯 Descripción General

Esta configuración incluye mejoras enfocadas en desarrollo con IA (GPTel + Ollama), LSP mejorado, soporte para múltiples lenguajes de programación y productividad con org-mode.

### Características Principales

- **IA local simunlando a Copilot integrado**: Generación y refactorización de código con Ollama
- **LSP mejorado**: Panel lateral con navegación de símbolos
- **Múltiples lenguajes**: Java, Python, JavaScript, C, Shell, y más
- **Productividad**: Vertico, Company, Org-mode

---

## 📦 Módulos Habilitados

### Herramientas de Productividad
- ✅ `prelude-vertico` - Sistema moderno de completado
- ✅ `prelude-company` - Autocompletado inteligente
- ✅ `prelude-key-chord` - Combinaciones de teclas útiles
- ✅ `prelude-org` - Gestión de tareas y notas

### Soporte de Lenguajes
- ✅ `prelude-c` - Desarrollo en C
- ✅ `prelude-css` - CSS
- ✅ `prelude-emacs-lisp` - Elisp
- ✅ `prelude-js` - JavaScript
- ✅ `prelude-lisp` - Lenguajes tipo Lisp
- ✅ `prelude-lsp` - Language Server Protocol
- ✅ `prelude-perl` - Perl
- ✅ `prelude-python` - Python
- ✅ `prelude-shell` - Scripts de shell
- ✅ `prelude-web` - Desarrollo web
- ✅ `prelude-xml` - XML
- ✅ `prelude-yaml` - YAML

### Otros
- ✅ `prelude-erc` - Cliente IRC

---

## ⚙️ Configuraciones Personalizadas

### 1. **GPTel + Ollama** (`ollama.el`)

Integración con modelos de IA locales usando Ollama.

```elisp
(setq gptel-backend
      (gptel-make-ollama "Ollama"
                         :host "localhost:11434"
                         :models '("llama3" "qwen2.5-coder")))
```

**Modelos disponibles:**
- `llama3` - Modelo general
- `qwen2.5-coder` - Especializado en código

---

### 2. **GPTel Copilot** (`gptel-copilot.el`)

Sistema tipo GitHub Copilot para generar y refactorizar código.

#### Características:
- ✅ Generación de código desde comentarios
- ✅ Refactorización inteligente con IA
- ✅ Sin bloques markdown en las respuestas
- ✅ Soporte multilenguaje automático
- ✅ Nombres en español para variables

#### Lenguajes Soportados:
Java, Python, Rust, JavaScript, TypeScript, C, C++, Emacs Lisp, C#

---

### 3. **Panel LSP Lateral** (`lsp-panel.el`)

Panel de navegación lateral con estructura del código usando `imenu-list`.

```elisp
(setq imenu-list-focus-after-activation t)
(setq imenu-list-auto-resize t)
(setq imenu-list-position 'right)
```

---

### 4. **Configuración Java** (`modulo-personalizado-java.el`)

Activación automática de LSP para proyectos Java.

```elisp
(add-hook 'java-mode-hook #'lsp-deferred)
```

---

### 5. **Tema Visual** (`custom.el`)

- Fondo transparente habilitado
- Paquete `sublime-themes` instalado

---

## ⌨️ Atajos de Teclado

### IA / GPTel

| Atajo | Función | Descripción |
|-------|---------|-------------|
| `C-c q` | `gptel` | Abrir chat con IA |
| `C-c w` | `my/gptel-smart-send` | **Generar código**: Selecciona un comentario → genera código debajo |
| `C-c y` | `my/gptel-smart-refactor` | **Refactorizar**: Selecciona código → describe cambio → reemplaza |

### LSP / Navegación

| Atajo | Función | Descripción |
|-------|---------|-------------|
| `C-c l` | `imenu-list-smart-toggle` | Toggle panel lateral de símbolos |

### Workflow de Uso - IA Copilot

#### 🔹 Generar código (`C-c w`)

1. Escribe un comentario con lo que necesitas:
   ```java
   // metodo que suma dos numeros
   ```

2. Selecciona el comentario completo

3. Presiona `C-c w`

4. El código se genera automáticamente debajo:
   ```java
   // metodo que suma dos numeros
   public int sumar(int a, int b) {
       return a + b;
   }
   ```

#### 🔹 Refactorizar código (`C-c y`)

1. Selecciona el bloque de código

2. Presiona `C-c y`

3. Escribe la transformación deseada:
   - "añade validación de null"
   - "convierte a programación funcional"
   - "optimiza el rendimiento"
   - "agrega manejo de errores"

4. El código se reemplaza automáticamente

---

## 🚀 Instalación

### Paso 1: Instalar Emacs Prelude

```bash
# Backup de configuración actual (si existe)
mv ~/.emacs.d ~/.emacs.d.backup
mv ~/.emacs ~/.emacs.backup

# Clonar Prelude
git clone https://github.com/bbatsov/prelude.git ~/.emacs.d

# Primera ejecución (instalará paquetes base)
emacs
```

### Paso 2: Clonar Este Repositorio

```bash
cd ~/.emacs.d
git clone https://github.com/TU_USUARIO/TU_REPO.git personal-temp
mv personal-temp/* personal/
rm -rf personal-temp
```

### Paso 3: Instalar Ollama (Opcional, para IA)

```bash
# En Linux
curl -fsSL https://ollama.com/install.sh | sh

# Descargar modelos
ollama pull llama3
ollama pull qwen2.5-coder

# Iniciar servicio
ollama serve
```

### Paso 4: Reiniciar Emacs

```bash
emacs
```

Los paquetes adicionales (`gptel`, `imenu-list`, etc.) se instalarán automáticamente.

---

## 🔄 Restauración

### Restaurar desde cero:

```bash
# 1. Eliminar configuración actual
rm -rf ~/.emacs.d

# 2. Reinstalar Prelude
git clone https://github.com/bbatsov/prelude.git ~/.emacs.d

# 3. Clonar tus configuraciones personales
cd ~/.emacs.d
git clone https://github.com/TU_USUARIO/TU_REPO.git personal-temp
mv personal-temp/* personal/
rm -rf personal-temp

# 4. Iniciar Emacs
emacs
```

### Estructura de archivos resultante:

```
~/.emacs.d/
├── personal/
│   ├── custom.el                          # Tema y personalizaciones visuales
│   ├── gptel-conf.el                      # Configuración base GPTel
│   ├── gptel-copilot.el                   # IA Copilot (C-c w, C-c y)
│   ├── lsp-panel.el                       # Panel lateral LSP (C-c l)
│   ├── modulo-personalizado-java.el       # LSP para Java
│   ├── ollama.el                          # Integración con Ollama
│   ├── prelude-modules.el                 # Módulos habilitados
│   └── .dir-locals.el                     # Configuración local de directorio
└── [resto de archivos de Prelude]
```

---

## 📋 Requisitos

### Obligatorios
- Emacs 29.1+ (recomendado)
- Git

### Adicionales (para funcionalidades completas)
- **Ollama** - Para usar IA local (`C-c q`, `C-c w`, `C-c y`)
- **Java JDK 11+** y **jdtls** - Para LSP de Java
- **Python 3.8+** y **pyright** - Para LSP de Python
- **Node.js** y **typescript-language-server** - Para JavaScript/TypeScript

### Instalar Language Servers:

```bash
# Java
# Descargar jdtls desde: https://download.eclipse.org/jdtls/snapshots/
# Extraer en ~/.emacs.d/eclipse.jdt.ls/

# Python
pip install pyright

# JavaScript/TypeScript
npm install -g typescript-language-server typescript
```

---

## 📝 Notas Adicionales

### Desactivar funciones de IA:

Si no quieres usar Ollama, simplemente comenta o elimina:
- `personal/ollama.el`
- `personal/gptel-conf.el`
- `personal/gptel-copilot.el`

### Cambiar tema:

Edita `personal/custom.el`:

```elisp
;; Descomentar y elegir variante de Gruvbox
(load-theme 'gruvbox-dark-medium t)

;; O usar sublime-themes (actual)
(prelude-require-package 'sublime-themes)
(load-theme 'spolsky t)  ; u otro tema de sublime
```

### Añadir más lenguajes:

Edita `personal/prelude-modules.el` y descomenta los módulos que necesites:

```elisp
(require 'prelude-go)      ;; Para Go
(require 'prelude-rust)    ;; Para Rust
(require 'prelude-ruby)    ;; Para Ruby
```

---

## 🤝 Contribuciones

Este es mi setup personal, pero si encuentras mejoras o tienes sugerencias, ¡son bienvenidas!

---

## 📄 Licencia

Estas configuraciones son de código abierto. Emacs Prelude está bajo GPL v3.

---

## 🔗 Enlaces Útiles

- [Emacs Prelude Original](https://github.com/bbatsov/prelude)
- [Documentación GPTel](https://github.com/karthink/gptel)
- [Ollama](https://ollama.com/)
- [LSP Mode](https://emacs-lsp.github.io/lsp-mode/)

---

**Última actualización:** Diciembre 2024

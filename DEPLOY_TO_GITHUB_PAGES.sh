#!/bin/bash
# 📋 EJECUTA ESTO EN TU TERMINAL - Paso a Paso para GitHub Pages Deploy

echo "════════════════════════════════════════════════════════════════"
echo "🚀 SINCRONIZACIÓN: github-pages-static → main → GitHub Pages"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Ir a la carpeta del proyecto
cd /workspaces/AppSecure

# ============================================
# PASO 1: Verificar estado actual
# ============================================
echo "📋 PASO 1: Verificar estado actual del repositorio"
echo "─────────────────────────────────────────────────"
echo ""

echo "Rama actual:"
git branch --show-current

echo ""
echo "Estado de cambios:"
git status -s

echo ""
echo "Última revisión:"
git log --oneline -1

echo ""

# ============================================
# PASO 2: Hacer fetch de origin
# ============================================
echo "📡 PASO 2: Descargar cambios de GitHub"
echo "─────────────────────────────────────────────────"
echo ""

git fetch origin
echo "✅ Cambios descargados de GitHub"

echo ""

# ============================================
# PASO 3: Cambiar a rama main
# ============================================
echo "🔄 PASO 3: Cambiar a rama main"
echo "─────────────────────────────────────────────────"
echo ""

# Si hay cambios sin guardar, hacer stash
if ! git diff-index --quiet HEAD --; then
    echo "⚠️  Cambios sin guardar detectados. Guardando temporalmente..."
    git stash
    STASHED=true
else
    STASHED=false
fi

# Cambiar a main
git checkout main

if [ "$STASHED" = true ]; then
    echo "Restaurando cambios guardados..."
    git stash pop || echo "⚠️  No se pudieron restaurar todos los cambios"
fi

echo "✅ Ahora estás en rama: $(git branch --show-current)"

echo ""

# ============================================
# PASO 4: Actualizar main desde origin
# ============================================
echo "📥 PASO 4: Actualizar rama main desde GitHub"
echo "─────────────────────────────────────────────────"
echo ""

git pull origin main

echo "✅ Rama main actualizada"

echo ""

# ============================================
# PASO 5: Mergear github-pages-static
# ============================================
echo "🔀 PASO 5: Fusionar cambios de github-pages-static"
echo "─────────────────────────────────────────────────"
echo ""

# Intentar merge
if git merge github-pages-static --no-ff -m "Merge: Sync static SPA to main for GitHub Pages"; then
    echo ""
    echo "✅ Fusión completada sin conflictos"
else
    echo ""
    echo "⚠️  ¡CONFLICTO DE MERGE DETECTADO!"
    echo ""
    echo "Archivos en conflicto:"
    git diff --name-only --diff-filter=U
    echo ""
    echo "ACCIONES NECESARIAS:"
    echo "1. Abre cada archivo en conflicto"
    echo "2. Busca: <<<<<<< HEAD"
    echo "3. Resuelve manualmente"
    echo "4. Guarda los archivos"
    echo ""
    echo "Luego ejecuta:"
    echo "  git add ."
    echo "  git commit -m 'Merge: resolve conflicts'"
    echo ""
    exit 1
fi

echo ""

# ============================================
# PASO 6: Hacer push a GitHub
# ============================================
echo "🚀 PASO 6: Enviar cambios a GitHub (ESTE ES EL MOMENTO CRÍTICO)"
echo "─────────────────────────────────────────────────"
echo ""

echo "Cambios que se van a enviar:"
git log origin/main..HEAD --oneline

echo ""
echo "⚠️  Presiona ENTER para hacer push a GitHub..."
read

git push origin main

echo ""
echo "✅ Push completado"

echo ""

# ============================================
# INFORMACIÓN FINAL
# ============================================
echo "════════════════════════════════════════════════════════════════"
echo "✨ ¡SINCRONIZACIÓN COMPLETADA CON ÉXITO!"
echo "════════════════════════════════════════════════════════════════"
echo ""

echo "📊 Estado final:"
git log --oneline -3

echo ""
echo "🌐 Tu app estará disponible en:"
echo "   https://albertoaa78-gif.github.io/AppSecure/#/"
echo ""

echo "⏱️  IMPORTANTE: Espera 2-4 minutos para que GitHub Pages compile"
echo ""

echo "✅ Verificación:"
echo "   [ ] 1. Espera 2-4 minutos después de este mensaje"
echo "   [ ] 2. Abre: https://albertoaa78-gif.github.io/AppSecure/#/"
echo "   [ ] 3. Haz hard refresh: Ctrl+Shift+R (Windows/Linux) o Cmd+Shift+R (Mac)"
echo "   [ ] 4. Verifica que cargue sin errores"
echo "   [ ] 5. Prueba las rutas:"
echo "       - https://albertoaa78-gif.github.io/AppSecure/#/"
echo "       - https://albertoaa78-gif.github.io/AppSecure/#/services"
echo "       - https://albertoaa78-gif.github.io/AppSecure/#/technology"
echo "       - https://albertoaa78-gif.github.io/AppSecure/#/contact"
echo ""

echo "🔗 Revisar logs de GitHub Actions:"
echo "   https://github.com/albertoaa78-gif/AppSecure/actions"
echo ""

echo "📱 Si hay problemas, abre DevTools (F12) y revisa:"
echo "   - Pestaña 'Console' para errores de JavaScript"
echo "   - Pestaña 'Network' para errores 404 en assets"
echo ""

echo "════════════════════════════════════════════════════════════════"

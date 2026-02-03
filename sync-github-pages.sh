#!/bin/bash
# Script automático para sincronizar github-pages-static a main y hacer push a GitHub Pages

set -e  # Exit on any error

echo "=========================================="
echo "🚀 SINCRONIZANDO CON GITHUB PAGES"
echo "=========================================="
echo ""

cd /workspaces/AppSecure

# Paso 1: Verificar estado
echo "📋 PASO 1: Verificar estado actual..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
git status
echo ""

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "✅ Rama actual: $CURRENT_BRANCH"
echo ""

# Paso 2: Fetch desde origin
echo "📡 PASO 2: Traer cambios de origin..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
git fetch origin
echo "✅ Fetch completado"
echo ""

# Paso 3: Si estamos en github-pages-static, cambiar a main
if [ "$CURRENT_BRANCH" = "github-pages-static" ]; then
    echo "🔄 PASO 3: Cambiar de github-pages-static a main..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Hacer stash de cambios si los hay
    if ! git diff-index --quiet HEAD --; then
        echo "⚠️  Cambios no guardados - haciendo stash..."
        git stash
    fi
    
    git checkout main
    echo "✅ Cambiado a main"
    
    # Si hicimos stash, lo recuperamos
    if git stash list | grep -q .; then
        git stash pop || echo "⚠️  No se pudieron restaurar cambios del stash"
    fi
    echo ""
else
    echo "✅ PASO 3: Ya estamos en $CURRENT_BRANCH"
    echo ""
fi

# Paso 4: Pull origin/main para estar al día
echo "📥 PASO 4: Actualizar main desde origin..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
git pull origin main --no-ff -m "Update: sync with origin/main"
echo "✅ Pull completado"
echo ""

# Paso 5: Mergear github-pages-static
echo "🔀 PASO 5: Mergear github-pages-static en main..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Intentar merge sin fast-forward
if git merge github-pages-static --no-ff -m "Merge: Sync static SPA to main for GitHub Pages" 2>/dev/null; then
    echo "✅ Merge completado sin conflictos"
else
    echo "⚠️  Merge detectó conflictos"
    echo ""
    echo "Archivos en conflicto:"
    git status | grep "both modified"
    echo ""
    echo "Por favor resuelve los conflictos manualmente:"
    echo "1. Abre los archivos con markers <<<<<<<, =======, >>>>>>>"
    echo "2. Guarda los cambios"
    echo "3. git add ."
    echo "4. git commit -m 'Merge: resolve conflicts'"
    echo ""
    exit 1
fi
echo ""

# Paso 6: Hacer push a origin/main
echo "🚀 PASO 6: Hacer push a origin/main..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
git push origin main
echo "✅ Push completado"
echo ""

# Paso 7: Información final
echo "=========================================="
echo "✨ ¡SINCRONIZACIÓN COMPLETADA!"
echo "=========================================="
echo ""
echo "📊 Estado actual:"
git log --oneline -3
echo ""
echo "🌐 Tu app estará disponible en:"
echo "   https://albertoaa78-gif.github.io/AppSecure/#/"
echo ""
echo "⏱️  GitHub Pages compilará en 2-3 minutos"
echo ""
echo "✅ Próximos pasos:"
echo "   1. Espera 2-3 minutos"
echo "   2. Abre el link en tu navegador"
echo "   3. Haz hard refresh: Ctrl+Shift+R (o Cmd+Shift+R en Mac)"
echo ""
echo "🔗 Verificar Actions en GitHub:"
echo "   https://github.com/albertoaa78-gif/AppSecure/actions"
echo ""

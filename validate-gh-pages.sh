#!/bin/bash
# Script para validar que todo está correcto antes de hacer push

set -e

echo "🔍 Validando estructura del proyecto..."

# Verificar rama
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "github-pages-static" ]; then
    echo "⚠️  ADVERTENCIA: No estás en la rama github-pages-static"
    echo "Rama actual: $CURRENT_BRANCH"
    echo "Cambia con: git checkout github-pages-static"
    exit 1
fi

echo "✅ Rama correcta: $CURRENT_BRANCH"

# Verificar que existen archivos críticos
echo ""
echo "📁 Verificando archivos críticos..."

FILES_TO_CHECK=(
    "package.json"
    "vite.config.ts"
    "tsconfig.json"
    "client/index.html"
    "client/src/main.tsx"
    "client/src/App.tsx"
    "client/src/pages/Home.tsx"
    "client/src/pages/Services.tsx"
    "client/src/pages/Technology.tsx"
    "client/src/pages/Contact.tsx"
    "client/src/hooks/use-services.ts"
    "client/src/hooks/use-inquiries.ts"
)

for file in "${FILES_TO_CHECK[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file (FALTA)"
        exit 1
    fi
done

echo ""
echo "📦 Verificando dependencias en package.json..."

# Verificar que NO hay dependencias de servidor
if grep -q '"express"' package.json; then
    echo "  ⚠️  ADVERTENCIA: express está en dependencias (debe removerse)"
fi

if grep -q '"pg"' package.json; then
    echo "  ⚠️  ADVERTENCIA: pg está en dependencias (debe removerse)"
fi

if grep -q '"drizzle-orm"' package.json; then
    echo "  ⚠️  ADVERTENCIA: drizzle-orm está en dependencias (puede removerse)"
fi

echo ""
echo "✅ Todas las verificaciones pasaron!"
echo ""
echo "Próximos pasos:"
echo "1. npm install --legacy-peer-deps"
echo "2. bash build-gh-pages.sh"
echo "3. git add -A && git commit -m 'Build para GitHub Pages'"
echo "4. git push origin github-pages-static"
echo "5. Configurar Settings > Pages > Branch: github-pages-static, Folder: /docs"

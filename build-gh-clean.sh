#!/bin/bash
# Clean build para GitHub Pages - Solo cliente

set -e

echo "🔨 Building AppSecure para GitHub Pages..."
echo ""

cd /workspaces/AppSecure

# 1. Limpiar
echo "🗑️  Limpiando..."
rm -rf dist docs node_modules/.vite 2>/dev/null || true

# 2. Build con Vite directamente (sin build.ts que compila server)
echo "📦 Compilando con Vite..."
VITE_BASE=/AppSecure/ npx vite build --mode production

# 3. Copiar a docs/
echo "📂 Copiando a docs/..."
rm -rf docs 2>/dev/null || true
mkdir -p docs
cp -r dist/public/* docs/

# 4. Crear .nojekyll
echo "📋 Creando archivos de GitHub Pages..."
touch docs/.nojekyll

# 5. Resumen
echo ""
echo "✅ Build completado!"
echo ""
echo "📊 Contenido de docs/:"
ls -lh docs/ | grep -v "^total" | awk '{print "  " $9 " (" $5 ")"}'
echo ""
echo "📦 Assets:"
ls -lh docs/assets/ 2>/dev/null | grep -v "^total" | awk '{print "  " $9 " (" $5 ")"}'
echo ""
echo "✨ Verificación:"
[ -f docs/.nojekyll ] && echo "  ✅ .nojekyll" || echo "  ❌ .nojekyll FALTA"
[ -f docs/404.html ] && echo "  ✅ 404.html" || echo "  ❌ 404.html FALTA"
[ -f docs/index.html ] && echo "  ✅ index.html" || echo "  ❌ index.html FALTA"
[ -f docs/favicon.svg ] && echo "  ✅ favicon.svg" || echo "  ❌ favicon.svg FALTA"
[ ! -f docs/favicon.png ] && echo "  ✅ favicon.png eliminado" || echo "  ⚠️  favicon.png aún existe"

echo ""
echo "🚀 Listo para GitHub Pages:"
echo "   https://albertoaa78-gif.github.io/AppSecure/#/"
echo ""
echo "📝 Próximo paso:"
echo "   git add docs/"
echo "   git commit -m 'build: regenerate for github pages'"
echo "   git push origin main"

#!/bin/bash
set -e

echo "=== LIMPIEZA PROFUNDA ==="
echo "1. Removiendo carpetas de build..."
rm -rf dist docs node_modules/.vite

echo "2. Limpiando docs/ completamente..."
rm -rf docs
mkdir -p docs

echo ""
echo "=== BUILD PARA GITHUB PAGES ==="
echo "1. Ejecutando vite build..."
VITE_BASE=/AppSecure/ npx vite build

echo ""
echo "2. Copiando dist/public a docs/"
cp -r dist/public/* docs/

echo ""
echo "3. Creando archivos de configuración..."
# Asegurar que .nojekyll existe
touch docs/.nojekyll
echo "✓ .nojekyll creado"

# Crear _redirects para Netlify (por si acaso)
cat > docs/_redirects << 'EOF'
/*  /AppSecure/index.html  200
EOF
echo "✓ _redirects creado"

echo ""
echo "=== VERIFICACIÓN ==="
echo "Archivos en docs/:"
ls -lh docs/ | grep -v "^total"

echo ""
echo "index.html:"
head -5 docs/index.html

echo ""
echo "✅ BUILD COMPLETADO"
echo ""
echo "📋 Próximos pasos:"
echo "  git add -A"
echo "  git commit -m 'fix: build limpio para GitHub Pages'"
echo "  git push origin main"

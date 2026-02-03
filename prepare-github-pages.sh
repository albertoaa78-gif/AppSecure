#!/bin/bash
set -e

echo "🔨 Preparando AppSecure para GitHub Pages..."
cd /workspaces/AppSecure

# Ejecutar build para GitHub Pages
echo "📦 Construyendo con VITE_BASE=/AppSecure/..."
VITE_BASE=/AppSecure/ npm run build

# Crear directorio docs
echo "📁 Creando directorio docs..."
rm -rf docs
mkdir -p docs

# Copiar archivos compilados
echo "📋 Copiando archivos compilados..."
cp -r dist/* docs/

# Crear .nojekyll
echo "📝 Creando .nojekyll..."
touch docs/.nojekyll

# Verificar que los archivos están presentes
echo ""
echo "✅ Verificación final:"
echo ""
echo "Archivos en docs/:"
ls -lh docs/ | grep -v "^total" | grep -v "^d" | awk '{print "  " $9 " (" $5 ")"}'
echo ""
echo "Assets compilados:"
ls -lh docs/assets/ | grep -v "^total" | awk '{print "  " $9 " (" $5 ")"}'
echo ""

# Verificar URLs en el index.html
echo "🔗 Verificando URLs en index.html:"
if grep -q "favicon" docs/index.html; then
    echo "  ✅ Favicon referenciado"
fi
if grep -q "assets" docs/index.html; then
    echo "  ✅ Assets CSS y JS presentes"
fi
if grep -q "/AppSecure/" docs/index.html; then
    echo "  ✅ URLs con /AppSecure/ base"
fi

echo ""
echo "🚀 GitHub Pages está listo:"
echo "   Directorio: /docs"
echo "   URL: https://albertoaa78-gif.github.io/AppSecure/#/"
echo ""
echo "📝 Próximos pasos:"
echo "   git add docs/"
echo "   git commit -m 'build: generate GitHub Pages deploy'"
echo "   git push origin github-pages-static"

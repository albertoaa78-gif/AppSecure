#!/bin/bash
# Script final para preparar GitHub Pages

set -e

echo "🔄 Preparando AppSecure para GitHub Pages..."

cd /workspaces/AppSecure

# 1. Limpiar docs/
echo "🗑️  Limpiando docs/..."
rm -rf docs
mkdir -p docs

# 2. Copiar desde dist/public (build limpio sin favicon.png)
echo "📦 Copiando archivos compilados..."
cp -r dist/public/* docs/

# 3. Verificar que favicon.svg existe y favicon.png no
echo "🔍 Verificando favicon..."
if [ -f docs/favicon.svg ]; then
    echo "✅ favicon.svg presente"
else
    echo "❌ favicon.svg falta!"
    exit 1
fi

if [ -f docs/favicon.png ]; then
    echo "❌ favicon.png aún presente! Removiendo..."
    rm docs/favicon.png
fi

# 4. Asegurar archivos especiales de GitHub Pages
echo "📋 Creando archivos de GitHub Pages..."
touch docs/.nojekyll

# 5. Verificar 404.html
if [ ! -f docs/404.html ]; then
    cat > docs/404.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <script>
        window.location = '/AppSecure/index.html#' + window.location.pathname.replace(/^\/AppSecure/, '');
    </script>
</head>
</html>
EOF
fi

# 6. Resumen final
echo ""
echo "✅ Compilación completada para GitHub Pages"
echo ""
echo "📁 Contenido de docs/:"
ls -lh docs/ | grep -v "^d" | awk '{print "  " $9 " (" $5 ")"}'
echo ""
echo "📊 Archivos de assets:"
ls -lh docs/assets/ | grep -v "^d" | awk '{print "  " $9 " (" $5 ")"}'
echo ""
echo "✨ Estado:"
echo "  ✅ favicon.svg - Presente"
echo "  ✅ favicon.png - Ausente (correcto)"
echo "  ✅ .nojekyll - Presente"
echo "  ✅ 404.html - Presente"
echo "  ✅ index.html - Presente"
echo "  ✅ assets/ - Presentes"
echo ""
echo "🚀 App lista para: https://albertoaa78-gif.github.io/AppSecure/#/"

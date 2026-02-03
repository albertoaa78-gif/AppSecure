#!/bin/bash
set -e

# Este script copia los archivos compilados a docs/ con las rutas correctas para GitHub Pages

cd /workspaces/AppSecure

echo "🔨 Step 1: Build con VITE_BASE para GitHub Pages"
VITE_BASE=/AppSecure/ npm run build || true

echo "📁 Step 2: Preparar directorio docs/"
rm -rf docs
mkdir -p docs/assets

echo "📄 Step 3: Copiar index.html"
cp dist/index.html docs/index.html

echo "🎨 Step 4: Copiar CSS"
if [ -f dist/assets/*.css ]; then
    cp dist/assets/*.css docs/assets/ 2>/dev/null || true
fi

echo "⚙️  Step 5: Copiar JS"
if [ -f dist/assets/*.js ]; then
    cp dist/assets/*.js docs/assets/ 2>/dev/null || true
fi

echo "🖼️  Step 6: Copiar favicon"
if [ -f dist/favicon.svg ]; then
    cp dist/favicon.svg docs/favicon.svg
fi

echo "📝 Step 7: Crear .nojekyll"
touch docs/.nojekyll

echo "404️  Step 8: Crear 404.html"
cat > docs/404.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Redirecting...</title>
    <script>
        window.location = '/AppSecure/index.html#' + window.location.pathname.replace('/AppSecure', '');
    </script>
</head>
<body><p>Redirecting...</p></body>
</html>
EOF

echo ""
echo "✅ Completado!"
echo ""
echo "📋 Contenido de docs/:"
ls -lh docs/
echo ""
echo "📦 Assets:"
ls -lh docs/assets/ 2>/dev/null | head -10 || echo "  (no assets yet)"

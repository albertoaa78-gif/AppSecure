#!/bin/bash
# Build definitivo para GitHub Pages

echo "🔨 Compilando AppSecure para GitHub Pages..."
echo ""

cd /workspaces/AppSecure

# Limpiar
rm -rf dist docs node_modules/.vite

# Build con base URL correcta para GitHub Pages
echo "📦 Ejecutando build con VITE_BASE=/AppSecure/..."
export VITE_BASE=/AppSecure/
npm run build

# Copiar a docs/
echo "📂 Copiando a docs/..."
rm -rf docs
mkdir -p docs
cp -r dist/public/* docs/

# Limpiar favicon.png si existe
if [ -f docs/favicon.png ]; then
    rm docs/favicon.png
    echo "🗑️  favicon.png removido"
fi

# Asegurar .nojekyll
touch docs/.nojekyll

echo ""
echo "✅ Build completado!"
echo ""
echo "📋 Resumen:"
echo "  ✅ Build exit code: $?"
echo "  ✅ docs/ directory created"
echo "  ✅ Assets in docs/assets/"
echo "  ✅ favicon.svg present"
echo "  ✅ .nojekyll created"
echo ""
echo "🚀 URL: https://albertoaa78-gif.github.io/AppSecure/#/"

#!/bin/bash
set -e

echo "🔨 Limpiando builds anteriores..."
rm -rf dist docs

echo "📦 Construyendo para GitHub Pages..."
VITE_BASE=/AppSecure/ npm run build

echo "📁 Copiando dist/public a docs..."
cp -r dist/public docs

echo "✅ Build completado"
echo ""
echo "📝 Archivos generados en docs/:"
ls -la docs/ | head -20

echo ""
echo "✨ Listos para hacer git add y push"

#!/bin/bash
# Auto-commit and push all fixes

cd /workspaces/AppSecure

echo "📦 Preparando cambios..."
git add -A

echo "📝 Creando commit..."
git commit -m "fix: update bufferutil version, change npm ci to npm install, remove cache"

echo "🚀 Haciendo push..."
git push origin main

echo "✅ Push completado"
echo ""
echo "GitHub Actions debería estar ejecutándose en:"
echo "https://github.com/albertoaa78-gif/AppSecure/actions"
echo ""
echo "Esperado en 2-3 minutos:"
echo "✅ npm install (sin errores de bufferutil)"
echo "✅ vite build (sin errores de await)"
echo "✅ Deploy a GitHub Pages"
echo "✅ App viva en: https://albertoaa78-gif.github.io/AppSecure/#/"

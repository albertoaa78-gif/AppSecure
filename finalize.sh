#!/bin/bash
set -e

cd /workspaces/AppSecure

echo "🔀 Cambiando a rama main..."
git checkout main

echo "📝 Limpiando archivos innecesarios..."
# Remover carpetas y archivos que no se necesitan
rm -rf server shared script drizzle.config.ts build-gh-pages.sh copy-to-github-pages.sh deploy.sh prepare-github-pages.sh client/src/lib/queryClient.ts index.html

echo "📋 Agregando cambios..."
git add -A

echo "💾 Commiteando..."
git commit -m "refactor: convert to pure static site - remove server/backend, keep only client and static assets"

echo "⬆️  Haciendo push a main..."
git push origin main

echo "✅ ¡Completado!"
echo "🚀 GitHub Pages está listo: https://albertoaa78-gif.github.io/AppSecure/#/"

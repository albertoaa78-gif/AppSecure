#!/bin/bash
set -e
cd /workspaces/AppSecure
echo "📝 Estado actual:"
git status

echo ""
echo "🧾 Haciendo commit..."
git add -A
git commit -m "chore(pages): update docs for GitHub Pages" || echo "No hay cambios nuevos"

echo ""
echo "⬆️  Haciendo push a github-pages-static..."
git push -u origin github-pages-static

echo ""
echo "✅ ¡Completado!"
echo "🚀 Verifica: https://github.com/albertoaa78-gif/AppSecure/tree/github-pages-static/docs"

#!/bin/bash
set -euo pipefail

ROOT="/workspaces/AppSecure"
BRANCH="github-pages-static"
COMMIT_MSG="chore(pages): update docs for GitHub Pages"

echo "🔨 Preparando AppSecure para GitHub Pages..."
cd "$ROOT"

echo "📦 Compilando con VITE_BASE=/AppSecure/"
export VITE_BASE="/AppSecure/"
npm run build

echo "📁 Regenerando docs/ desde dist/"
rm -rf docs
mkdir -p docs
cp -r dist/* docs/ || cp -r dist/public/* docs/ || true

echo "📝 Asegurando .nojekyll y 404.html"
touch docs/.nojekyll
cat > docs/404.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>Redirecting...</title>
    <script>
        const path = window.location.pathname.replace('/AppSecure', '');
        window.location = '/AppSecure/index.html#' + path + window.location.search + window.location.hash;
    </script>
    <noscript>Redirecting...</noscript>
</head>
<body>
    <p>Redirecting...</p>
</body>
</html>
EOF

echo "✅ Archivos preparados en docs/"
ls -la docs | sed -n '1,200p'

echo "🔀 Comprobando rama git: $BRANCH"
# Crear o cambiar a la rama localmente
if git show-ref --verify --quiet refs/heads/$BRANCH; then
    git checkout $BRANCH
else
    git checkout -b $BRANCH
fi

echo "🧾 Añadiendo y commiteando cambios en $BRANCH"
git add -A docs || true
if git diff --staged --quiet; then
    echo "No hay cambios nuevos para commitear."
else
    git commit -m "$COMMIT_MSG"
fi

echo "⬆️ Pushing a origin/$BRANCH"
git push -u origin $BRANCH

echo "✅ Push completado a origin/$BRANCH"
echo "🚀 Si GitHub Pages está configurado para publicar desde esta rama, la web se actualizará en unos minutos."
echo "Si prefieres publicar desde la rama main (/docs), haz merge de esta rama a main o cambia la configuración de Pages en GitHub."

#!/bin/bash
set -e

cd /workspaces/AppSecure

# 1. Remover archivo raíz index.html que causa conflictos
rm -f index.html

# 2. Remover favicon.png antiguo
rm -f client/public/favicon.png dist/public/favicon.png

# 3. Limpiar y reconstruir
rm -rf dist docs node_modules/.vite

# 4. Build para GitHub Pages
VITE_BASE=/AppSecure/ npm run build

# 5. Copiar a docs/
mkdir -p docs
cp -r dist/public/* docs/

# 6. Asegurar archivos especiales
touch docs/.nojekyll

# 7. Crear 404.html para rutas dinámicas
cat > docs/404.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AppSecure</title>
    <script>
        // Redirigir 404s a index.html para manejar rutas SPA
        var path = window.location.pathname.replace('/AppSecure/', '/');
        window.location = 'https://albertoaa78-gif.github.io/AppSecure/#' + path;
    </script>
</head>
<body>Redirecting...</body>
</html>
EOF

echo "✅ Build completado para GitHub Pages"
echo "📁 Archivos en docs/:"
ls -la docs/ | head -15


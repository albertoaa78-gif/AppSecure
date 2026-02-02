#!/bin/bash
# Build script para GitHub Pages - versión estática pura

echo "🔨 Iniciando build para GitHub Pages..."

# Limpiar builds anteriores
rm -rf dist docs

# Hacer build con Vite
echo "📦 Compilando con Vite..."
VITE_BASE=/AppSecure/ npm run build

# Copiar dist a docs para GitHub Pages
echo "📁 Moviendo archivos a docs/"
mkdir -p docs
cp -r dist/* docs/

# Crear archivos necesarios para GitHub Pages
echo "⚙️  Configurando GitHub Pages..."
touch docs/.nojekyll

# Crear un 404.html que redirige al index.html para hash routing
cat > docs/404.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <script>
    // Redirigir todas las rutas 404 a index.html para que wouter maneje el routing
    window.location.replace('/AppSecure/index.html#' + window.location.pathname.replace(/^\/AppSecure/, ''));
  </script>
</head>
<body>
  <p>Redirigiendo...</p>
</body>
</html>
EOF

echo "✅ Build completado!"
echo "📍 Archivos estáticos en: docs/"
echo ""
echo "Próximos pasos:"
echo "1. Hacer push a GitHub: git push origin github-pages-static"
echo "2. Cambiar la rama de deployment en GitHub Pages a 'github-pages-static' desde 'docs' folder"
echo "3. Esperar a que GitHub Pages publique"
echo "4. Acceder a: https://albertoaa78-gif.github.io/AppSecure/"

#!/bin/bash
#
# Script de build DEFINITIVO para GitHub Pages
# Esto borra TODO y rehace el build desde cero
#

set -e

echo "📋 INICIO DE BUILD LIMPIO PARA GITHUB PAGES"
echo ""

# PASO 1: Verificar que estamos en la carpeta correcta
if [ ! -f "package.json" ]; then
  echo "❌ Error: package.json no encontrado. Ejecuta desde la raíz del proyecto."
  exit 1
fi

# PASO 2: Limpiar completamente
echo "🗑️  PASO 1: Limpieza total"
echo "   - Removiendo dist/"
rm -rf dist
echo "   - Removiendo docs/"
rm -rf docs
echo "   - Removiendo node_modules/.vite"
rm -rf node_modules/.vite 2>/dev/null || true
echo ""

# PASO 3: Crear carpeta docs vacía
echo "📁 PASO 2: Crear carpeta docs/"
mkdir -p docs
echo ""

# PASO 4: Build con Vite
echo "🔨 PASO 3: Compilar con Vite"
echo "   VITE_BASE=/AppSecure/ → assets en /AppSecure/assets/"
VITE_BASE=/AppSecure/ npm run build
echo ""

# PASO 5: Copiar archivos
echo "📂 PASO 4: Copiar dist/public → docs/"
cp -r dist/public/* docs/
echo ""

# PASO 6: Configuración GitHub Pages
echo "⚙️  PASO 5: Configurar para GitHub Pages"

# .nojekyll para que GitHub Pages no procese jekyll
touch docs/.nojekyll
echo "   ✓ .nojekyll creado"

# Crear 404.html que redirige a index.html
# (GitHub Pages usa esto para rutas no encontradas)
cat > docs/404.html << 'ENDOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Redirecting...</title>
    <script>
        // Redirigir todas las rutas a index.html para que wouter las maneje
        const path = window.location.pathname;
        const parts = path.split('/');
        // Remover 'AppSecure' del path si está presente
        if (parts[1] === 'AppSecure') {
            parts.splice(1, 1);
        }
        // Redirigir a index.html con el path original en la URL
        window.location = '/AppSecure/index.html#' + path;
    </script>
</head>
<body>
    <p>Redirecting...</p>
</body>
</html>
ENDOF
echo "   ✓ 404.html creado para rutas dinámicas"

echo ""
echo "✅ BUILD COMPLETADO"
echo ""
echo "📊 Estado final de docs/:"
echo "   - Archivos:"
ls -1 docs/ | head -10
echo ""
echo "   - Tamaño de index.html:"
wc -c < docs/index.html | numfmt --to=iec 2>/dev/null || wc -c < docs/index.html
echo ""
echo "   - JS files:"
ls docs/assets/*.js 2>/dev/null | head -3 || echo "   (no hay .js)"
echo ""

# Verificar que index.html está bien
if grep -q "root" docs/index.html; then
    echo "✅ index.html contiene el div root"
else
    echo "❌ ERROR: index.html no contiene div root"
    exit 1
fi

if grep -q "AppSecure" docs/index.html; then
    echo "✅ index.html contiene rutas /AppSecure/"
else
    echo "⚠️  ADVERTENCIA: index.html no contiene /AppSecure/"
fi

echo ""
echo "🚀 Próximos pasos:"
echo "   git add -A"
echo "   git commit -m 'build: deploy limpio a GitHub Pages'"
echo "   git push origin main"
echo ""
echo "📍 URL: https://albertoaa78-gif.github.io/AppSecure/#/"

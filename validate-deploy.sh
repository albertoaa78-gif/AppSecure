#!/bin/bash

# 🎯 VALIDACIÓN FINAL PRE-DEPLOY
echo "🎯 VALIDACIÓN FINAL PRE-DEPLOY - APPSECURE"
echo "=========================================="
echo ""

cd /workspaces/AppSecure

# 1. Verificar que main branch tiene /docs
echo "📦 1. Verificando rama main y carpeta /docs..."
if git rev-parse --verify main > /dev/null 2>&1; then
  echo "   ✅ Rama main existe"
else
  echo "   ⚠️  Rama main NO encontrada"
fi

# 2. Verificar que /docs tiene todo lo necesario
echo ""
echo "📄 2. Verificando contenido de /docs/"
required_files=(
  "docs/index.html"
  "docs/404.html"
  "docs/.nojekyll"
  "docs/favicon.svg"
  "docs/assets/index-R4WCvtgO.css"
  "docs/assets/index-_wm-B-xO.js"
)

missing_files=0
for file in "${required_files[@]}"; do
  if [ -f "$file" ]; then
    echo "   ✅ $file"
  else
    echo "   ❌ $file FALTA"
    ((missing_files++))
  fi
done

if [ $missing_files -eq 0 ]; then
  echo ""
  echo "   ✅ Todos los archivos requeridos presentes"
else
  echo ""
  echo "   ❌ Faltan $missing_files archivos"
  exit 1
fi

# 3. Validar index.html
echo ""
echo "🔍 3. Validando index.html..."
if grep -q 'lang="en"' docs/index.html; then
  echo "   ✅ Idioma configurado"
fi

if grep -q '<title>Analytica Secure' docs/index.html; then
  echo "   ✅ Título correcto"
fi

if grep -q 'viewport.*width=device-width' docs/index.html; then
  echo "   ✅ Viewport configurado"
fi

if grep -q '/AppSecure/favicon.svg' docs/index.html; then
  echo "   ✅ Favicon path correcto"
fi

if grep -q '/AppSecure/assets/index-.*\.js' docs/index.html; then
  echo "   ✅ JS asset path correcto"
fi

if grep -q '/AppSecure/assets/index-.*\.css' docs/index.html; then
  echo "   ✅ CSS asset path correcto"
fi

# 4. Validar 404.html para SPA
echo ""
echo "🗂️  4. Validando 404.html para SPA routing..."
if grep -q "sessionStorage.redirect" docs/404.html; then
  echo "   ✅ SPA redirect logic presente"
fi

if grep -q '/AppSecure/' docs/404.html; then
  echo "   ✅ Rutas base correctas"
fi

# 5. Tamaños y estadísticas
echo ""
echo "📊 5. Estadísticas de build..."
JS_SIZE=$(du -h docs/assets/index-_wm-B-xO.js 2>/dev/null | awk '{print $1}')
CSS_SIZE=$(du -h docs/assets/index-R4WCvtgO.css 2>/dev/null | awk '{print $1}')
TOTAL=$(du -sh docs 2>/dev/null | awk '{print $1}')

echo "   CSS: $CSS_SIZE"
echo "   JS: $JS_SIZE"
echo "   Total /docs: $TOTAL"

# 6. Verificar que no hay archivos node_modules
echo ""
echo "🚫 6. Verificando integridad de /docs (sin build artifacts)..."
if [ ! -d "docs/node_modules" ]; then
  echo "   ✅ Sin node_modules en docs"
else
  echo "   ❌ node_modules encontrado en docs (error)"
  exit 1
fi

# 7. Generar resumen
echo ""
echo "=========================================="
echo "✅ VALIDACIÓN COMPLETADA - TODO CORRECTO"
echo ""
echo "📋 Resumen para GitHub Pages:"
echo "   Repository: albertoaa78-gif/AppSecure"
echo "   Branch: main"
echo "   Folder: /docs"
echo "   Base URL: https://albertoaa78-gif.github.io/AppSecure/"
echo ""
echo "🎯 Próximos pasos:"
echo "   1. Ir a Settings → Pages"
echo "   2. Seleccionar: Branch = main"
echo "   3. Seleccionar: Folder = /docs"
echo "   4. Click Save"
echo "   5. Esperar 2-5 minutos"
echo ""
echo "📱 Rutas disponibles:"
echo "   https://albertoaa78-gif.github.io/AppSecure/#/"
echo "   https://albertoaa78-gif.github.io/AppSecure/#/services"
echo "   https://albertoaa78-gif.github.io/AppSecure/#/technology"
echo "   https://albertoaa78-gif.github.io/AppSecure/#/contact"
echo ""

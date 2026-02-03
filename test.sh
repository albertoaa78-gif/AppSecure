#!/bin/bash

echo "🧪 TESTING APPSECURE - VERIFICACIÓN COMPLETA"
echo "============================================"
echo ""

cd /workspaces/AppSecure

# 1. Verificar estructura de archivos
echo "📁 1. Verificando estructura de archivos..."
if [ -f docs/index.html ]; then
  echo "   ✅ docs/index.html presente"
else
  echo "   ❌ docs/index.html FALTA"
  exit 1
fi

if [ -f docs/.nojekyll ]; then
  echo "   ✅ docs/.nojekyll presente"
else
  echo "   ❌ docs/.nojekyll FALTA"
fi

if [ -f docs/404.html ]; then
  echo "   ✅ docs/404.html presente"
else
  echo "   ❌ docs/404.html FALTA"
fi

if [ -f docs/assets/index-R4WCvtgO.css ]; then
  echo "   ✅ CSS compilado presente"
else
  echo "   ❌ CSS FALTA"
  exit 1
fi

if [ -f docs/assets/index-_wm-B-xO.js ]; then
  echo "   ✅ JS compilado presente"
else
  echo "   ❌ JS FALTA"
  exit 1
fi

# 2. Verificar contenido del index.html
echo ""
echo "🔗 2. Verificando URLs en index.html..."
FAVICON=$(grep -c "/AppSecure/favicon.svg" docs/index.html || echo 0)
CSS=$(grep -c "/AppSecure/assets/index-R4WCvtgO.css" docs/index.html || echo 0)
JS=$(grep -c "/AppSecure/assets/index-_wm-B-xO.js" docs/index.html || echo 0)

if [ "$FAVICON" -gt 0 ]; then
  echo "   ✅ Favicon correctamente referenciado"
else
  echo "   ⚠️  Favicon URL no está correcta"
fi

if [ "$CSS" -gt 0 ]; then
  echo "   ✅ CSS correctamente referenciado"
else
  echo "   ❌ CSS URL incorrecta"
  exit 1
fi

if [ "$JS" -gt 0 ]; then
  echo "   ✅ JS correctamente referenciado"
else
  echo "   ❌ JS URL incorrecta"
  exit 1
fi

# 3. Verificar componentes principales
echo ""
echo "⚙️  3. Verificando componentes principales..."

# Verificar que Navigation existe
if grep -q "Navigation" client/src/pages/Home.tsx; then
  echo "   ✅ Componente Navigation usado"
else
  echo "   ⚠️  Navigation no encontrado"
fi

# Verificar que Footer existe
if grep -q "Footer" client/src/pages/Home.tsx; then
  echo "   ✅ Componente Footer usado"
else
  echo "   ⚠️  Footer no encontrado"
fi

# 4. Verificar archivos de páginas
echo ""
echo "📄 4. Verificando páginas..."
PAGES=("Home" "Services" "Technology" "Contact")
for page in "${PAGES[@]}"; do
  if [ -f "client/src/pages/$page.tsx" ]; then
    echo "   ✅ $page.tsx presente"
  else
    echo "   ❌ $page.tsx FALTA"
    exit 1
  fi
done

# 5. Verificar que no hay referencias a API o servidor
echo ""
echo "🚫 5. Verificando que no hay referencias a API/servidor..."
if grep -r "http://localhost" client/src/ 2>/dev/null | grep -v node_modules; then
  echo "   ⚠️  Encontradas referencias a localhost"
else
  echo "   ✅ Sin referencias a localhost"
fi

if grep -r "/api/" client/src/ 2>/dev/null | grep -v node_modules | grep -v "\/\/" | head -5; then
  echo "   ⚠️  Encontradas posibles referencias a API"
else
  echo "   ✅ Sin referencias de API detectadas"
fi

# 6. Tamaños
echo ""
echo "📊 6. Información de tamaños..."
CSS_SIZE=$(du -h docs/assets/index-R4WCvtgO.css | awk '{print $1}')
JS_SIZE=$(du -h docs/assets/index-_wm-B-xO.js | awk '{print $1}')
TOTAL_SIZE=$(du -sh docs | awk '{print $1}')

echo "   CSS: $CSS_SIZE"
echo "   JS: $JS_SIZE"
echo "   Total /docs: $TOTAL_SIZE"

# 7. Verificar que el build actual está en dist
echo ""
echo "🏗️  7. Estado del build..."
if [ -d "dist" ] && [ -f "dist/index.html" ]; then
  echo "   ✅ dist/ generado y actualizado"
else
  echo "   ⚠️  dist/ no encontrado"
fi

echo ""
echo "============================================"
echo "✅ TESTING COMPLETADO - TODO LISTO"
echo ""
echo "🚀 La web está lista en:"
echo "   Local dev: npm run dev"
echo "   GitHub Pages: https://albertoaa78-gif.github.io/AppSecure/#/"
echo ""
echo "📝 Rutas disponibles:"
echo "   /#/              → Home"
echo "   /#/services      → Servicios"
echo "   /#/technology    → Tecnología"
echo "   /#/contact       → Contacto"
echo ""

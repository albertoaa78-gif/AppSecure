#!/bin/bash
# Verificar estado de deployment

echo "✅ Verificando AppSecure Deployment"
echo ""

# 1. Verificar archivos en /docs
echo "📁 Archivos en /docs:"
cd /workspaces/AppSecure

if [ -f docs/.nojekyll ]; then
    echo "  ✅ .nojekyll"
else
    echo "  ❌ .nojekyll FALTA"
fi

if [ -f docs/index.html ]; then
    echo "  ✅ index.html"
else
    echo "  ❌ index.html FALTA"
fi

if [ -f docs/favicon.svg ]; then
    echo "  ✅ favicon.svg"
else
    echo "  ❌ favicon.svg FALTA"
fi

if [ -f docs/404.html ]; then
    echo "  ✅ 404.html"
else
    echo "  ❌ 404.html FALTA"
fi

echo ""
echo "📊 Assets compilados:"
ASSETS=$(ls docs/assets/ 2>/dev/null | wc -l)
if [ "$ASSETS" -gt 0 ]; then
    echo "  ✅ $ASSETS archivos en assets/"
    ls -lh docs/assets/ | grep -v "^total" | awk '{print "     " $9 " (" $5 ")"}'
else
    echo "  ❌ NO HAY ASSETS"
fi

echo ""
echo "🔗 Verificando URLs en index.html:"
if grep -q '/AppSecure/favicon.svg' docs/index.html; then
    echo "  ✅ favicon URL correcta"
else
    echo "  ❌ favicon URL incorrecta"
fi

if grep -q '/AppSecure/assets/' docs/index.html; then
    echo "  ✅ assets URL correcta"
else
    echo "  ❌ assets URL incorrecta"
fi

echo ""
echo "⚠️  Verificando problemas:"
if [ -f docs/favicon.png ]; then
    echo "  ⚠️  favicon.png AÚN EXISTE (conflicto)"
else
    echo "  ✅ favicon.png no existe (correcto)"
fi

if grep -q 'src="/' docs/index.html; then
    echo "  ✅ Rutas absolutas presentes"
fi

echo ""
echo "🚀 URL para probar:"
echo "   https://albertoaa78-gif.github.io/AppSecure/#/"
echo ""
echo "📝 Si no funciona:"
echo "   1. Limpia caché: Ctrl+Shift+R (Windows/Linux) o Cmd+Shift+R (Mac)"
echo "   2. Espera 2-3 minutos después del push"
echo "   3. Abre DevTools (F12) y revisa console"
echo "   4. Verifica Network tab para errores 404"

#!/bin/bash

echo "🔄 SINCRONIZANDO RAMAS Y HACIENDO PUSH A MAIN"
echo "=============================================="
echo ""

cd /workspaces/AppSecure

# 1. Ver estado actual
echo "📍 Estado actual:"
git status
echo ""

# 2. Cambiar a main (si no estamos)
echo "🔄 Cambiando a rama main..."
git checkout main
if [ $? -ne 0 ]; then
  echo "❌ Error al cambiar a main"
  exit 1
fi
echo "✅ Estamos en rama main"
echo ""

# 3. Hacer pull para traer cambios remotos
echo "📥 Trayendo cambios remotos de origin/main..."
git pull origin main --no-edit
if [ $? -ne 0 ]; then
  echo "⚠️  Error durante pull (posible conflicto)"
  echo "Verificando cambios en github-pages-static..."
  git status
  exit 1
fi
echo "✅ Pull completado"
echo ""

# 4. Mergear github-pages-static en main
echo "🔀 Mergeando github-pages-static en main..."
git merge github-pages-static --no-edit
if [ $? -ne 0 ]; then
  echo "⚠️  Conflictos detectados durante merge"
  echo "❌ Por favor resuelve los conflictos manualmente:"
  echo ""
  echo "1. Los conflictos están marcados con <<<<<<<, =======, >>>>>>>"
  echo "2. Edita los archivos para mantener la versión correcta"
  echo "3. Luego ejecuta:"
  echo "   git add ."
  echo "   git commit -m 'Merge: resolver conflictos'"
  echo "   git push origin main"
  exit 1
fi
echo "✅ Merge completado sin conflictos"
echo ""

# 5. Agregar todos los cambios
echo "📦 Staging de cambios..."
git add .
echo "✅ Cambios en staging"
echo ""

# 6. Commit
echo "💾 Haciendo commit..."
git commit -m "feat: convert to static SPA for GitHub Pages

- Remove Express/PostgreSQL/Drizzle backend
- Convert hooks to localStorage-based implementation
- Add 404.html for SPA routing fallback
- All assets compiled and minified in /docs/
- Hash-based routing compatible with GitHub Pages
- Testing reports and deployment documentation added

Ready for GitHub Pages deployment from main branch"

if [ $? -ne 0 ]; then
  echo "⚠️  No hay cambios nuevos para commitear (ya estaban en main)"
fi
echo ""

# 7. Push a main
echo "🚀 Haciendo push a origin/main..."
git push origin main
if [ $? -eq 0 ]; then
  echo "✅ Push completado exitosamente"
  echo ""
  echo "=========================================="
  echo "✅ TODO LISTO PARA GITHUB PAGES"
  echo ""
  echo "📍 Próximos pasos:"
  echo "1. Ve a Settings → Pages"
  echo "2. Branch: main"
  echo "3. Folder: /docs"
  echo "4. Click Save"
  echo "5. Espera 2-5 minutos"
  echo ""
  echo "📱 Verifica en:"
  echo "https://albertoaa78-gif.github.io/AppSecure/#/"
else
  echo "❌ Error durante push"
  echo ""
  echo "Posibles causas:"
  echo "- Falta de permisos"
  echo "- Conflictos no resueltos"
  echo "- Rama remota protegida"
  exit 1
fi

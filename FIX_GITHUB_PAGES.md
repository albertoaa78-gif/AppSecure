# 🆘 GitHub Pages Deploy - Solución Rápida

## ❌ Si ves pantalla negra o error

### Paso 1: Limpiar Caché (CRÍTICO)

**Opción A - Hard Refresh:**
- **Windows/Linux**: `Ctrl + Shift + R`
- **Mac**: `Cmd + Shift + R`

**Opción B - DevTools:**
1. Abre: https://albertoaa78-gif.github.io/AppSecure/#/
2. Presiona `F12`
3. Click derecho en botón Refresh → "Empty cache and hard refresh"

### Paso 2: Esperar GitHub Pages

Deploy típicamente tarda **2-4 minutos** después de push:
- Build: 30-60s
- Deploy: 30-60s  
- Propagación: 1-2 min

**Espera 3 minutos después de ver los commits en GitHub**

### Paso 3: Ver Errores en DevTools

1. Abre: https://albertoaa78-gif.github.io/AppSecure/#/
2. Presiona `F12`
3. Pestaña "Console" - busca errores rojos
4. Pestaña "Network" - busca 404s en assets

### Paso 4: Recompilar Localmente

Si aún falla, recompila:

```bash
cd /workspaces/AppSecure

# Limpia todo
rm -rf dist docs node_modules/.vite

# Recompila para GitHub Pages
npm run build:gh

# Verifica que tenga /AppSecure/
grep '/AppSecure/assets' docs/index.html

# Resultado: ✅ debe mostrar 2 líneas con /AppSecure/assets
```

Luego commit + push:
```bash
git add docs/
git commit -m "fix: rebuild for github pages"
git push origin main
```

## ✅ Lo que ya está correcto

```
✅ /docs/.nojekyll - Presente
✅ /docs/404.html - Presente
✅ /docs/favicon.svg - Presente
✅ /docs/index.html - URLs correctas (/AppSecure/assets/)
✅ /docs/assets/*.js - Compilado
✅ /docs/assets/*.css - Compilado
✅ /docs/favicon.png - Eliminado (no hay conflicto)
✅ .github/workflows/deploy.yml - Configurado
```

## 🔍 Verificar Manualmente

```bash
# Verificar contenido de /docs
ls -la /workspaces/AppSecure/docs/

# Debe mostrar:
# .nojekyll
# 404.html
# favicon.svg
# index.html
# assets/

# Verificar URLs en HTML
grep -n '/AppSecure/' /workspaces/AppSecure/docs/index.html

# Debe mostrar: (2 líneas con /AppSecure/)
# 6: href="/AppSecure/favicon.svg"
# 12: src="/AppSecure/assets/index-XXXXX.js"
# 13: href="/AppSecure/assets/index-XXXXX.css"
```

## 🌐 Rutas para Probar

Después de fix, estas deben funcionar:

```
✅ https://albertoaa78-gif.github.io/AppSecure/#/
✅ https://albertoaa78-gif.github.io/AppSecure/#/services
✅ https://albertoaa78-gif.github.io/AppSecure/#/technology
✅ https://albertoaa78-gif.github.io/AppSecure/#/contact
```

## 🐛 Errores Comunes y Soluciones

| Error | Causa | Solución |
|-------|-------|----------|
| Pantalla negra | Caché | Hard refresh: Ctrl+Shift+R |
| 404 en assets | Rutas incorrectas | Recompilar: `npm run build:gh` |
| Favicon antiguo | Caché navegador | Hard refresh + limpiar cookies |
| Sin CSS | CSS no carga | Ver Network tab, verificar URLs |
| Errores console | Import error | Ver mensaje exacto, verificar hooks |

## 📞 Ayuda Necesaria

Comparte:
1. **URL donde falla**: https://albertoaa78-gif.github.io/AppSecure/#/
2. **Error en Console** (F12 → Console): Copia el mensaje
3. **Requests fallidas** (F12 → Network): Qué devuelve 404?
4. **Screenshot**: Muestra exactamente qué ves

## ⏰ Checklist Final

- [ ] Hiciste hard refresh (Ctrl+Shift+R)?
- [ ] Esperaste 3+ minutos después del push?
- [ ] Viste el commit en GitHub?
- [ ] Verificaste /docs tiene todos los archivos?
- [ ] Abriste F12 Console para ver errores?
- [ ] Verificaste Network tab para 404s?

---

**SOLUCIÓN MÁS PROBABLE**: 
1. Hard refresh (Ctrl+Shift+R)
2. Espera 3 minutos
3. Abre en navegador incógnito (Ctrl+Shift+N o Cmd+Shift+N)

Si sigue fallando después de esto, necesitamos ver:
- El error exacto de console
- Qué requests fallan en Network tab

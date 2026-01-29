# 🔧 Solución de Problemas - GitHub Pages Deploy

## 🔍 Verificación del Estado

### 1. Verificar que los archivos están en GitHub
Navega a: https://github.com/albertoaa78-gif/AppSecure/tree/main/docs

Debe mostrar:
```
docs/
├── .nojekyll      ✅
├── 404.html       ✅
├── favicon.svg    ✅
├── index.html     ✅
└── assets/
    ├── index-XXXXX.js
    └── index-XXXXX.css
```

### 2. Verificar la Configuración de GitHub Pages

1. Ve a: https://github.com/albertoaa78-gif/AppSecure/settings/pages
2. Verifica que:
   - ✅ Source: Deploy from a branch
   - ✅ Branch: main  
   - ✅ Folder: /docs
   - Click "Save" si lo modificas

### 3. Limpiar Caché del Navegador

**Opción A: Hard Refresh**
- Windows/Linux: `Ctrl + Shift + R`
- Mac: `Cmd + Shift + R`

**Opción B: DevTools**
1. Abre DevTools (`F12`)
2. Click derecho en botón Refresh
3. Selecciona "Empty cache and hard refresh"

**Opción C: URL con parámetro**
```
https://albertoaa78-gif.github.io/AppSecure/#/?t=TIMESTAMP
```

### 4. Ver Errores en Consola

1. Abre: https://albertoaa78-gif.github.io/AppSecure/#/
2. Presiona `F12` para abrir DevTools
3. Ve a la pestaña "Console"
4. Busca errores rojos

**Errores comunes:**

❌ **"Failed to fetch"**
- Causa: App intenta conectar a servidor
- Solución: Verificar que hooks usan datos estáticos

❌ **"404 on asset"**  
- Causa: Assets con ruta incorrecta
- Solución: Verificar `/AppSecure/assets/` en index.html

❌ **"MIME type"**
- Causa: Archivo CSS/JS no se carga
- Solución: Limpiar caché + hard refresh

## 🚀 Soluciones Rápidas

### Solución 1: Recompilar Localmente

```bash
cd /workspaces/AppSecure

# Limpiar
rm -rf dist docs node_modules/.vite

# Recompilar con URL correcta
npm run build:gh

# Verificar que index.html tiene /AppSecure/
grep -o '/AppSecure/assets' docs/index.html

# Resultado debe ser:
# /AppSecure/assets/index-XXXXX.js
# /AppSecure/assets/index-XXXXX.css
```

### Solución 2: Forzar GitHub Pages a Reconstruir

```bash
# 1. Hacer cambio trivial
echo "" >> docs/index.html

# 2. Commit y push
git add docs/
git commit -m "trigger: force github pages rebuild"
git push origin main

# 3. Esperar 2-3 minutos
```

### Solución 3: Verificar Ruta Exacta

```bash
# Verificar que los archivos de assets existen
ls -la docs/assets/

# Debe mostrar:
# -rw-r--r-- ... index-XXXXX.js
# -rw-r--r-- ... index-XXXXX.css

# Verificar contenido de index.html
cat docs/index.html | grep -E 'src=|href=' | grep assets
```

## 📋 Checklist de Validación

- [ ] `docs/.nojekyll` existe
- [ ] `docs/404.html` existe  
- [ ] `docs/favicon.svg` existe
- [ ] `docs/index.html` contiene `/AppSecure/assets/`
- [ ] `docs/assets/index-*.js` existe
- [ ] `docs/assets/index-*.css` existe
- [ ] `docs/favicon.png` NO existe
- [ ] GitHub Pages configurado en `/docs`
- [ ] Navegador con caché limpio
- [ ] 2+ minutos de espera después de push

## 🔗 URLs Correctas

Después de fix, estas URLs deben funcionar:

```
✅ https://albertoaa78-gif.github.io/AppSecure/#/
✅ https://albertoaa78-gif.github.io/AppSecure/#/services
✅ https://albertoaa78-gif.github.io/AppSecure/#/technology
✅ https://albertoaa78-gif.github.io/AppSecure/#/contact
```

## 🐛 Debug - Ver Requests en Network

1. DevTools → Network tab
2. Refresh (`F5`)
3. Buscar en lista de requests:
   - `index.html` → Status 200
   - `index-XXXXX.js` → Status 200 (tamaño ~500KB)
   - `index-XXXXX.css` → Status 200 (tamaño ~50KB)
   - `favicon.svg` → Status 200

**Si ves 404**: Hay problema con rutas de assets

## 📞 Contactar GitHub Support

Si después de todo sigue fallando:

1. Ve a: https://github.com/albertoaa78-gif/AppSecure/settings/pages
2. Revisa los "Recent deployments"
3. Si hay error: haz click para ver detalles

## ⏱️ Tiempo de Deploy

GitHub Pages típicamente tarda:
- 30-60 segundos: Build del workflow
- 30-60 segundos: Deploy a CDN
- 1-2 minutos: Caché global

**Total: 2-4 minutos después de push**

---

**¿Qué error específico ves?** Comparte:
- URL donde ves el error
- Que dice la consola (F12)
- Screenshot si es posible

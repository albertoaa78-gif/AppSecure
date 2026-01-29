# Guía de Deployment a GitHub Pages

## Estado Actual ✅
- ✅ Código pusheado a `main`
- ✅ Carpeta `docs/` generada con build
- ✅ Workflow GitHub Actions configurado
- ✅ Router con hash-based routing (`/#/`)
- ✅ `.nojekyll` creado para GitHub Pages

## Pasos para Activar GitHub Pages

### 1. Ve a tu repositorio en GitHub
```
https://github.com/albertoaa78-gif/AppSecure
```

### 2. Settings → Pages
- Click en **Settings** (pestaña)
- Click en **Pages** (sidebar izquierdo)

### 3. Configura Source
- **Deploy from a branch**
- **Branch**: Selecciona `main`
- **Folder**: Selecciona `/docs`
- Click **Save**

### 4. Espera el Deploy
GitHub Pages se desplegará en ~1-2 minutos.

## URL Resultante
```
https://albertoaa78-gif.github.io/AppSecure/#/
```

### Rutas Disponibles
- `/#/` → Home
- `/#/services` → Servicios
- `/#/technology` → Tecnología
- `/#/contact` → Contacto

## Flujo de CI/CD (GitHub Actions)

El workflow `.github/workflows/deploy.yml` se ejecutará automáticamente:

```yaml
1. En cada push a 'main'
   ↓
2. Instala dependencias (npm ci)
   ↓
3. Ejecuta npm run build:gh
   - Compila cliente React
   - Establece VITE_BASE=/AppSecure/
   - Genera dist/public con assets correctos
   - Copia a carpeta docs/
   ↓
4. Publica docs/ a GitHub Pages
```

## Si Necesitas Redeploy

Solo ejecuta:
```bash
npm run build:gh
git add .
git commit -m "Update: rebuild for GitHub Pages"
git push origin main
```

El workflow se ejecutará automáticamente y actualizará el sitio en ~2 minutos.

## Troubleshooting

### ¿No funciona la ruta `/AppSecure/`?
- Verifica en Settings → Pages que muestre la URL correcta
- Limpia caché del navegador (Ctrl+Shift+R)

### ¿Las rutas no funcionan?
- Revisa que estés usando `/#/` (hash routing)
- Verifica docs/index.html tenga assets con `/AppSecure/`

### ¿Workflow falla?
- Ve a Actions tab en GitHub
- Revisa logs del último workflow
- Verifica node-version: 20 en deploy.yml

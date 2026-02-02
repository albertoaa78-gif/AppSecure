# AppSecure - GitHub Pages Edition

## 🚀 Publicación Rápida

### Paso 1: Estar en la rama correcta
```bash
git checkout github-pages-static
```

### Paso 2: Instalar dependencias
```bash
npm install --legacy-peer-deps
```

### Paso 3: Compilar
```bash
bash build-gh-pages.sh
```

### Paso 4: Push a GitHub
```bash
git add -A
git commit -m "Build para GitHub Pages"
git push origin github-pages-static
```

### Paso 5: Configurar GitHub Pages (una sola vez)
1. Ve a: Repositorio → Settings → Pages
2. Branch: `github-pages-static`
3. Folder: `/docs`
4. Click Save

### Paso 6: Acceder al sitio
Espera 1-2 minutos y abre:
```
https://albertoaa78-gif.github.io/AppSecure/
```

## 📋 Características

✅ **Completamente estático** - Sin servidor
✅ **Funciona offline** - Todos los datos locales
✅ **Formulario funcional** - Guarda en localStorage
✅ **Responsive** - Mobile, tablet, desktop
✅ **Rápido** - Minificado y optimizado

## 🔗 URLs de la Aplicación

- Home: `https://albertoaa78-gif.github.io/AppSecure/`
- Services: `https://albertoaa78-gif.github.io/AppSecure/#/services`
- Technology: `https://albertoaa78-gif.github.io/AppSecure/#/technology`
- Contact: `https://albertoaa78-gif.github.io/AppSecure/#/contact`

## 📁 Estructura

```
/docs - 📍 Lo que GitHub Pages sirve
├── index.html - Punto de entrada
├── .nojekyll - Indica a GitHub que no use Jekyll
└── assets/ - CSS, JS, imágenes
```

## 🛠️ Desarrollo Local

```bash
# Dev server
npm run dev

# Build local
npm run build

# Build para GitHub Pages
npm run build:gh
```

## ⚠️ Si Algo No Funciona

1. Verificar que la rama sea `github-pages-static`
2. Verificar que la carpeta sea `/docs`
3. Ejecutar: `rm -rf dist docs node_modules && npm install && bash build-gh-pages.sh`
4. Hacer push nuevamente
5. Esperar 2-3 minutos

¿Más ayuda? Ver: `GITHUB_PAGES_FINAL.md`

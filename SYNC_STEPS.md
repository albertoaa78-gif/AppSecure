# 🚀 Paso a Paso: Sincronizar a GitHub Pages

El terminal tiene un problema de acceso. **Estos son los comandos exactos que debes ejecutar manualmente**:

## Paso 1: Verificar estado actual
```bash
cd /workspaces/AppSecure
git status
git branch -a
```

**Resultado esperado:**
- Rama actual: `github-pages-static`
- Cambios sin guardar: Los archivos de `/docs/` modificados

---

## Paso 2: Traer últimos cambios de GitHub
```bash
git fetch origin
```

**Resultado esperado:**
- `origin/main` se actualiza
- Sin conflictos

---

## Paso 3: Cambiar a rama main
```bash
git checkout main
```

**Si esto falla con "error: your local changes...":**
```bash
git stash
git checkout main
git stash pop
```

**Resultado esperado:**
- Ya estás en rama `main`

---

## Paso 4: Actualizar main con los cambios más recientes
```bash
git pull origin main
```

**Resultado esperado:**
- `main` local = `origin/main`

---

## Paso 5: Mergear github-pages-static en main
```bash
git merge github-pages-static --no-ff -m "Merge: Sync static SPA to main for GitHub Pages"
```

**Si hay conflictos:**
```bash
# Ver conflictos
git status

# Resolver conflictos manualmente en los archivos (buscar <<<<<<<, =======, >>>>>>>)

# Después de resolver:
git add .
git commit -m "Merge: resolve conflicts during sync"
```

**Resultado esperado:**
- Merge completado sin conflictos
- Todos los archivos de `/docs/` ahora en main

---

## Paso 6: Hacer push a GitHub
```bash
git push origin main
```

**Resultado esperado:**
- Push completado sin errores
- GitHub Actions se dispara automáticamente
- App viva en: https://albertoaa78-gif.github.io/AppSecure/#/

---

## ✅ Verificación final

Después de hacer push:

1. **Espera 2-3 minutos** para que GitHub Pages compile
2. Abre: https://albertoaa78-gif.github.io/AppSecure/#/
3. Prueba todas las rutas:
   - Home (`/#/`)
   - Services (`/#/services`)
   - Technology (`/#/technology`)
   - Contact (`/#/contact`)

---

## 🆘 Troubleshooting

### Si el merge falla con conflictos:
```bash
# Ver qué cambios hay
git diff

# Abortamos si es muy complejo
git merge --abort

# E intentamos merge sin fast-forward
git merge -X theirs github-pages-static
```

### Si el push falla:
```bash
# Verificar rama remota
git branch -vv

# Forzar si es necesario (cuidado)
git push origin main -f
```

### Si necesitas ver el historial:
```bash
git log --oneline -10
git log --graph --oneline --all
```

---

## 📋 Resumen de cambios

Los cambios que se están sincronizando de `github-pages-static` a `main`:

✅ **Código convertido a SPA estática** (sin servidor)
✅ **Todos los assets compilados en `/docs/`**
✅ **404.html creado para routing SPA**
✅ **.nojekyll para GitHub Pages**
✅ **package.json optimizado** (sin dependencias de servidor)
✅ **Configuración Vite simplificada**

**Total de cambios**: ~15 archivos modificados/eliminados en la rama

---

¡Ejecuta estos comandos en el terminal de tu máquina o en VS Code!

# 🌐 URLs Y LINKS DE LA APLICACIÓN

## URL Base (IMPORTANTE)

```
https://albertoaa78-gif.github.io/AppSecure/
```

**Nota**: El `/AppSecure/` es importante porque GitHub Pages lo requiere.

---

## 📍 Rutas de la Aplicación

### 1. Página de Inicio
**URL**: `https://albertoaa78-gif.github.io/AppSecure/`
**O también**: `https://albertoaa78-gif.github.io/AppSecure/#/`

**Qué verás**:
- Logo y nombre de la empresa
- Descripción de servicios
- Botones de navegación
- Información de contacto rápido

**Elementos clickeables**:
- Logo → Vuelve a inicio
- Botón "EXPERIENCIA" → Va a servicios
- Botón "TECNOLOGÍA" → Va a tecnología
- Botón "CONSULTAR" → Va a contacto
- Botón "Programar Consulta" → Va a contacto

---

### 2. Página de Servicios
**URL**: `https://albertoaa78-gif.github.io/AppSecure/#/services`

**Qué verás**:
- Título "Soluciones Integrales de Seguridad"
- 5 tarjetas de servicios:
  1. Perímetro Inteligente con IA
  2. Protección Electrónica Avanzada
  3. Mantenimiento VIP 24/7
  4. Videoanálisis Forense
  5. Integración Domótica Segura

**Cada tarjeta tiene**:
- Icono
- Categoría
- Título
- Descripción
- Link "CONSULTAR" → Va a contacto

---

### 3. Página de Tecnología
**URL**: `https://albertoaa78-gif.github.io/AppSecure/#/technology`

**Qué verás**:
- Descripción de tecnologías usadas
- 4 tarjetas de tecnología:
  1. Inteligencia Artificial
  2. IoT Seguro
  3. Análisis Biométrico
  4. Cloud Computing

**Cada elemento tiene**:
- Descripción detallada
- Especificaciones técnicas
- Beneficios

---

### 4. Página de Contacto
**URL**: `https://albertoaa78-gif.github.io/AppSecure/#/contact`

**Qué verás**:
- Formulario de contacto con campos:
  - Nombre Completo
  - Email
  - Teléfono
  - Tipo de Servicio (selector)
  - Mensaje (área de texto)
  - Botón Enviar

- Información de contacto:
  - Línea Directa: +34 91 123 45 67
  - Sede Central: Paseo de la Castellana 100, Madrid

**Funcionalidad del formulario**:
- Al hacer click en "Enviar":
  - Se validan los campos
  - Se guarda en localStorage del navegador
  - Muestra mensaje de confirmación
  - Se limpia el formulario

---

## 🔗 Estructura de Navegación

```
Inicio (/)
├─ Link: EXPERIENCIA → Servicios (#/services)
├─ Link: TECNOLOGÍA → Tecnología (#/technology)
├─ Link: CONTACTO → Contacto (#/contact)
└─ Link: Programar Consulta → Contacto (#/contact)

Servicios (#/services)
├─ Logo → Inicio (/)
├─ EXPERIENCIA (activo)
├─ TECNOLOGÍA → Tecnología (#/technology)
├─ CONTACTO → Contacto (#/contact)
└─ Tarjetas con "CONSULTAR" → Contacto (#/contact)

Tecnología (#/technology)
├─ Logo → Inicio (/)
├─ EXPERIENCIA → Servicios (#/services)
├─ TECNOLOGÍA (activo)
├─ CONTACTO → Contacto (#/contact)
└─ Botones de "Solicitar Asesoría" → Contacto (#/contact)

Contacto (#/contact)
├─ Logo → Inicio (/)
├─ EXPERIENCIA → Servicios (#/services)
├─ TECNOLOGÍA → Tecnología (#/technology)
├─ CONTACTO (activo)
└─ Formulario funcional
```

---

## 📱 URLs en Diferentes Dispositivos

### Desktop
- Resolución: 1920x1080 o superior
- Navega normal
- Formulario con campos lado a lado

### Tablet
- Resolución: 768x1024
- Diseño se ajusta
- Formulario apilado verticalmente

### Mobile
- Resolución: 375x667 o similar
- Menú en hamburguesa
- Todos los elementos apilados
- Totalmente funcional

---

## 🧪 Test de URLs (Verifica que todas funcionan)

Cuando publiques, prueba estos links:

```
✅ https://albertoaa78-gif.github.io/AppSecure/
   └─ Debe cargar inicio sin errores

✅ https://albertoaa78-gif.github.io/AppSecure/#/services
   └─ Debe mostrar 5 servicios

✅ https://albertoaa78-gif.github.io/AppSecure/#/technology
   └─ Debe mostrar 4 tecnologías

✅ https://albertoaa78-gif.github.io/AppSecure/#/contact
   └─ Debe mostrar formulario funcional

❌ https://albertoaa78-gif.github.io/AppSecure/404
   └─ Esto es 404, pero GitHub lo redirige a inicio

❌ https://albertoaa78-gif.github.io/AppSecure/invalidurl
   └─ También 404, redirigido a inicio
```

---

## 🔍 Cómo Verificar que los Links Funcionan

1. **En el navegador**:
   - Abre https://albertoaa78-gif.github.io/AppSecure/
   - Click en cada link del menú
   - Verifica que carga la página correcta
   - Click en el logo → Vuelve a inicio

2. **Prueba el formulario**:
   - Ve a Contact
   - Llena los campos
   - Click en "Enviar"
   - Verifica que sale mensaje de éxito

3. **Prueba responsive**:
   - F12 en el navegador
   - Device toolbar
   - Selecciona iPhone XS
   - Verifica que todo se ve bien
   - Click en menú hamburguesa
   - Navega entre páginas

---

## 🚨 URLs que NO Funcionarán (y es normal)

```
❌ https://albertoaa78-gif.github.io/AppSecure/services
   └─ Sin el # no funciona en GitHub Pages (por eso es /#/services)

❌ https://albertoaa78-gif.github.io/api/services
   └─ No hay servidor, no hay API

❌ https://albertoaa78-gif.github.io/AppSecure/about
   └─ No existe esta página (solo Inicio, Servicios, Tecnología, Contacto)
```

---

## 📊 Ejemplo de Navegación Completa

### Escenario: Usuario nuevo visitando tu app

```
1. Entra a: https://albertoaa78-gif.github.io/AppSecure/
   └─ Ve inicio, entiende qué hace tu empresa

2. Click en "EXPERIENCIA"
   └─ Ve los 5 servicios disponibles

3. Click en "CONSULTAR" en un servicio
   └─ Va a formulario de contacto

4. Llena el formulario y envía
   └─ Ve "Consulta Recibida"
   └─ Datos guardados en localStorage

5. Click en logo
   └─ Vuelve a inicio

6. Click en "TECNOLOGÍA"
   └─ Ve tecnologías usadas

7. Click en "CONTACTO"
   └─ Ve formulario nuevamente
```

---

## 💾 Dónde se Guardan los Datos

### Datos del Formulario
- **Ubicación**: localStorage del navegador
- **Dónde verlos**: 
  - Abre DevTools (F12)
  - Ve a "Application" o "Storage"
  - Busca "app_secure_inquiries"
  - Verás JSON con todas las consultas

- **Ejemplo**:
```json
[
  {
    "id": "1704067200000",
    "name": "Juan Pérez",
    "email": "juan@example.com",
    "phone": "+34 91 123 45 67",
    "message": "Interesado en seguridad perimetral",
    "createdAt": "2024-01-01T12:00:00.000Z"
  }
]
```

### Datos de Servicios
- **Ubicación**: Hardcodeados en el código
- **Archivo**: `client/src/data/staticData.ts`
- **No se modifican** sin recompilación

---

## 🔐 URLs Seguras

✅ **HTTPS**: `https://albertoaa78-gif.github.io/AppSecure/`
- GitHub Pages usa SSL automáticamente
- Todas las conexiones son seguras

❌ **HTTP**: `http://albertoaa78-gif.github.io/AppSecure/`
- No funcionará (GitHub obliga HTTPS)

---

## 📌 TL;DR (Resumen Ultra Corto)

**URL Principal**: 
```
https://albertoaa78-gif.github.io/AppSecure/
```

**Páginas**:
- Inicio: `/` (raíz)
- Servicios: `/#/services`
- Tecnología: `/#/technology`
- Contacto: `/#/contact`

**Todo funciona con hash routing** (`/#/`), es normal en GitHub Pages.

---

## ✨ Listo para Compartir

Cuando todo esté publicado, puedes compartir:
```
https://albertoaa78-gif.github.io/AppSecure/
```

Con confianza de que funciona perfectamente.

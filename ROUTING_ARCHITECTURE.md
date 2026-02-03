# 🗺️ ARQUITECTURA DE ROUTING - APPSECURE

## Hash-Based Routing en GitHub Pages

```
                    User Browser
                        ↓
    https://albertoaa78-gif.github.io/AppSecure/#/
                        ↓
            GitHub Pages (Static Hosting)
                   /docs/ folder
                        ↓
    ┌─────────────────────────────────────┐
    │         index.html served           │
    │                                     │
    │  • Carga CSS (71.58 KB)            │
    │  • Carga JS (952.68 KB)            │
    │  • Inicia React App                │
    │  • Router lee el hash (#)          │
    └─────────────────────────────────────┘
                        ↓
    ┌──────────────────────────────────────┐
    │       Wouter Router (Base: /#/)     │
    │                                      │
    │  Lee la URL después del #:          │
    │  • /#/              → /             │
    │  • /#/services      → /services     │
    │  • /#/technology    → /technology   │
    │  • /#/contact       → /contact      │
    │  • /#/xxx (404)     → /             │
    └──────────────────────────────────────┘
                        ↓
    ┌──────────────────────────────────────┐
    │    React Component Rendering        │
    │                                      │
    │  Home.tsx       → Hero + Features   │
    │  Services.tsx   → 3 Services Cards  │
    │  Technology.tsx → Tech Stack        │
    │  Contact.tsx    → Formulario        │
    │  not-found.tsx  → 404 Page          │
    └──────────────────────────────────────┘
                        ↓
              HTML rendered to user
```

---

## URL Mapping

| Browser URL | Route | Component | Page |
|---|---|---|---|
| `/AppSecure/#/` | `/` | `Home` | Página de inicio |
| `/AppSecure/#/services` | `/services` | `Services` | Servicios |
| `/AppSecure/#/technology` | `/technology` | `Technology` | Tecnología |
| `/AppSecure/#/contact` | `/contact` | `Contact` | Contacto |
| `/AppSecure/#/xyz` | (404) | `NotFound` | Página no encontrada |
| `/AppSecure/anything` | 404.html served | Redirect SPA | Redirige a home |

---

## SPA Fallback (404.html)

Cuando GitHub Pages no encuentra un archivo:

```
/AppSecure/some-path/file
        ↓
  (File not found)
        ↓
GitHub Pages serves: 404.html
        ↓
404.html:
  • Guarda la URL original en sessionStorage
  • Redirige a /AppSecure/
  • El hash se preserva en la redirección
        ↓
index.html carga
        ↓
React Router lee el hash
        ↓
Página correcta renderizada
```

---

## Flujo de Navegación

### Desde Home a Services:

```
User clicks "Experiencia" link
        ↓
Link href="/#/services"
        ↓
URL cambia a: /AppSecure/#/services
        ↓
Wouter Router detecta cambio
        ↓
<Route path="/services" component={Services} />
        ↓
Services.tsx renderiza
        ↓
User ve la página de servicios (sin reload ✅)
```

### Tipeo directo en la barra:

```
User types: /AppSecure/#/contact
        ↓
GitHub Pages
        ↓
request: /AppSecure/
        ↓
return: /AppSecure/index.html
        ↓
React carga y lee hash: /#/contact
        ↓
Wouter encuentra <Route path="/contact" />
        ↓
Contact.tsx renderiza
        ↓
Formulario visible
```

---

## Estado de Datos

```
┌─────────────────────────────────────────┐
│         Application State               │
├─────────────────────────────────────────┤
│                                         │
│  STATIC (Embedded in JS):              │
│  • Navigation Links                    │
│  • Services List (3 items)            │
│  • Technology Features                 │
│  • Form Schema (Zod)                   │
│                                         │
│  DYNAMIC (Runtime):                    │
│  • Form state (react-hook-form)       │
│  • Navigation scroll detection         │
│  • Mobile menu toggle                  │
│                                         │
│  PERSISTENT (localStorage):            │
│  • Contact Inquiries                   │
│    Key: "inquiries"                    │
│    Format: JSON array                  │
│                                         │
└─────────────────────────────────────────┘
```

---

## Performance Optimizations

### Build Time
```
Vite build: 9.6 seconds
  • ES6+ transpiled
  • CSS minified
  • Tree-shaking enabled
  • Code splitting optimized
```

### Runtime Performance
```
Page Load:
  1. DNS: ~50ms
  2. TCP: ~50ms
  3. TLS: ~100ms
  4. HTML download: ~20ms (2.11 KB)
  5. CSS download: ~100ms (11.75 KB gzip)
  6. JS download: ~500ms (270.07 KB gzip)
  7. React render: ~100ms
  8. TTI: ~1-2 seconds total

Subsequent navigation:
  • Same JS loaded already
  • Just DOM swaps
  • ~50-100ms per route
  • No full page reload
```

---

## Browser Compatibility

✅ **Supported**:
- Chrome/Edge 90+
- Firefox 88+
- Safari 14+
- Mobile browsers (iOS Safari, Chrome Mobile)

✅ **Features Used**:
- ES2020+ (transpiled by Vite)
- localStorage API
- CSS Grid + Flexbox
- CSS Custom Properties
- Fetch API (for form submission sim)

---

## Error Handling

```
Invalid Route
    ↓
Wouter no encuentra match
    ↓
<Route component={NotFound} />
    ↓
not-found.tsx renderiza
    ↓
Usuario ve 404 page
    ↓
Link back to home disponible
```

```
Form Submission Error
    ↓
Zod validation falla
    ↓
react-hook-form muestra error
    ↓
Toast notification rojo
    ↓
Usuario puede corregir y reintentar
```

---

## Security Considerations

✅ **No backend** = No SQL injection
✅ **localStorage only** = No server storage needed
✅ **Zod validation** = Client-side input validation
✅ **No hardcoded credentials** = Public SPA safe
✅ **CSP compatible** = Can add headers later
✅ **No API calls** = No CORS issues

---

## Deployment Architecture

```
┌──────────────────────────┐
│   GitHub Repository      │
│   albertoaa78-gif/       │
│   AppSecure              │
│                          │
│  main branch:           │
│  ├── src/               │
│  ├── client/            │
│  ├── public/            │
│  ├── docs/    ← DEPLOY  │
│  │ ├── index.html       │
│  │ ├── 404.html        │
│  │ ├── .nojekyll       │
│  │ └── assets/         │
│  ├── package.json       │
│  └── vite.config.ts     │
└──────────────────────────┘
         ↓
    GitHub Pages
    Build & Deploy
         ↓
┌──────────────────────────┐
│  LIVE: GitHub Pages      │
│  URL: ...github.io/      │
│        AppSecure/#/      │
└──────────────────────────┘
```

---

## URL Rewriting Rules

GitHub Pages automatically handles:

```
Request:  /AppSecure/
  → Serves: docs/index.html ✅

Request:  /AppSecure/services
  → Tries: docs/services (not found)
  → Falls back to: docs/404.html
  → 404.html redirects to /AppSecure/ ✅
  → React Router sees hash: /#/services ✅

Request:  /AppSecure/#/contact
  → Serves: docs/index.html ✅
  → React reads hash: /#/contact ✅
```

---

## Testing the Routes

```bash
# After GitHub Pages is configured:

# Test home page
curl -I https://albertoaa78-gif.github.io/AppSecure/#/
# Should get 200 OK with HTML

# Test direct route
curl -I https://albertoaa78-gif.github.io/AppSecure/#/services
# Should get 200 OK (SPA handles routing)

# Test invalid route
curl -I https://albertoaa78-gif.github.io/AppSecure/invalid
# Should redirect to 404.html → index.html
```

---

## Summary

- ✅ Hash-based routing for GitHub Pages compatibility
- ✅ SPA pattern with Wouter router
- ✅ Static assets in `/docs/` directory
- ✅ 404.html fallback for all unknown routes
- ✅ No backend dependencies required
- ✅ localStorage for persistent data
- ✅ Performance optimized with Vite
- ✅ Ready for production deployment

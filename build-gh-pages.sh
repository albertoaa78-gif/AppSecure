#!/bin/bash
set -e
cd /workspaces/AppSecure

# Step 1: Build with GitHub Pages base URL
export VITE_BASE=/AppSecure/
npm run build

# Step 2: Create docs directory
rm -rf docs
mkdir -p docs

# Step 3: Copy compiled files
cp -r dist/* docs/

# Step 4: Create .nojekyll file
touch docs/.nojekyll

# Step 5: Create 404.html for SPA routing
cat > docs/404.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Redirecting...</title>
    <script>
        // Redirigir 404s a index.html para que Wouter maneje las rutas
        const path = window.location.pathname.replace('/AppSecure', '');
        window.location = '/AppSecure/index.html#' + path;
    </script>
</head>
<body>
    <p>Redirecting...</p>
</body>
</html>
EOF

echo "✅ Build completo"

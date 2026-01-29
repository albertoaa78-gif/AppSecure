#!/bin/bash
# Regenerar docs/ con 404.html y .nojekyll

cd /workspaces/AppSecure

# Crear 404.html
mkdir -p docs
cat > docs/404.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <script>
        window.location = '/AppSecure/index.html#' + window.location.pathname.replace(/^\/AppSecure/, '');
    </script>
</head>
</html>
EOF

echo "✅ 404.html creado"

# Crear .nojekyll si no existe
touch docs/.nojekyll
echo "✅ .nojekyll verificado"

# Listar contenido
echo ""
echo "📁 Contenido de docs/:"
ls -la docs/ | grep -v "^total" | awk '{print "  " $NF}'

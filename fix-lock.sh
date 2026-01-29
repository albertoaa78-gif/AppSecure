#!/bin/bash
# Fix package-lock.json sync issues

cd /workspaces/AppSecure

# 1. Update package-lock.json to match package.json
echo "Updating package-lock.json..."
rm -f package-lock.json

# 2. Regenerate lock file
npm install --package-lock-only --legacy-peer-deps 2>&1 | tail -5

echo "✅ package-lock.json regenerated"
echo ""
echo "Next steps:"
echo "  git add package-lock.json"
echo "  git commit -m 'fix: regenerate package-lock.json to match package.json'"
echo "  git push origin main"

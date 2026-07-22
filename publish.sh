#!/bin/bash
# Publishes The Host Standard website: commits and pushes index.html directly.
# Usage:  ./publish.sh "what changed"
#   (the message is optional — it'll use a default with today's date if you skip it)

set -e
cd "$(dirname "$0")"

# Clear any stale git lock files before starting (harmless if none exist)
rm -f .git/index.lock .git/HEAD.lock 2>/dev/null || true

git add -A

if git diff --cached --quiet; then
  echo "Nothing changed — nothing to publish."
  exit 0
fi

MSG="${1:-Update site $(date +%Y-%m-%d)}"
git commit -m "$MSG"
git push

echo ""
echo "Published. Vercel will redeploy automatically in a minute or two."

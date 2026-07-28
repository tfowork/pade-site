#!/bin/bash
set -e

SCOPE="allagesshows-projects"

echo "Deploying to production..."
OUTPUT=$(vercel deploy --prod --scope "$SCOPE" 2>&1 | tee /dev/stderr)

DEPLOY_URL=$(echo "$OUTPUT" | grep -Eo 'https://pade-site-[a-zA-Z0-9]+-allagesshows-projects\.vercel\.app' | tail -1)

if [ -z "$DEPLOY_URL" ]; then
  echo "" >&2
  echo "✗ Could not parse the deployment URL from Vercel's output — skipping alias step." >&2
  echo "  Run manually: vercel alias set <deployment-url> trypade.com --scope $SCOPE" >&2
  exit 1
fi

echo ""
echo "Aliasing trypade.com and trypade.app -> $DEPLOY_URL"
vercel alias set "$DEPLOY_URL" trypade.com --scope "$SCOPE"
vercel alias set "$DEPLOY_URL" trypade.app --scope "$SCOPE"

echo ""
echo "✓ Live at https://trypade.com"

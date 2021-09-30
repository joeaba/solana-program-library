#!/usr/bin/env bash

set -ex

if [[ -d .vercel ]]; then
  rm -r .vercel
fi

CONFIG_FILE=vercel.json
PROJECT_NAME=spl-solana-com

PRODUCTION=
if [[ -n "$CI" ]]; then
  PRODUCTION=--prod
fi

cat > "$CONFIG_FILE" <<EOF
{
  "name": "$PROJECT_NAME",
  "scope": "singhritesh750"
}
EOF

touch .env.production
echo VERCEL_TOKEN = "$VERCEL_TOKEN" > .env.production

# VERCEL_TOKEN="4V4RI2LA8Y1ZrUaS2Q9tDMD3"

[[ -n $VERCEL_TOKEN ]] || {
  echo "VERCEL_TOKEN is undefined.  Needed for Vercel authentication."
  exit 1
}
vercel deploy . --local-config="$CONFIG_FILE" --confirm --token "$VERCEL_TOKEN" "$PRODUCTION"

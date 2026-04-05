#!/usr/bin/env bash
# Concatenate all governance documents into a single Markdown file,
# then produce one standalone HTML (for PDF conversion) with internal links.
set -euo pipefail

DIST="dist"
mkdir -p "$DIST"

# Document order — grouped by section
DOCS=(
  # Project Governance
  "project-governance/definitions.md"
  "project-governance/project-types.md"
  "project-governance/lifecycle.md"
  "project-governance/project-vetting-criteria.md"
  "project-governance/committees.md"
  # AI Governance
  "ai-governance/ai-vetting-criteria.md"
  "ai-governance/fragmented-catholic-ai-governance.md"
  "ai-governance/governance-as-code-catholic-ai.md"
  "ai-governance/trusted-synthetic-data-ministry-ai.md"
  # Standards
  "standards/overview.md"
  "standards/committees.md"
)

COMBINED="$DIST/combined.md"
: > "$COMBINED"

FIRST=true
for DOC in "${DOCS[@]}"; do
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    # Page break between documents
    printf '\n\n<div class="doc-separator"></div>\n\n' >> "$COMBINED"
  fi
  cat "$DOC" >> "$COMBINED"
done

echo "Building combined standalone HTML..."
LINK_MODE=combined pandoc "$COMBINED" \
  --standalone --embed-resources \
  --lua-filter=scripts/fix-internal-links.lua \
  --css scripts/docs-print.css \
  --wrap=none \
  -f markdown -t html5 \
  -o "$DIST/cdcf-governance-docs-standalone.html"

echo "Building combined PDF..."
pagedjs-cli --browserArgs='--no-sandbox' \
  "$DIST/cdcf-governance-docs-standalone.html" \
  -o "$DIST/cdcf-governance-docs.pdf"

rm -f "$COMBINED"
echo "Done: $DIST/cdcf-governance-docs.pdf"

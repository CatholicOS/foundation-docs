#!/usr/bin/env bash
# Concatenate all governance documents into a single Markdown file,
# then produce one standalone HTML (for PDF conversion) with internal links.
set -euo pipefail

DIST="dist"
mkdir -p "$DIST"

# Document order — matches the frontend navigation
DOCS=(
  # Project Governance
  "project-governance/project-vetting-criteria.md"
  "project-governance/lifecycle.md"
  "project-governance/committees.md"
  "project-governance/project-types.md"
  "project-governance/definitions.md"
  # Research
  "research/fragmented-catholic-digital-governance.md"
  "research/governance-as-code-catholic-technology.md"
  "research/trusted-data-infrastructure-catholic-ministry.md"
  "research/identifier-durability-opaque-canonical-iris.md"
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
  # Namespace footnotes to avoid collisions between documents.
  # Derives a prefix from the full path (e.g. "project-governance/committees" → "pgc")
  # by taking the first letter of each hyphenated segment.
  DOC_KEY="${DOC%.md}"
  PREFIX=$(echo "$DOC_KEY" | tr '/' '-' | sed 's/\([a-z]\)[a-z]*/\1/g; s/-//g')
  sed "s/\[\^\([^]]*\)\]/[^${PREFIX}-\1]/g" "$DOC" >> "$COMBINED"
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

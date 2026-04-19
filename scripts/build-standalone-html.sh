#!/usr/bin/env bash
# Build individual standalone HTML files for each governance document,
# with navigation links between them.
set -euo pipefail

DIST="dist"
mkdir -p "$DIST"

# All documents: source_path|slug|title — matches the frontend navigation
DOCS=(
  "project-governance/project-vetting-criteria.md|project-vetting-criteria|CDCF Project Vetting Criteria"
  "project-governance/lifecycle.md|lifecycle|CDCF Project Lifecycle"
  "project-governance/committees.md|committees|CDCF Governance Bodies"
  "project-governance/project-types.md|project-types|CDCF Project Types"
  "project-governance/definitions.md|definitions|CDCF Governance Definitions"
  "research/fragmented-catholic-digital-governance.md|fragmented-catholic-digital-governance|Fragmented Catholic Digital Governance"
  "research/governance-as-code-catholic-technology.md|governance-as-code-catholic-technology|Governance-as-Code for Catholic Technology"
  "research/trusted-data-infrastructure-catholic-ministry.md|trusted-data-infrastructure-catholic-ministry|Trusted Data Infrastructure for Catholic Ministry"
  "standards/overview.md|standards-overview|CDCF Standards Overview"
  "standards/committees.md|standards-committees|CDCF Standards Committees"
)

# Build navigation HTML
NAV='<nav class="doc-nav"><strong>CDCF Governance Documents</strong><ul>'
NAV+='<li><strong>Project Governance</strong><ul>'
for entry in "${DOCS[@]}"; do
  IFS='|' read -r src slug title <<< "$entry"
  case "$src" in
    project-governance/*) NAV+="<li><a href=\"${slug}.html\">${title}</a></li>" ;;
  esac
done
NAV+='</ul></li>'
NAV+='<li><strong>Research</strong><ul>'
for entry in "${DOCS[@]}"; do
  IFS='|' read -r src slug title <<< "$entry"
  case "$src" in
    research/*) NAV+="<li><a href=\"${slug}.html\">${title}</a></li>" ;;
  esac
done
NAV+='</ul></li>'
NAV+='<li><strong>Standards</strong><ul>'
for entry in "${DOCS[@]}"; do
  IFS='|' read -r src slug title <<< "$entry"
  case "$src" in
    standards/*) NAV+="<li><a href=\"${slug}.html\">${title}</a></li>" ;;
  esac
done
NAV+='</ul></li></ul></nav><hr>'

for entry in "${DOCS[@]}"; do
  IFS='|' read -r src slug title <<< "$entry"
  echo "Building ${slug}.html..."

  # Prepend navigation, then the document content
  TEMP="$DIST/${slug}-temp.md"
  echo "$NAV" > "$TEMP"
  cat "$src" >> "$TEMP"

  LINK_MODE=html pandoc "$TEMP" \
    --standalone --embed-resources \
    --lua-filter=scripts/fix-internal-links.lua \
    --css scripts/docs-print.css \
    --metadata "title=${title}" \
    --wrap=none \
    -f markdown -t html5 \
    -o "$DIST/${slug}.html"

  rm -f "$TEMP"
done

echo "Done: standalone HTML files in $DIST/"

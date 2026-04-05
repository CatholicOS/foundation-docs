-- Pandoc Lua filter: rewrite internal .md links for the production website.
-- Strips directory prefixes and .md extensions so that
--   ./project-vetting-criteria.md  →  /project-vetting-criteria
--   ../project-governance/file.md  →  /file
--   ../standards/overview.md       →  /standards-overview
-- The standards/ prefix is kept to match the WordPress slug convention.

function Link(el)
  local target = el.target

  -- Only process relative .md links (skip external URLs and anchors)
  if not target:match('%.md') or target:match('^https?://') then
    return el
  end

  -- Remove leading ./ or ../dir/ to get the bare filename
  local dir, base = target:match('^%.%./(.-)/(.+)$')
  if not dir then
    base = target:match('^%.?/?(.+)$')
    dir = nil
  end

  -- Strip .md extension (preserve any #anchor)
  base = base:gsub('%.md', '')

  -- Prefix standards docs to match WordPress slugs (standards-overview, standards-committees)
  if dir == 'standards' then
    base = 'standards-' .. base
  end

  el.target = '/' .. base
  return el
end

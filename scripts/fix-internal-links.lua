-- Pandoc Lua filter: rewrite internal .md links for different output targets.
--
-- Set the LINK_MODE environment variable (or pandoc metadata) to control behavior:
--   "website"    (default) → /slug           (absolute paths for WordPress)
--   "html"                 → slug.html       (relative paths for standalone HTML files)
--   "combined"             → #heading-anchor (fragment links within the combined PDF)
--
-- All modes:
--   - Only rewrite relative .md links (external URLs are untouched)
--   - Standards docs get a "standards-" prefix to avoid slug collisions

local mode = os.getenv("LINK_MODE") or "website"

-- Read mode from pandoc metadata as fallback
function Meta(meta)
  if meta["link-mode"] then
    mode = pandoc.utils.stringify(meta["link-mode"])
  end
end

function Link(el)
  local target = el.target

  -- Only process relative .md links (skip external URLs and anchors)
  if not target:match('%.md') or target:match('^https?://') then
    return el
  end

  -- Separate any #anchor from the path
  local path, anchor = target:match('^(.-)(%#.*)$')
  if not path then
    path = target
    anchor = ''
  end

  -- Remove leading ./ or ../dir/ to get dir and bare filename
  local dir, base = path:match('^%.%./(.-)/(.+)$')
  if not dir then
    base = path:match('^%.?/?(.+)$')
    dir = nil
  end

  -- Strip .md extension
  base = base:gsub('%.md$', '')

  -- Prefix standards docs to avoid slug collisions
  if dir == 'standards' then
    base = 'standards-' .. base
  end

  if mode == 'html' then
    el.target = base .. '.html' .. anchor
  elseif mode == 'combined' then
    -- In the combined document, headings become anchors automatically.
    -- Link to the document's H1 heading anchor (pandoc auto-generates from title).
    if anchor ~= '' then
      el.target = anchor
    else
      el.target = '#' .. base
    end
  else
    -- website mode (default)
    el.target = '/' .. base .. anchor
  end

  return el
end

return { { Meta = Meta }, { Link = Link } }

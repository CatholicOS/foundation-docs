# Releasing

This document describes how governance documents are built, deployed, and released.

## Overview

The release pipeline is driven by the GitHub Actions workflow
`.github/workflows/deploy-docs.yml`. It triggers on:

- **Tag push** matching `v*` (e.g. `v0.2`) -- deploys only documents changed
  since the previous tag.
- **Manual dispatch** (`workflow_dispatch`) -- deploys all documents.

A single workflow run performs four stages in order:

1. Deploy changed documents to WordPress
2. Translate deployed pages
3. Build standalone HTML and combined PDF artifacts
4. Create (or update) a GitHub release with those artifacts

## Prerequisites

The following repository secrets and variables must be configured in GitHub:

| Name                | Type     | Purpose                                          |
| :------------------ | :------- | :----------------------------------------------- |
| `WP_REST_URL`       | Variable | Base URL of the WordPress REST API               |
| `WP_APP_USERNAME`   | Secret   | WordPress application password username          |
| `WP_APP_PASSWORD`   | Secret   | WordPress application password                   |

The WordPress site must also expose a custom REST endpoint
(`cdcf/v1/translate`) that accepts a `source_id` and `target_lang` for the
translation step.

## How to release

### 1. Prepare the branch

Ensure all changes are merged to `main` and that quality checks pass:

```bash
npm run lint:md        # 0 errors expected
npm run build:html     # standalone HTML files in dist/
npm run build:pdf      # combined PDF in dist/
```

### 2. Tag and push

```bash
git tag v0.X
git push origin v0.X
```

This triggers the deploy workflow automatically.

Alternatively, run the workflow manually from the GitHub Actions tab
(**Run workflow** on the `main` branch). Manual runs deploy all documents and
auto-increment the version tag.

### 3. What the workflow does

#### Stage 1 -- WordPress deployment

- Compares the tagged commit against the previous tag to determine which
  `.md` files changed.
- Converts each changed document from Markdown to HTML using `pandoc` with
  the Lua filter `scripts/fix-internal-links.lua` (which rewrites internal
  `.md` links for the target output format).
- Creates or updates the corresponding WordPress page via the REST API,
  organized under parent pages (`project-governance`, `research`, `standards`).

#### Stage 2 -- Translation

- Each newly deployed page is translated into **it**, **es**, **fr**, **pt**,
  and **de** via the `cdcf/v1/translate` endpoint.

#### Stage 3 -- Build artifacts

- `npm run build:html` (`scripts/build-standalone-html.sh`) -- produces one
  self-contained HTML file per document in `dist/`, each with a navigation
  sidebar linking to the other documents.
- `npm run build:pdf` (`scripts/build-combined-pdf.sh`) -- concatenates all
  documents into a single Markdown file, converts to standalone HTML, then
  renders a paginated PDF using `pagedjs-cli`.

Both scripts use `scripts/docs-print.css` for styling and
`scripts/fix-internal-links.lua` for link rewriting.

#### Stage 4 -- GitHub release

- Creates a GitHub release titled **Governance Docs vX.Y** with all
  `dist/*.html` and `dist/*.pdf` files attached.
- If the release already exists (e.g. re-run), assets are uploaded with
  `--clobber`.

## Local builds

You can build artifacts locally without deploying:

```bash
npm install            # first time only
npm run build:html     # dist/*.html
npm run build:pdf      # dist/cdcf-governance-docs.pdf (requires pagedjs-cli)
```

The PDF build requires Google Chrome or Chromium installed locally
(`pagedjs-cli` uses it for rendering). Set `PUPPETEER_EXECUTABLE_PATH` if
the binary is not in the default location.

## Document inventory

The following documents are included in builds and deployments:

| Section            | File                                             |
| :----------------- | :----------------------------------------------- |
| Project Governance | `project-governance/project-vetting-criteria.md` |
| Project Governance | `project-governance/lifecycle.md`                |
| Project Governance | `project-governance/committees.md`               |
| Project Governance | `project-governance/project-types.md`            |
| Project Governance | `project-governance/definitions.md`              |
| Research           | `research/fragmented-catholic-digital-governance.md` |
| Research           | `research/governance-as-code-catholic-technology.md` |
| Research           | `research/trusted-data-infrastructure-catholic-ministry.md` |
| Standards          | `standards/overview.md`                          |
| Standards          | `standards/committees.md`                        |

To add a new document, update the `DOCS` array in all three places:

1. `.github/workflows/deploy-docs.yml` (lines 27-38 and 87-98)
2. `scripts/build-standalone-html.sh` (lines 10-21)
3. `scripts/build-combined-pdf.sh` (lines 12-24)

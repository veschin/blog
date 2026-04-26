---
id: scope
kind: spec
---

# Scope

## What this is

Personal blog on Hugo + PaperMod. Content in org-mode format. Two language versions: Russian (default), English. Deployed as a Docker container behind a reverse proxy on VPS.

## In scope

- Posts in `content/posts/` (org-mode, `.ru.org` / `.en.org`)
- Hugo configuration (`hugo.toml`)
- Theme overrides via `layouts/`, `assets/` (never edit `themes/PaperMod/`)
- Static assets in `static/`
- Docker build and deployment
- Writing style - declarative, impersonal (skill `common-writing`)

## Out of scope

- Direct PaperMod theme edits (submodule, updated as a whole)
- Backend logic, databases, dynamic APIs
- CI/CD pipeline (none exists, deployment is manual)
- SEO optimization, analytics (not configured)

## Current state

- Hugo v0.145.0 (latest: v0.160.1, upgrade needed)
- 1 published post (ClojureScript + FigWheel + Reagent, ru + en)
- 1 draft without proper frontmatter (base.ru.org - IT course outline)
- PaperMod theme: submodule, no customizations in `layouts/` or `assets/`

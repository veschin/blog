---
id: handoff
kind: guide
---

# Handoff: next session action plan

Last updated: 2026-04-26, after SEO infrastructure setup.

## Current state

Hugo blog on PaperMod. One published post (ClojureScript, ru + en) with date, summary, and tags. SEO fully configured: OpenGraph, Twitter Cards, Schema.org JSON-LD, robots.txt, sitemap with hreflang. Hugo v0.145.0. Org archetype created for new posts. Demo post `org-demo.ru.org` (draft) serves as org-mode syntax reference.

## What does NOT exist yet

- Hugo not upgraded to latest (v0.145 -> v0.160)
- KaTeX/MathJax not configured (LaTeX in org renders as raw text)
- No favicon files in `static/` (config references them, 404 on requests, broken Schema.org Person image)
- No custom layouts - PaperMod used as-is
- Draft `base.ru.org` has no org frontmatter
- No about page, no archives, no search
- No CSS for checkbox styling (`.checked`/`.unchecked` classes unstyled)
- Inline `#+ATTR_HTML: :style` broken (go-org double-escapes quotes)

## Immediate next steps

1. **Generate favicon** - create and place `favicon.ico`, `favicon-16x16.png`, `favicon-32x32.png`, `apple-touch-icon.png` in `static/`. Currently 404s and breaks Schema.org Person image. ~10 min.
2. **Upgrade Hugo** - `brew upgrade hugo` (v0.145 -> v0.160). Improves go-org parser. ~5 min.
3. **Add KaTeX** - create layout override for head partial, load KaTeX CSS/JS. Enables math rendering in org posts. ~20 min.

## Read before starting

1. `docs/llm/handoff.md` (this file)
2. `docs/llm/20_content.md` - org-mode capabilities and verified limitations
3. `docs/llm/10_scope.md` - project boundaries
4. `CLAUDE.md` - Claude Code instructions

## Anti-patterns

1. Never edit `themes/PaperMod/` - submodule, changes lost on update
2. `#+DESCRIPTION:` does NOT work in go-org. Use `#+SUMMARY:` for meta description.
3. `#+cover:` does NOT map to PaperMod's `.Params.cover.image` (nested key). Use page bundles or `params.images` site-level fallback.
4. `#+ATTR_HTML: :style "..."` - inline styles with quotes are double-escaped by go-org. Use `:class` with custom CSS instead.
5. Don't set `params.env = "production"` in hugo.toml - `hugo.IsProduction` handles this automatically (true for `hugo build`, false for `hugo server`).

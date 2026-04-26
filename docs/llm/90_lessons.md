---
id: lessons
kind: lesson
---

# Lessons

## Org-mode frontmatter: not all keys map to Hugo fields

go-org only maps a whitelist of `#+KEY` directives to Hugo page variables. `#+DESCRIPTION` does NOT populate `.Description` or `.Params.description`. Verified 2026-04-26: meta description was empty despite `#+DESCRIPTION:` being set.

### Root causes

1. go-org has a hardcoded list of recognized keywords: title, author, date, draft, tags, weight, slug, summary, and a few others. `description` is not among them.
2. Hugo's `.Description` page variable is distinct from `.Summary` - go-org populates neither from `#+DESCRIPTION`.

### Rules

1. Use `#+SUMMARY:` for post descriptions. It maps to `.Summary`, which PaperMod uses as the fallback for meta description, OpenGraph, and Twitter Cards.
2. Never use `#+DESCRIPTION:` - it produces no output. Silent failure.

## Nested frontmatter keys don't work in org-mode

PaperMod expects `cover.image` (nested YAML key) for cover images. Org-mode has no syntax for nested frontmatter - `#+cover:` maps to a flat `.Params.cover` string, not `.Params.cover.image`.

### Root causes

1. Org `#+KEY: value` maps to flat key-value pairs only. No nesting support in go-org.

### Rules

1. For cover images, use page bundles (directory with `index.org` + image files) or set `params.images` as site-level fallback.
2. Never use `#+cover:` in org frontmatter - it's dead code.

## ATTR_HTML inline styles break with quotes

`#+ATTR_HTML: :style "border: 2px solid red"` produces double-escaped quotes in output (`&#34;`), making the style non-functional.

### Root causes

1. go-org bug: style attribute values containing quotes are HTML-entity-escaped twice.

### Rules

1. Use `#+ATTR_HTML: :class my-class` with a custom CSS class instead of inline `:style`.

---
id: content
kind: spec
touches: content/posts/, hugo.toml
---

# Domain: content

## Format

All posts are org-mode (`.org`). Markdown is not used.

## File naming

`<slug>.<lang>.org` - Hugo links language versions by slug. Example: `clojurescript.ru.org` + `clojurescript.en.org`.

## Frontmatter (org-style)

```org
#+title: Title
#+author: Oleg Veschin
#+date: 2025-01-01
#+draft: false
#+summary: One-line description for meta tags and social sharing
#+tags[]: tag1 tag2
#+weight: 10
```

Required: `title`, `draft`. Date in ISO 8601. Tags are repeatable (`#+TAGS[]: value` per line).

**Critical:** use `#+SUMMARY:` for post description (meta description, OpenGraph, Twitter Cards). `#+DESCRIPTION:` does NOT work - go-org does not map it to Hugo's `.Description` or `.Params.description`.

Archetype at `archetypes/posts.org` - used by `hugo new posts/<slug>.org`.

## Org-mode capabilities in Hugo

Renderer: go-org (v1.7.0 in Hugo 0.145, v1.9.1 in Hugo 0.148+). All features below verified by rendering `content/posts/org-demo.ru.org` (draft, kept as reference).

### Inline markup - all verified working

| Syntax | Result | Notes |
|--------|--------|-------|
| `*bold*` | **bold** | |
| `/italic/` | *italic* | |
| `_underline_` | underline | |
| `+strikethrough+` | ~~strikethrough~~ | |
| `~verbatim~` | monospace, no highlighting | |
| `=code=` | monospace, styled as code | |
| `*/bold italic/*` | **bold + italic** | combinations work |
| `H_{2}O` | subscript | |
| `E = mc^{2}` | superscript | |
| `---` | em-dash (-) | |
| `--` | en-dash (-) | |
| `\dots` | ellipsis (...) | |

### Structure - all verified working

- **Headings**: arbitrary depth, rendered as `<h2>`-`<h6>`. IDs auto-generated as `headline-N`.
- **Unordered lists**: `-` or `+`, nested to 3+ levels. Different bullet styles per level.
- **Ordered lists**: `1.` syntax, nested. Correct numbering.
- **Description lists**: `- Term :: Definition` syntax. Renders as `<dt>`/`<dd>`. Works.
- **Checkboxes**: `- [X]` / `- [ ]` - HTML outputs `<li class="checked">` / `<li class="unchecked">`. Semantically correct, but PaperMod has no CSS for these classes - renders as plain bullets visually. Fix: add CSS for `.checked`/`.unchecked` in custom stylesheet.
- **Tables**: pipe syntax with header separator. Clean rendering. No column groups or formulas.
- **Horizontal rule**: `-----` renders as `<hr>`.

### Links - verified working

- `[[url][description]]` - external link with text
- `[[url]]` - bare URL displayed as-is
- `[[file:/image.png]]` - auto-renders as `<img>` (file served from `static/`)

### Blocks - all verified working

| Block | Syntax | Behavior |
|-------|--------|----------|
| Quote | `#+begin_quote` | PaperMod renders with left border. Looks good. |
| Code | `#+begin_src lang` | Syntax highlighting via Chroma, line numbers, dark theme (doom-one2). |
| Example | `#+begin_example` | Monospace, no highlighting. |
| Verse | `#+begin_verse` | Preserves line breaks. Good for poetry/epigraphs. |
| Center | `#+begin_center` | Centers text. |
| Export HTML | `#+begin_export html` | Raw HTML passthrough. Use for `<details>`, `<video>`, embeds, anything org can't express. |

### Code blocks - verified working

`#+begin_src <lang>` with Chroma highlighting. Verified languages: `clojure`, `bash`, `emacs-lisp`. Line numbers enabled globally via `hugo.toml` (`lineNos = true`). Inline code via `=expression=`.

### Footnotes - verified working

Three syntaxes, all produce correct HTML with bidirectional `<sup>` links:
- Named: `[fn:name]` with `[fn:name] Definition` at bottom
- Numbered: `[fn:1]` with `[fn:1] Definition`
- Inline: `[fn:: inline definition]`

### Images - verified working

```org
#+CAPTION: Caption text
[[file:/image.png]]
```

`#+CAPTION` renders as `<figure>` with `<figcaption>` below the image. Images served from `static/` at root path.

### TOC

`#+options: toc:t` or `#+TOC: headlines N` - rendered inline by go-org. Hugo's `.TableOfContents` template variable returns empty for org files - this is an architectural limitation.

### Exclusion

`:noexport:` tag on a heading excludes it and all children from output. Verified working.

### Macros

`#+MACRO: name replacement $1` with `{{{name(arg)}}}` expansion. Not stress-tested in this blog yet.

### SETUPFILE / INCLUDE

- `#+SETUPFILE: file` - shared options across posts (not yet used)
- `#+INCLUDE: "file" src lang` - include as code block (src/example/export modes only, no raw org inclusion)

### Inline export

`@@html:<tag>@@` - inject raw HTML inline. Use sparingly.

## What does NOT work

### LaTeX / math - broken without JS library

`\(inline\)`, `\[block\]`, `$$block$$` all output raw LaTeX text. go-org passes them through as-is - a JS math renderer (KaTeX or MathJax) must be loaded in the template. **Currently not configured.** Formulas display as literal source code.

### Hugo shortcodes

No `{{< shortcode >}}` syntax in org files. Workaround: `#+begin_export html` with the shortcode's raw HTML output, or the rendered HTML equivalent.

### Render hooks

Hugo's render hooks (link, image, codeblock) do not apply to org content. `Supports()` returns `false` for all features. No workaround - architectural limitation.

### ATTR_HTML - partially broken

`#+ATTR_HTML: :class foo` - class attribute applied correctly. However, `#+ATTR_HTML: :style "..."` - **inline style values containing quotes are double-escaped** (`&#34;` wrapping), rendering them non-functional. This is a go-org bug.

Workaround: use `:class` with a custom CSS class instead of inline `:style`.

### Checkboxes - visually broken

HTML is semantically correct (`<li class="checked">`), but PaperMod provides no CSS rules for `.checked` / `.unchecked` classes. Renders as plain bullets. Fix: add custom CSS.

### Cross-file links

`file:foo.org::#custom-id` links are not supported. Use plain HTML links for cross-post references.

### Code execution

No org-babel. Code blocks are rendered statically - no `:results` evaluation.

## Writing style

All Russian-language text: declarative, impersonal, factual. No reader address, no "we/I". Skill `common-writing` applies.

## Reference

Demo post with all features: `content/posts/org-demo.ru.org` (draft). Use as a syntax cheatsheet.

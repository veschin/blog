---
id: deploy
kind: spec
touches: Dockerfile, hugo.toml
---

# Domain: build and deployment

## Local development

```bash
hugo server -D                      # dev server :1313, drafts enabled
hugo server -D --navigateToChanged  # + auto-navigate to changed page
```

Hugo installed via Linuxbrew: `/home/linuxbrew/.linuxbrew/bin/hugo`.

## Production build

```bash
hugo --minify
```

Output - static files in `public/`.

## Docker

Multi-stage: `hugomods/hugo:latest` (build) -> `nginx:1.25-alpine` (serve).

```bash
docker build --build-arg DOMAIN=https://veschin.com -t blog .
docker run -p 80:80 blog
```

ARG `DOMAIN` sets `baseURL`. Pass full URL with protocol. Container listens on port 80, forwarded through reverse proxy on VPS.

## PaperMod theme

Attached as git submodule. After cloning:

```bash
git submodule update --init --recursive
```

Overrides - via `layouts/` and `assets/` in project root. Files in `themes/PaperMod/` are never edited.

## Highlight configuration

```toml
[markup.highlight]
codeFences = true
guessSyntax = true
lineNos = true
style = "doom-one2"
```

`doom-one2` - dark code highlighting scheme (Chroma).

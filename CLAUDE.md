# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Проект

Hugo-блог с темой PaperMod. Мультиязычный: русский (по умолчанию) + английский. Контент - org-mode файлы в `content/posts/`, именуются `<slug>.<lang>.org`.

## Сборка и запуск

```bash
# Локальная разработка
hugo server -D    # dev-сервер на :1313, -D включает черновики

# Продакшен-сборка
hugo --minify

# Docker (деплой на VPS за reverse proxy)
docker build --build-arg DOMAIN=https://veschin.com -t blog .
docker run -p 80:80 blog
```

Hugo установлен через Linuxbrew: `/home/linuxbrew/.linuxbrew/bin/hugo` (v0.145.0+extended).

## Тема

PaperMod подключена как git-субмодуль. После клонирования:

```bash
git submodule update --init --recursive
```

Не редактировать файлы в `themes/PaperMod/` - переопределять через `layouts/` и `assets/` в корне проекта.

## Docker-деплой

Dockerfile: multi-stage (hugomods/hugo -> nginx:1.25-alpine). ARG `DOMAIN` задаёт baseURL - передавать полный URL с протоколом (`https://veschin.com`). Контейнер слушает порт 80 (nginx), пробрасывать через reverse proxy.

## Контент

Формат: org-mode (не Markdown). Frontmatter в org-стиле:

```org
#+title: Заголовок
#+author: Олег Вещин
#+date: 2025-01-01
#+draft: false
#+tags[]: tag1 tag2
```

Для мультиязычности: `<slug>.ru.org` + `<slug>.en.org` - Hugo связывает по имени файла.

## Документация проекта

Подробные спецификации - в `docs/llm/`. Читать `handoff.md` первым - план действий для текущей сессии. Доменные спеки: `20_content.md` (org-mode, стиль), `30_deploy.md` (сборка, Docker).

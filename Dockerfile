# Dockerfile для сборки Hugo-сайта с многоэтапной сборкой
# Используем официальный образ Hugo для этапа сборки
FROM klakegg/hugo:0.120.4-alpine AS builder

# Копируем весь проект Hugo в контейнер
COPY . /src

export HUGO_ENV=production
export HUGO_BASEURL=https://your-domain.com
# Запускаем сборку сайта с минификацией
RUN hugo --minify --source /src

# Финальный образ на базе Nginx для обслуживания статики
FROM nginx:1.25-alpine

# Удаляем дефолтные файлы Nginx
RUN rm -rf /usr/share/nginx/html/*

# Копируем собранные файлы из этапа builder
COPY --from=builder /src/public /usr/share/nginx/html

# Копируем кастомную конфигурацию Nginx (если нужно)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Открываем порт 80
EXPOSE 80


# Команда для запуска Nginx
CMD ["nginx", "-g", "daemon off;"]

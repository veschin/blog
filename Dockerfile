FROM hugomods/hugo:latest AS builder

ARG DOMAIN=veschin.com
ENV HUGO_BASEURL=http://${DOMAIN}

COPY . /src

# Добавляем флаг --baseURL с переданным доменом
RUN hugo --minify --baseURL ${HUGO_BASEURL} --source /src

FROM nginx:1.25-alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /src/public /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

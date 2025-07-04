FROM nginx:stable-alpine

WORKDIR /usr/share/nginx/html

COPY ./webapp .

EXPOSE 80



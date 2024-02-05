# Build React Application

FROM node:21-slim as builder

WORKDIR /app

COPY package.json .

RUN npm i 

COPY . .

RUN npm run build

# Serve using nginx

FROM docker.io/nginx:1.25.1-alpine-slim as ui_server

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=builder /app/dist .

COPY nginx.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
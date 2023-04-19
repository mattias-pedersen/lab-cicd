FROM node:18.12-alpine3.17 as build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY tsconfig.json ./
COPY public ./public
COPY src ./src

RUN npm run build

FROM nginx:1.23.3-alpine

EXPOSE 80

COPY --from=build /app/build /usr/share/nginx/html
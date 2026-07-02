FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

# 👇关键修复
RUN npm install --legacy-peer-deps

COPY . .

RUN npm run build


FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
#1
FROM node:14 AS build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

#2
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8082
CMD ["nginx", "-g", "daemon off;"]

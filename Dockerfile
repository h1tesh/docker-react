# Build Phase is called builder
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Build phase 2, create NGINX containern NGINX acts as the api proxy to our code.
FROM nginx
# Says copy from pahse builder above the contents of /app/build. For nginx to work the javascript
# code needs to be put in /usr/share/nginx
COPY --from=builder /app/build /usr/share/nginx/html
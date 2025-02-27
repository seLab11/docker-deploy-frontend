# Stage 0: Build Angular application
FROM node:10-alpine as node
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json /app/
RUN npm install

# Copy project files and build Angular application
COPY . /app/
ARG TARGET=ng-deploy
RUN npm run ${TARGET}

# Stage 1: Deploy with Nginx
FROM nginx:1.13
COPY --from=node /app/dist/ /usr/share/nginx/html
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
EXPOSE 80

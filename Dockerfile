# syntax=docker/dockerfile:1

FROM node:lts-alpine
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --production
CMD ["node", "src/index.js"]
EXPOSE 3000
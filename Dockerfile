FROM node:16-alpine as dep
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY ["package.json", "package-lock.json", "./"]
RUN npm ci
RUN npm install sharp
RUN npm install

FROM node:16-alpine as builder
WORKDIR /app
COPY --from=dep /app/node_modules ./node_modules 
COPY . .
RUN npm run build

FROM node:16-alpine as runner
WORKDIR /app
COPY --from=builder /app/components ./components
COPY --from=builder /app/lib ./lib
COPY --from=builder /app/pages ./pages
COPY --from=builder /app/public ./public
COPY --from=builder /app/config.js ./config.js
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules

EXPOSE 3000

CMD ["npm", "start"]

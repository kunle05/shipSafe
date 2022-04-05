FROM node:16-alpine as dep
RUN apk add --no-cache libc6-compat
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json", "./"]
RUN npm ci
RUN npm install sharp
RUN npm install
RUN ls -a

FROM node:16-alpine as builder
WORKDIR /usr/src/app
COPY . .
RUN ls -a
COPY --from=dep /usr/src/app/node_modules ./node_modules 
ENV NEXT_TELEMETRY_DISABLED 1
RUN npm run build
RUN ls -a

FROM node:16-alpine as runner
WORKDIR /usr/src/app
ENV NODE_ENV production
COPY --from=builder /usr/src/app/components ./components
COPY --from=builder /usr/src/app/lib ./lib
COPY --from=builder /usr/src/app/pages ./pages
COPY --from=builder /usr/src/app/public ./public
COPY --from=builder /usr/src/app/config ./config
COPY --from=builder /usr/src/app/.next ./.next
COPY --from=builder /usr/src/app/package.json ./package.json
COPY --from=builder /usr/src/app/node_modules ./node_modules
EXPOSE 3000

CMD ["npm", "start"]

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
COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static
RUN ls -a

EXPOSE 3000

CMD ["npm", "start"]

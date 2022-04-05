FROM node:16-alpine as dep
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY ["package.json", "package-lock.json", "./"]
RUN npm install

FROM node:16-alpine as builder
WORKDIR /app
COPY --from=dep /app/node_modules ./node_modules 
COPY . .
RUN npm run build

FROM node:16-alpine as runner
WORKDIR /app
COPY --from=builder /app ./

EXPOSE 3000

CMD ["npm", "start"]

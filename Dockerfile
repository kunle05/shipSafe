FROM node:16-alpine

RUN apk add --no-cache libc6-compat

WORKDIR /usr/src/app

COPY ["package.json", "package-lock.json", "./"]

COPY . .

ENV NEXT_TELEMETRY_DISABLED 1

RUN npm install

RUN npm run build

ENV NODE_ENV production

EXPOSE 3000

CMD ["npm", "start"]

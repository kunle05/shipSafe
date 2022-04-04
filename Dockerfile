FROM node:16-alpine

RUN apk add --no-cache libc6-compat

WORKDIR /usr/src/app

COPY ["package.json", "package-lock.json", "./"]

RUN npm ci
RUN npm install

COPY . .

ENV NEXT_TELEMETRY_DISABLED 1
ENV NODE_ENV production

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]


FROM node:20-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --omit=dev

COPY server.js .

FROM node:20-alpine AS runner

WORKDIR /usr/src/app

USER node
COPY --from=builder --chown=node:node /usr/src/app/node_modules ./node_modules
COPY --from=builder --chown=node:node /usr/src/app/server.js ./server.js
EXPOSE 3000
CMD ["node", "server.js"]

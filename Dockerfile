FROM node:alpine AS builder

WORKDIR /app

# copy package.json to the work_dir
COPY package.json /
COPY package-lock.json /

# install all depencies 
RUN npm ci

# copy everything else

COPY . .

RUN npm run build

FROM node:alpine AS production

WORKDIR /next-app

COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next

EXPOSE 3000

CMD ["npm", "start"]
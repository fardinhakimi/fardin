FROM node:alpine

WORKDIR /app

# copy package.json to the work_dir
COPY package*.json /

# install all depencies 
RUN npm ci

# copy everything else

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
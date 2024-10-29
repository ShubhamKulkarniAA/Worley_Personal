FROM node:14

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

# Copy all files from the eks module directory

COPY ./modules/eks/ .

EXPOSE 5000

CMD ["node", "server.js"]

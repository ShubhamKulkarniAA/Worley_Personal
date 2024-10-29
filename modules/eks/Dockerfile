FROM node:14

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

# Copy service.js from the eks module directory
COPY ./modules/eks/service.js .

EXPOSE 5000

CMD ["node", "service.js"]

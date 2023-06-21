# Build stage
FROM krmp-d2hub-idock.9rum.cc/goorm/node AS build
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Run stage
FROM krmp-d2hub-idock.9rum.cc/goorm/node
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/build ./build

# Install serve for serving static files
RUN npm install -g serve
EXPOSE 3000

# Start Nginx and serve
CMD service nginx start && serve -s build

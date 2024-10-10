# Use the latest Node.js image (Node.js 20)
FROM node:22-alpine as build-stage

# Set working directory in container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project
COPY . .

# Build the project for production
RUN npm run build

# Use NGINX to serve the built files
FROM nginx:alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose port 80 to the outside
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]

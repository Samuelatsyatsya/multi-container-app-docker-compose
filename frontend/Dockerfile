# Build stage
FROM node:18-alpine AS build

WORKDIR /app

ARG VITE_API_URL=http://localhost:5000/api/v1
ENV VITE_API_URL=${VITE_API_URL}

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage - serve static files with a simple HTTP server
FROM node:18-alpine

WORKDIR /app

# Install serve to serve static files
RUN npm install -g serve

# Copy built app
COPY --from=build /app/dist ./dist

# Expose frontend port
EXPOSE 5173

# Serve the built app on port 5173
CMD ["serve", "-s", "dist", "-l", "5173"]

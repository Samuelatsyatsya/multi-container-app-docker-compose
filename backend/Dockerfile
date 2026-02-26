FROM node:18-alpine
WORKDIR /app

# Install dependencies first (for caching)
COPY package*.json ./
RUN npm install --only=production

# Copy source code
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001
USER nodejs

# Expose backend API port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "const port = process.env.PORT || 5000; require('http').get(`http://localhost:${port}/health`, (r) => {if (r.statusCode === 200) process.exit(0); else process.exit(1);})"

CMD ["node", "server.js"]

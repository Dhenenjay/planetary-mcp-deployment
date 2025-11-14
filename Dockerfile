# Use Node.js 22 LTS as base image
FROM node:22-alpine

# Set working directory
WORKDIR /app

# Install dependencies for building native modules
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    git

# Copy package files
COPY package*.json ./
COPY pnpm-lock.yaml* ./
COPY bun.lock* ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy application files
COPY . .

# Build the Next.js application
RUN npm run build:next

# Create directory for credentials
RUN mkdir -p /app/credentials

# Expose port 3000
EXPOSE 3000

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD node -e "require('http').get('http://localhost:3000/api/health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Start the application
CMD ["npm", "run", "start:next"]

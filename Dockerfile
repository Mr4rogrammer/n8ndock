FROM n8nio/n8n:latest

USER root

# Install dependencies using Alpine's package manager
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    npm

# Puppeteer needs environment variables for Chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Switch back to non-root user (optional for security, or leave as root if needed)
USER node

# Copy your Puppeteer script
COPY scrape.js /app/scrape.js

# Install Puppeteer
RUN npm install puppeteer

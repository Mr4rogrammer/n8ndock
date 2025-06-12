FROM n8nio/n8n:latest

# Switch to root before installing system packages and npm packages globally
USER root

# Install necessary system dependencies
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    npm

# Set Chromium path for puppeteer to use
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Install puppeteer globally as root
RUN npm install -g puppeteer

# Copy your script
COPY scrape.js /app/scrape.js

# Optional: Switch back to node for security (or stay as root if needed)
USER node

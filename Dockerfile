# Start from the official n8n image
FROM n8nio/n8n:latest

# Switch to root to install packages
USER root

# Install required dependencies for Puppeteer (Chromium)
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    chromium \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Puppeteer (ensure it's installed globally)
RUN npm install -g puppeteer

# Optional: Set Puppeteer Chromium path environment variable
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Create working dir and copy custom script
WORKDIR /app
COPY scrape.js /app/scrape.js

# Revert back to the non-root user used by n8n
USER node

CMD ["n8n"]

# n8n will run as default CMD from base image

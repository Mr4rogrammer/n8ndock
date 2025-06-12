FROM n8nio/n8n:latest

USER root

# Install dependencies for Puppeteer & Chromium
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
    gnupg \
    curl \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Chromium manually (Puppeteer-compatible version)
RUN apt-get update && apt-get install -y chromium-browser && \
    ln -s /usr/bin/chromium-browser /usr/bin/chromium

# Install Puppeteer globally
RUN npm install -g puppeteer

# Add your Puppeteer script if needed
COPY scrape.js /app/scrape.js

USER node

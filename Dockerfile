FROM node:20-slim

# Install system dependencies required for Chromium
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
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install n8n and Puppeteer
RUN npm install -g n8n puppeteer

# Optional: copy your n8n config or data folders
# COPY ./n8n-config /root/.n8n

# Create work directory
WORKDIR /app

# Add custom Puppeteer scripts (optional)
COPY scrape.js /app/scrape.js

# Default command: start n8n
CMD ["n8n"]

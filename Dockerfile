# Use Node 20 base image
FROM node:20

# Enable Yarn via Corepack
RUN corepack enable && corepack prepare yarn@stable --activate

# Set working directory
WORKDIR /feeds

# Copy only lockfile/package files first (better caching)
COPY package.json yarn.lock ./

# Install dependencies via Yarn
RUN yarn install

# Copy source files
COPY . .

# Build TypeScript (if needed)
RUN yarn build

# Set default port
ENV FEEDGEN_PORT=4000

# Run the feed generator
CMD ["yarn", "start"]

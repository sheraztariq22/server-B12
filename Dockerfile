# Use the official Node.js image from the Docker Hub
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install necessary packages and dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Create a volume named "servervol" and mount it at "/serverdata" in the container
VOLUME ["servervol:/serverdata"]

# Expose port 5000
EXPOSE 5000

# Define the command to run the server application
CMD ["node", "server.js"]

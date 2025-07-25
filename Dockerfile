FROM node:20-alpine

# pass N8N_VERSION Argument while building or use default
ARG N8N_VERSION=1.39.1

# Update everything and install needed dependencies
RUN apk add --update graphicsmagick tzdata

# Set a custom user to not have n8n run as root
USER root

# Install n8n and also all temporary packages
RUN apk --update add --virtual build-dependencies python3 build-base && \
	npm_config_user=root npm install --location=global n8n@${N8N_VERSION} && \
	apk del build-dependencies

# Working directory
WORKDIR /data

# Expose the default n8n port
EXPOSE 5678

# define execution entrypoint
CMD ["n8n"]

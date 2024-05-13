# Specify base image
FROM alpine

# Create a working directory
WORKDIR /usr/app

# Install redis in Alpine
RUN apk add --update redis

# Start the redis server
CMD ["redis-server"]
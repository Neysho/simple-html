# Base image
FROM nginx:latest

# Copy HTML files to the nginx document root
COPY blue.html /usr/share/nginx/html/blue.html
COPY red.html /usr/share/nginx/html/red.html
COPY purple.html /usr/share/nginx/html/purple.html

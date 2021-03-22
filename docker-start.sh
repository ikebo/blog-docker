docker run --rm --name blog -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -v $(pwd)/ssl:/etc/nginx/ssl -v $(pwd)/src:/var/www/html  -it -p 80:80/tcp egbertke/blog

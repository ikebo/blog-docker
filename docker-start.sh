docker run --rm --name blog -v $(pwd)/src:/var/www/html  -it -p 80:80/tcp egbertke/blog

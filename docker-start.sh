docker run -d --name blog -v $(pwd)/start.sh:/root/start.sh -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf -v $(pwd)/sites-enabled:/etc/nginx/sites-enabled -v $(pwd)/ssl:/etc/nginx/ssl -v $(pwd)/src:/var/www/html  -it -p 80:80/tcp -p 443:443/tcp egbertke/blog
nohup python3 -u flusher.py >flush.log 2>&1 &

FROM nginx
COPY build /usr/share/nginx/html
COPY docker-entrypoint.sh /usr/local/bin
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh && ln -s usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
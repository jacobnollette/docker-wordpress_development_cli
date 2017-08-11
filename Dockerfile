FROM jnollette/wordpress_development:latest

#	Install requirements for wp-cli support (mysql-client)
RUN apt-get update \
  && apt-get install -y sudo less mysql-client \
  && rm -rf /var/lib/apt/lists/*

#	Install wp-cli 
RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
COPY wp-su.sh /bin/wp
RUN chmod +x /bin/wp-cli.phar
#RUN /usr/sbin/service sendmail restart


#	Install mailhog sendmail
#	https://stackoverflow.com/questions/42153606/docker-connect-mail-catcher-with-wordpress
RUN curl --location --output /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 \
	&& chmod +x /usr/local/bin/mhsendmail

RUN echo 'sendmail_path="/usr/local/bin/mhsendmail --smtp-addr=mailhog:1025 --from=no-reply@docker.dev"' > /usr/local/etc/php/conf.d/mailhog.ini




#ENTRYPOINT ["docker-entrypoint.sh"]

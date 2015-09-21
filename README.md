# docker-sftp
a dockerized sftp server with some security opinions.

# Build It

	docker build --rm=true -t sftp .

# Run It

	docker run -it -d -p 3333:22 --restart=always --name sftp sftp

# Enjoy It

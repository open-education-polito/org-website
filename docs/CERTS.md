# Certificates

## How to
Currently we are handling the certificates using Let's Encrypt.
In order to correctly set up the server, these are the commands to be run:

```bash
sudo systemctl stop nginx
sudo certbot renew --standalone
sudo systemctl start nginx
```

in this way the certs are renewed and the services are restarted.

There is also a script running every Sunday at 03:00 but, in case it does not
work, it's possible to manually run those commands to ensure the certificate is
up and  running. 

# EspoCRM Dockerized

Dockerized EspoCRM with ability to run unit-test during development and use build of EspoCRM in production.

## Pre-Installation

### Ubuntu / Linux

Making sure docker doesn't require superuser permission to run commands.

```bash
docker container ls
```

If this fails and you get Permission denied message, run the following command

```bash
sudo usermod -aG docker $USER
sudo reboot
```

### Mac OS

1) Go to Docker Preferences => File Sharing
2) Add /crm path, otherwise docker volume mount will fail.

## Installation [For Production]

```bash
docker build -t crm-webapp:1.0.0 --build-arg VERSION=5.4.5 -f webapp/Dockerfile /crm
docker-compose -f prod.docker-compose.yml up -d
```

Load http://localhost and follow the [installation steps of EspoCRM](https://www.espocrm.com/documentation/administration/installation/).

The Host Name of MySQL is `mysqldb:3306`.

## Installation [For Development]

Note: -v option is for EspoCRM's Version and -V is for verbose mode

### Ubuntu / Linux

```bash
sudo mkdir /crm
sudo chown -R $USER:$USER /crm
git clone git://github.com/theBuzzyCoder/dockerised-espo.git /crm
./installer -v 5.4.5 -V
```

Load http://localhost:8088 and follow the [installation steps of EspoCRM](https://www.espocrm.com/documentation/administration/installation/).
The Host Name of MySQL is `mysqldb:3306`.

### Mac OS

```sh
sudo mkdir /crm
sudo chown -R $USER:$USER /crm
git clone git://github.com/theBuzzyCoder/dockerised-espo.git /crm
./macOs-installer -v 5.4.5 -V
```

Load http://localhost:8088 and follow the [installation steps of EspoCRM](https://www.espocrm.com/documentation/administration/installation/).
The Host Name of MySQL is `mysqldb:3306`.

## Extensions

EspoCRM allows build your own custom extensions to suit your needs.

[Here](./projects/README.md)'s how you can do that in this setup.

## Debugging

- Logs can be found in `espocrm/data/logs` folder of your container
- You can also do this
  - `docker volume inspect crm_database-configurations`
  - Use MountPoint path and append `/logs` to that path to see all log files
- Your database configurations will be stored in `espocrm/data/config.php` file of your container.
- In case, you have forgotten your CRM's admin's login password or unable to login and outbound email is not set to send reset password, just delete `espocrm/data/config.php` file and follow the [installation steps of EspoCRM](https://www.espocrm.com/documentation/administration/installation/).
- You can also change LOG_LEVEL in the `espocrm/data/config.php` file of your container. By default, it will be `WARNING`.
- Adding System Email Id to send reset password should be done in SMTP settings of Outbound Email in Administration panel.
- Adding shared email id's that will be used by users of EspoCRM should happen in Administration Panel's Group emails section of the application.
- Just in case if you get `SQL STATE` errors or `bad server response` follow this:
  - `docker container ls | grep Server | awk '{print $NF}'`
  - Get the container name of crmServer and put it in <crmServer> placeholders below
  - `docker exec <crmServer> php -f clear_cache.php`
  - `docker exec <crmServer> php -f rebuild.php`
  - Go to your browser and run `Ctrl + F5` or `Ctrl + Shift + r` to force reload all the .js and .css files.

## Running Unit and Integration Tests

You can run tests only on development mode. So, your docker-compose file should be dev.docker-compose.yml
while bringing containers up.

### Installing phpunit

```bash
docker exec devCrmServer apk add wget
docker exec devCrmServer wget -O phpunit https://phar.phpunit.de/phpunit-7.phar
docker exec devCrmServer chmod +x phpunit
```

### Unit Test

```bash
docker exec devCrmServer phpunit --bootstrap ./vendor/autoload.php tests/unit
```

### Integration Test

Make sure you update the version in config.php file to your Espo version. By default it will be `@@version`.

For example, if espo crm version is 5.4.5 then in config.php make sure it is 5.4.5.

Also you have to generate build before running integration tests. The build will be present in `/crm/espocrm/build/EspoCRM-5.4.5`

Generating build:
```bash
docker run --rm -v /crm/espocrm:/app node:8.12.0-alpine sh -c "cd /app; npm install; npm install -g grunt-cli; grunt"
```

Running Test:
```bash
docker exec devCrmServer cp data/config.php tests/integration/config.php
docker exec devCrmServer phpunit --bootstrap ./vendor/autoload.php tests/integration
```

It takes a while to running integration tests unlike unit tests.

## Contributors

[List of Contributors](./Contributors.md)

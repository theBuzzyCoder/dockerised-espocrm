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

## Contributors

[List of Contributors](./Contributors.md)

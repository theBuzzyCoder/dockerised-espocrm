# EspoCRM Dockerized

## Installation

### Ubuntu / Linux

Pre Installation:

```bash
docker container ls
```

If this fails and you get Permission denied message, run the following command

```bash
sudo usermod -aG docker $USER
sudo reboot
```

Finally Install CRM:

```bash
sudo mkdir /crm
sudo chown -R $USER:$USER /crm
git clone git://github.com/theBuzzyCoder/dockerised-espo.git
./installer -v 5.4.5 -V
```

### Mac OS

Pre Installation:

1) Go to Docker Preferences => File Sharing
2) Add /crm path, otherwise mount will fail.

To install:

```sh
./macOs-installer -v 5.4.5 -V
```

## Contributors

[List of Contributors](./Contributors.md)

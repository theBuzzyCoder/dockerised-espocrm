# Description

The folder structure is kept identical in host and the container image. This is so that the confusion is less
and development happens smoothly.

`/crm` is because the $HOME username changes from image to image. To keep it consistent and not to nest to many folder levels,
we kept `/crm` as the `WORKDIR`

# Build Dockerfile

```bash
sudo mkdir /crm
sudo chown -R $USER:$USER /crm
cd /crm
docker build -f webapp/Dockerfile -t crm-webapp:1.0.0 --build-arg VERSION=5.4.5 .
```

## Note

- build-args is needed to specify EspoCRM version
- build context is /crm

---
[HOME](../README.md)

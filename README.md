# alpine-image-builder

Docker base image with all tools needed to build Alpine Linux OS rootfs and
SD card images for Raspberry Pi and x86_64.

Used as the builder base by:
- [alpine-os-rootfs](https://github.com/barthel/alpine-os-rootfs)
- [alpine-image-builder-rpi](https://github.com/barthel/alpine-image-builder-rpi)

## Included tools

| Tool | Purpose |
|---|---|
| `binfmt-support` + `qemu-user-static` | ARM cross-execution in chroot |
| `parted`, `dosfstools`, `e2fsprogs` | Disk image partitioning and formatting |
| `util-linux`, `kpartx` | Loop device and partition management |
| `zip`, `unzip`, `wget` | Compression and downloads |
| `shellcheck` | Shell script linting |
| `ruby-full` + `serverspec` | Rootfs and image testing |

## Build and push

```bash
make build
IMAGE_TAG=v1.0 make push
```

## Other targets

```bash
make shell          # Open a shell inside the image
make tag TAG=v1.0   # Create and push a git tag
```

## CI / Release

CircleCI builds and pushes the image on every tag push.
The pipeline uses the `Docker Hub` context for `DOCKER_USER` / `DOCKER_PASS`.

## Usage in downstream Dockerfiles

```dockerfile
FROM uwebarthel/alpine-image-builder:latest
COPY builder /builder/
CMD ["/builder/build.sh"]
```

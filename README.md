# ASCIINEMA GIF Generator AGG [![🚀 Build and Push Docker Image](https://github.com/DucretJe/agg-image/actions/workflows/build.yaml/badge.svg?branch=main)](https://github.com/DucretJe/agg-image/actions/workflows/build.yaml) [![💫 Super-Linter](https://github.com/DucretJe/agg-image/actions/workflows/linter.yaml/badge.svg?branch=main)](https://github.com/DucretJe/agg-image/actions/workflows/linter.yaml)

![Camera code](https://github.com/DucretJe/agg-image/assets/5384298/b37dbf31-d9fa-4600-a02a-2c2267d410bd)

This repository builds a Docker image of [ASCIINEMA GIF Generator (agg)](https://github.com/asciinema/agg/tree/main).

## How to

```sh
docker run --rm -v `pwd`:/workdir ghcr.io/ducretje/agg:latest <FILENAME>
```

It will create a new file at the same name and location than the input file replacing the `.cast` extention by `.gif`.

> For now it only contains one Nerd Font: Hack, but you can mount yours in `/home/agg/.local/share/fonts`. If you want to use `agg` to be able to add some options, you will have to change the entrypoint to `agg`

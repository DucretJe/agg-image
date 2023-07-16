# ASCIINEMA GIF Generator AGG [![🚀 Build and Push Docker Image](https://github.com/DucretJe/agg-image/actions/workflows/build.yaml/badge.svg?branch=main)](https://github.com/DucretJe/agg-image/actions/workflows/build.yaml) [![💫 Super-Linter](https://github.com/DucretJe/agg-image/actions/workflows/linter.yaml/badge.svg?branch=main)](https://github.com/DucretJe/agg-image/actions/workflows/linter.yaml)

![Camera code](https://github.com/DucretJe/agg-image/assets/5384298/b37dbf31-d9fa-4600-a02a-2c2267d410bd)

This repository builds a Docker image of [ASCIINEMA GIF Generator (agg)](https://github.com/asciinema/agg/tree/main).

## How to

```sh
docker run --rm -v `pwd`:/workdir ghcr.io/ducretje/agg:latest <FILENAME>
```

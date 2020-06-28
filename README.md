# PHP 7.2 Laravel

This project provides a base-build container for Laravel projects by pulling in required dependencies and reducing build time for projects via CI.

This specific repo builds nightly using the base image `php:7.2-fpm-buster` to provide additional updates and changes from the base.

## Local Testing

To quickly test the Dockerfile for builds, run the following command from the root of this repository on a system with Docker installed:

```bash
docker build --no-cache --compress -t troyfontaine/php72-laravel:test .
```

If you want to diagnose a version pinning issue for a package, launch the base container and try manually installing the package version in question:

```bash
docker run -it --rm php:7.2-fpm-buster bash
```

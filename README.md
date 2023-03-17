<!--
Copyright 2023 Robert Bosch GmbH

SPDX-License-Identifier: Apache-2.0
-->

# DSE Schemas

[![CI](https://github.com/boschglobal/dse.schemas/actions/workflows/ci.yaml/badge.svg)](https://github.com/boschglobal/dse.schemas/actions/workflows/ci.yaml)
![GitHub](https://img.shields.io/github/license/boschglobal/dse.schemas)


## Introduction

Schemas of the Dynamic Simulation Environment (DSE) Core Platform.


### Project Structure

```
L- docs        Documentation (integrates with Hugo/Docsy).
L- docker      Supporting build environments.
L- schemas     Schemas of the DSE Core Platform.
L- templates   Templates used for building schema packages.
```


## Usage

### Build

```bash
# Get the repo
$ git clone https://github.com/boschglobal/dse.schemas.git
$ cd dse.schemas

# Build the toolchains (optional, builder containers are published on ghcr.io).
$ make builders
...
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
python-builder      latest              a5ef73ea66dc        16 minutes ago      858MB
flatc-builder       latest              f4bb83e2c0c9        18 minutes ago      324MB

# Build and package the schemas.
$ make
...
$ make dist
Distribution package files:
--------------------------
164K /git/boschglobal/dse.schemas/dist/dse-schemas.tar.gz
20K /git/boschglobal/dse.schemas/dist/python/dist/dse.schemas-0.0.2-py3-none-any.whl
12K /git/boschglobal/dse.schemas/dist/python/dist/dse.schemas-0.0.2.tar.gz
```


### Development

```bash
# Generate documentation based on schemas.
make generate

# Install Python package for local development.
make install

# Remove (clean) temporary build artifacts.
make clean
```


## Dependencies

Schemas in this repository require:

* [FlatBuffers](https://github.com/google/flatbuffers) v1.12.0 or v2.0.0 (or later).
* [flatcc](https://github.com/dvidelabs/flatcc) v0.6.0 (or later).
* [msgpack-c](https://github.com/msgpack/msgpack-c) v3.3.0 (or later).

Later versions may require testing.


## Contribute

Please refer to the [CONTRIBUTING.md](./CONTRIBUTING.md) file.


## License

DSE Schemas is open-sourced under the Apache-2.0 license.
See the [LICENSE](LICENSE) and [NOTICE](./NOTICE) files for details.

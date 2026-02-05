<!--
Copyright 2023 Robert Bosch GmbH

SPDX-License-Identifier: Apache-2.0
-->

# Dynamic Simulation Environment - Schemas

[![CI](https://github.com/boschglobal/dse.schemas/actions/workflows/ci.yaml/badge.svg)](https://github.com/boschglobal/dse.schemas/actions/workflows/ci.yaml)
![GitHub](https://img.shields.io/github/license/boschglobal/dse.schemas)


## Introduction

Schemas of the Dynamic Simulation Environment (DSE) Core Platform.


### Project Structure

```text
dse.schemas
└── code/go/dse                     <-- Go Module, generated, including YAML schema parsers.
└── doc                             <-- Documentation, generated.
└── schemas
    └── flatbuffers                 <-- Flatbuffers schemas: SimBus Protocol.
    └── yaml                        <-- YAML schemas: DSE "Kind" documents.
└── templates                       <-- Templates used for generating code packages.
└── wireshark
    └── README.md                   <-- Readme for Wireshark Dissectors.
    └── simbus_dissector.lua        <-- SimBus Protocol dissector.
    └── examples/                   <-- Example traces for use with dissectors.
└── Makefile                        <-- Repo level Makefile.
```


## Usage

### Toolchains

The Schemas are built using containerised toolchains. Those are
available from the DSE C Library and can be built as follows:

```bash
$ git clone https://github.com/boschglobal/dse.clib.git
$ cd dse.clib
$ make docker
```

Alternatively, the latest Docker Images are available on ghcr.io and can be
used as follows:

```bash
$ export FLATC_BUILDER_IMAGE=ghcr.io/boschglobal/dse-flatc-builder:main
$ export PYTHON_BUILDER_IMAGE=ghcr.io/boschglobal/dse-python-builder:main
```


### Build

```bash
# Get the repo
$ git clone https://github.com/boschglobal/dse.schemas.git
$ cd dse.schemas

# Optionally set builder images.
$ export FLATC_BUILDER_IMAGE=ghcr.io/boschglobal/dse-flatc-builder:main
$ export PYTHON_BUILDER_IMAGE=ghcr.io/boschglobal/dse-python-builder:main

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

The generate make target requires some tools which may be installed as follows:

```bash
$ sudo apt install npm

or

$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
$ export NVM_DIR="$HOME/.nvm"
$ [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
$ nvm ls-remote
$ nvm install 18
$ nvm use 18
$ sudo chown -R $USER:$(id -gn $USER) /home/XYZ/package-lock.json

# widdershins
$ git clone https://github.com/Mermade/widdershins.git
$ cd widdershins/
$ npm install -g widdershins --before=2020-04-01

# swagger-cli
$ npm install -g @apidevtools/swagger-cli

# oapi-codegen
$ go install github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest

# json-schema-to-openapi-schema
$ npm install -g @openapi-contrib/json-schema-to-openapi-schema

# Audit
$ npm list -g
/usr/local/lib
├── @apidevtools/swagger-cli@4.0.4
├── nexe@3.0.0
└── widdershins@4.0.1
```


## Dependencies

Schemas in this repository require:

* [FlatBuffers](https://github.com/google/flatbuffers) v1.12.0 or v2.0.0 (or later).
* [flatcc](https://github.com/dvidelabs/flatcc) v0.6.0 (or later).
* [msgpack-c](https://github.com/msgpack/msgpack-c) v3.3.0 (or later).

Later versions may require testing.

> __Note:__ Use of MsgPack is depreciated in schema consumers (preference is for Flatbuffers).


## Contribute

Please refer to the [CONTRIBUTING.md](./CONTRIBUTING.md) file.


## License

Dynamic Simulation Environment Schemas is open-sourced under the Apache-2.0 license.
See the [LICENSE](LICENSE) and [NOTICE](./NOTICE) files for details.

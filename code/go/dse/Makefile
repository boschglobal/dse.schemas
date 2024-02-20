# Copyright 2024 Robert Bosch GmbH
#
# SPDX-License-Identifier: Apache-2.0


KIND_YAML_DIR = ../../../schemas/yaml
KIND_YAML_FILES = $(shell ls $(KIND_YAML_DIR)/*.yaml)


.PHONY: generate
generate: kind

kind: $(KIND_YAML_FILES)

.PHONY: $(KIND_YAML_FILES)
$(KIND_YAML_FILES):
	@echo $$(basename $@)
	@mkdir -p kind
	@~/go/bin/oapi-codegen -config config.yaml $@ > kind/$$(basename $@).go
	@sed -i '/delete_this_line/d' kind/$$(basename $@).go
	@sed -i '/\/\//d' kind/$$(basename $@).go
	@sed -i '/./!d' kind/$$(basename $@).go
	@sed -i -e 's/externalRef[[:digit:]]*\.//g' kind/$$(basename $@).go
	@sed -i -e 's/`json:"/`yaml:"/g' kind/$$(basename $@).go
	@go fmt kind/$$(basename $@).go

.PHONY: clean
clean:
	@rm -rf kind

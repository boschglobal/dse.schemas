# Copyright 2024 Robert Bosch GmbH
#
# SPDX-License-Identifier: Apache-2.0


KIND_YAML_DIR = ../../../schemas/yaml
KIND_YAML_FILES = $(shell ls $(KIND_YAML_DIR)/*.yaml)


.PHONY: generate
generate: clean kind

kind: $(KIND_YAML_FILES)
	@echo "package kind" > kind/kind.go

.PHONY: $(KIND_YAML_FILES)
$(KIND_YAML_FILES):
	@echo $$(basename $@)
	@~/go/bin/oapi-codegen -config kind/config.yaml $@ > kind/$$(basename $@ .yaml).go
	@sed -i '/delete_this_line/d' kind/$$(basename $@ .yaml).go
	@sed -i '/\/\//d' kind/$$(basename $@ .yaml).go
	@sed -i '/./!d' kind/$$(basename $@ .yaml).go
	@sed -i -e 's/externalRef[[:digit:]]*\.//g' kind/$$(basename $@ .yaml).go
	@sed -i -e 's/`json:"/`yaml:"/g' kind/$$(basename $@ .yaml).go
	@go fmt kind/$$(basename $@ .yaml).go

.PHONY: clean
clean:
	@rm -f kind/*.go

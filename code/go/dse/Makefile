# Copyright 2024 Robert Bosch GmbH
#
# SPDX-License-Identifier: Apache-2.0


YAML_DIR = ../../../schemas/yaml
KIND_YAML_FILES = $(shell cd $(YAML_DIR); ls *.yaml)
KIND_YAML_FILES := $(filter-out Simulation.yaml, $(KIND_YAML_FILES))
KIND_GO_FILES = $(subst .yaml,.go, $(KIND_YAML_FILES))
KIND_FILES = $(addprefix kind/, $(KIND_GO_FILES))
AST_FILES = ast/Simulation.go ast/metadata.go
PATCH_FILES = patch/marshal_yaml.patch
FLATBUFFER_GO_DIR = ../../../dist/dse-schemas/flatbuffers/go

.PHONY: generate
generate: clean kind ast patch flatbuffers


kind: $(KIND_FILES)
	@echo "package kind" > kind/kind.go
kind/%.go: $(YAML_DIR)/%.yaml
	@echo "$$(basename $<) --> $@"
	@~/go/bin/oapi-codegen -config $(@D)/config.yaml $< > $@
	@sed -i '/delete_this_line/d' $@
	@sed -i '/\/\//d' $@
	@sed -i '/./!d' $@
	@sed -i -e 's/externalRef[[:digit:]]*\.//g' $@
	@sed -i -e 's/`json:"/`yaml:"/g' $@
	@go fmt $@

ast: $(AST_FILES)
	@echo "package ast" > ast/ast.go
ast/%.go: $(YAML_DIR)/%.yaml
	@echo "$$(basename $<) --> $@"
	@~/go/bin/oapi-codegen -config $(@D)/config.yaml $< > $@
	@sed -i '/delete_this_line/d' $@
	@sed -i '/\/\//d' $@
	@sed -i '/./!d' $@
	@sed -i -e 's/externalRef[[:digit:]]*\.//g' $@
	@sed -i -e 's/`json:"/`yaml:"/g' $@
	@go fmt $@

.PHONY: $(PATCH_FILES)
patch: $(PATCH_FILES)
$(PATCH_FILES):
	@echo "Apply Patch: $@ --> "
	@git apply $@

flatbuffers:
	cp -r $(FLATBUFFER_GO_DIR)/dse/schemas schemas
	@echo "package channel" > schemas/fbs/channel/channel.go
	@echo "package notify" > schemas/fbs/notify/notify.go

.PHONY: clean
clean:
	@rm -f kind/*.go
	@rm -f ast/*.go
	@rm -rf schemas

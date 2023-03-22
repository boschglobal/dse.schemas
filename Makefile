# Copyright 2023 Robert Bosch GmbH
#
# SPDX-License-Identifier: Apache-2.0

###############
## Builder Images.
FLATC_BUILDER_IMAGE ?= flatc-builder:latest
PYTHON_BUILDER_IMAGE ?= python-builder:latest


###############
## Packaging.
PACKAGE_NAME = dse-schemas
PACKAGE_FILENAME = $(PACKAGE_NAME).tar.gz
PACKAGE_VERSION ?= 0.0.2
PYPI_NAMESPACE_NAME = dse
PYPI_PACKAGE_NAME = $(PYPI_NAMESPACE_NAME).schemas


###############
## Build parameters.
SCHEMA_LIB = dse_schemas
PLATFORM = linux64
DIST_DIR = $(shell pwd -P)/dist
OUT_DIR = $(shell pwd -P)/dist/$(PACKAGE_NAME)
# Flatbuffers
FBS_OUT_DIR = $(OUT_DIR)/flatbuffers
FBS_SCHEMA_DIR = $(shell pwd -P)/schemas
FBS_SCHEMA_SOURCES = $(shell ls $(FBS_SCHEMA_DIR)/**/*.fbs)
# FlatC
FLATC = flatc
FLATC_OPTIONS =
FLATCC = flatcc
# FlatCC
FLATCC_SRC_RUNTIME_DIR = /usr/local/src/flatcc/src/runtime
FLATCC_SRC_INCLUDE_DIR = /usr/local/include/flatcc
FLATCC_SRC_LICENSE_DIR = /usr/local/src/flatcc
FLATCC_DIST_RUNTIME_DIR = $(FBS_OUT_DIR)/c/$(SCHEMA_LIB)/flatcc/src
FLATCC_DIST_INCLUDE_DIR = $(FBS_OUT_DIR)/c/$(SCHEMA_LIB)/flatcc/include/flatcc
# MsgPack
MPK_OUT_DIR = $(OUT_DIR)/msgpack
MPK_SCHEMA_DIR = $(shell pwd -P)/schemas/msgpack
MPK_SCHEMA_SOURCES = $(shell ls $(MPK_SCHEMA_DIR)/*.yaml)
# Python (for creating a Python Package)
PYTHON_SRC_DIR = $(FBS_OUT_DIR)/python
PYTHON_DIST_DIR = $(DIST_DIR)/python
# YAML
YAML_SCHEMA_DIR = $(shell pwd -P)/schemas/yaml


###############
## Generate options
DOC_SCHEMA_DIR = $(shell pwd -P)/doc/content/schemas
DOC_SCHEMA_YAML_DIR = $(DOC_SCHEMA_DIR)/yaml
DOC_YAML_SCHEMAS = $(shell ls $(YAML_SCHEMA_DIR)/[A-Z]*.yaml) $(shell ls $(MPK_SCHEMA_DIR)/[A-Z]*.yaml)


default: build

build:
	@docker run -it --rm \
		--volume $$(pwd):/tmp/repo \
		--env PACKAGE_VERSION=$(PACKAGE_VERSION) \
		--workdir /tmp/repo \
		$(FLATC_BUILDER_IMAGE) \
		/bin/bash -c "make fbs"
	@docker run -it --rm \
		--volume $$(pwd):/tmp/repo \
		--env PIP_EXTRA_INDEX_URL=$(PIP_EXTRA_INDEX_URL) \
		--env PACKAGE_VERSION=$(PACKAGE_VERSION) \
		--workdir /tmp/repo \
		$(PYTHON_BUILDER_IMAGE) \
		/bin/bash -c "make python; make msgpack"

	@echo ""
	@echo "Generated files:"
	@echo "---------------"
	@ls -R $(FBS_OUT_DIR)
	@ls -R $(MPK_OUT_DIR)

$(FBS_SCHEMA_SOURCES):
	@echo $@
	# Setup the directory structure.
	mkdir -p $(FBS_OUT_DIR)/c/$(SCHEMA_LIB)/$$(basename $$(dirname $@))
	mkdir -p $(FBS_OUT_DIR)/cpp/$(SCHEMA_LIB)/$$(basename $$(dirname $@))
	mkdir -p $(FBS_OUT_DIR)/fbs/$$(basename $$(dirname $@))
	mkdir -p $(FBS_OUT_DIR)/fbs/$$(basename $$(dirname $@))
	mkdir -p $(FBS_OUT_DIR)/fbs/$$(basename $$(dirname $@))
	mkdir -p $(FBS_OUT_DIR)/lua

	# Generate Flatbuffers code.
	$(FLATCC) -a $(FLATC_OPTIONS) -o $(FBS_OUT_DIR)/c/$(SCHEMA_LIB)/$$(basename $$(dirname $@)) $@
	$(FLATC) --cpp $(FLATC_OPTIONS) --filename-suffix '' -o $(FBS_OUT_DIR)/cpp/$(SCHEMA_LIB)/$$(basename $$(dirname $@)) $@
	$(FLATC) --python $(FLATC_OPTIONS) -o $(FBS_OUT_DIR)/python $@
	cd $(FBS_OUT_DIR)/lua; $(FLATC) --lua $(FLATC_OPTIONS) $@
	# Copy over the original Flatbuffer schemas.
	cp $@ $(FBS_OUT_DIR)/fbs/$$(basename $$(dirname $@))

fbs: $(FBS_SCHEMA_SOURCES)
	mkdir -p $(FLATCC_DIST_RUNTIME_DIR)
	cp $(FLATCC_SRC_RUNTIME_DIR)/builder.c $(FLATCC_DIST_RUNTIME_DIR)
	cp $(FLATCC_SRC_RUNTIME_DIR)/emitter.c $(FLATCC_DIST_RUNTIME_DIR)
	cp $(FLATCC_SRC_RUNTIME_DIR)/refmap.c $(FLATCC_DIST_RUNTIME_DIR)
	cp $(FLATCC_SRC_LICENSE_DIR)/LICENSE $(FLATCC_DIST_RUNTIME_DIR)
	mkdir -p $(FLATCC_DIST_INCLUDE_DIR)
	cp -r $(FLATCC_SRC_INCLUDE_DIR)/* $(FLATCC_DIST_INCLUDE_DIR)

$(MPK_SCHEMA_SOURCES):
	@echo $@
	mkdir -p $(MPK_OUT_DIR)/$$(basename $$(dirname $@))
	cp $@ $(MPK_OUT_DIR)/$$(basename $$(dirname $@))

msgpack: $(MPK_SCHEMA_SOURCES)

python:
	mkdir -p $(PYTHON_DIST_DIR)
	cp -r $(PYTHON_SRC_DIR)/* $(PYTHON_DIST_DIR)
	rm $(PYTHON_DIST_DIR)/dse/__init__.py
	cp -r templates/python/* $(PYTHON_DIST_DIR)
	cd $(PYTHON_DIST_DIR) && python3 setup.py sdist bdist_wheel

dist_package:
	@mkdir -p $(DIST_DIR)
	@mkdir -p $(OUT_DIR)
	@echo $(PACKAGE_VERSION) > $(OUT_DIR)/VERSION
	@tar -czf $(DIST_DIR)/$(PACKAGE_FILENAME) -C $(DIST_DIR) $(PACKAGE_NAME)

dist:
	@docker run -it --rm \
		--volume $$(pwd):/tmp/repo \
		--env PIP_EXTRA_INDEX_URL=$(PIP_EXTRA_INDEX_URL) \
		--env PACKAGE_VERSION=$(PACKAGE_VERSION) \
		--workdir /tmp/repo \
		$(PYTHON_BUILDER_IMAGE) \
		/bin/bash -c "make dist_package"

	@echo ""
	@echo "Distribution package files:"
	@echo "--------------------------"
	@ls -1sh $(DIST_DIR)/*.*
	@ls -1sh $(PYTHON_DIST_DIR)/dist/*.*

_generate_clean:
	-@rm -rf $(DOC_SCHEMA_YAML_DIR)

generate: _generate_clean $(DOC_YAML_SCHEMAS)
	for d in $(DOC_YAML_SCHEMAS) ;\
	do \
		swagger-cli validate $$d ;\
		mkdir -p $(DOC_SCHEMA_YAML_DIR) ;\
		widdershins --environment doc/templates/__doc_opts__.json $$d -o $(DOC_SCHEMA_YAML_DIR)/$$(basename $$d .yaml).md ;\
		sed -i "1s;^;---\n;" $(DOC_SCHEMA_YAML_DIR)/$$(basename $$d .yaml).md ;\
		sed -i "1s;^;linkTitle: \"$$(basename $$d .yaml)\"\n;" $(DOC_SCHEMA_YAML_DIR)/$$(basename $$d .yaml).md ;\
		sed -i "1s;^;title: \"Schema: $$(basename $$d .yaml)\"\n;" $(DOC_SCHEMA_YAML_DIR)/$$(basename $$d .yaml).md ;\
		sed -i '1s;^;---\n;' $(DOC_SCHEMA_YAML_DIR)/$$(basename S$$d .yaml).md ;\
	done;
	cp doc/templates/yaml/_index.md $(DOC_SCHEMA_YAML_DIR)/_index.md

test:

install:
	pip install -e $(PYTHON_DIST_DIR)/.

remove:
	-pip uninstall -y $(PYPI_PACKAGE_NAME)

clean:
	-@rm -rf $(DIST_DIR)

.PHONY: default build fbs msgpack python dist dist_package clean $(FBS_SCHEMA_SOURCES) $(MPK_SCHEMA_SOURCES)


# Copyright 2026 Robert Bosch GmbH
#
# SPDX-License-Identifier: Apache-2.0


CACHE_DIR := .cache
ABS_ARCHIVE := $(CACHE_DIR)/automotive-bus-schema.tar.gz
ABS_EXTRACT_DIR := $(CACHE_DIR)
SCHEMA_DIR := $(ABS_EXTRACT_DIR)/automotive-bus-schema/flatbuffers/go/AutomotiveBus/Stream
OUT_DIR := stream
GO_STREAM_PDU := $(OUT_DIR)/pdu


.PHONY: generate fetch extract clean distclean

generate: clean extract copy patch package

fetch: $(ABS_ARCHIVE)

$(ABS_ARCHIVE):
	@mkdir -p $(CACHE_DIR)
	curl -fsSL "$(ABS_URL)" -o "$@"

extract: fetch
	@mkdir -p $(ABS_EXTRACT_DIR)
	tar -xzf "$(ABS_ARCHIVE)" -C "$(ABS_EXTRACT_DIR)"

copy:
	@mkdir -p $(GO_STREAM_PDU)
	cp -r $(SCHEMA_DIR)/Pdu/. $(GO_STREAM_PDU)/

patch: copy
	@echo "Apply Patch: package LC"
	find $(GO_STREAM_PDU) -type f -name '*.go' -exec sed -i 's/^package Pdu$$/package pdu/' {} +

package:

.PHONY: clean
clean:
	rm -rf $(OUT_DIR)
	rm -rf $(CACHE_DIR)

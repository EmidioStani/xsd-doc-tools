#!make

# Define SHELL based on OS
ifeq ($(OS),Windows_NT)
SHELL := cmd
else
SHELL := /bin/bash
endif

# Variables
SCHEMA_VERSION := 1.0
CURR_SCHEMA := unitsml-v${SCHEMA_VERSION}

SRC := $(wildcard models/**/*.xsd)
DOCS := $(patsubst models/%.xsd,docs/%/index.html,$(SRC))

XERCESURL := https://downloads.apache.org/xerces/j/binaries/Xerces-J-bin.2.12.2.tar.gz
XSDVIURL := https://github.com/metanorma/xsdvi/releases/download/v1.0/xsdvi-1.0.jar
XS3PURL := https://github.com/metanorma/xs3p/archive/refs/tags/v3.0.tar.gz

XERCESPATH := xsdvi/xercesImpl.jar
XSDVIPATH := xsdvi/xsdvi.jar
XS3PPATH := xsl/xs3p.xsl

# Define URLs for additional resources
PREFIXES_PATH := https://github.com/unitsml/unitsdb/raw/main/prefixes.yaml
UNITS_PATH := https://github.com/unitsml/unitsdb/raw/main/units.yaml

# Default target
all: docs

docs: $(DOCS)

setup: $(XSDVIPATH) $(XERCESPATH) $(XS3PPATH)

# Generic rule to download and extract archives
.archive/%.tar.gz:
	mkdir -p $(dir $@)
	curl -sSL -o $@ $*
	tar -zxvf $@ -C $(dir $@) --strip-components=1

# Download and install XSDVI, Xerces, XS3P
$(XSDVIPATH): .archive/xsdvi-1.0.jar
	cp $< $@

$(XERCESPATH): .archive/Xerces-J-bin.2.12.2.tar.gz
	mv xsdvi/xerces-2_12_2/xercesImpl.jar $@

$(XS3PPATH): .archive/xs3p.tar.gz
	mv xsl/xs3p-3.0/xsl/* $@

# Create HTML documentation from XSD
docs/%/index.html: models/%.xsd $(XSDVIPATH) $(XERCESPATH) $(XS3PPATH)
	mkdir -p $(dir $@)diagrams
	java -jar $(XSDVIPATH) $< -rootNodeName all -oneNodeOnly -outputPath $(dir $@)diagrams
	xsltproc --nonet --param title "'Schema documentation $(notdir $<)'" --output $@ $(XS3PPATH) $<

# Clean targets
clean:
	rm -rf docs xsl xsdvi

distclean: clean
	rm -rf .archive

.PHONY: all clean setup distclean

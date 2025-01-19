# Variables for external tools
XERCESPATH := xsdvi/xercesImpl.jar
XSDVIPATH := xsdvi/xsdvi.jar
XS3PPATH := xsl/xs3p.xsl
XERCESURL := https://downloads.apache.org/xerces/j/binaries/Xerces-J-bin.2.12.2.tar.gz
XSDVIURL := https://github.com/metanorma/xsdvi/releases/download/v1.0/xsdvi-1.0.jar
XS3PURL := https://github.com/metanorma/xs3p/archive/refs/tags/v3.0.tar.gz
SRC := $(wildcard models/*/*.xsd)
DOCS := $(patsubst models/%/*.xsd,docs/%/index.html,$(SRC))

# Platform-specific settings
ifeq ($(OS),Windows_NT)
    SHELL := cmd
    XSLTPROC := xsltproc.exe
else
    SHELL := /bin/bash
    XSLTPROC := xsltproc
endif

# Main target
all: check_dependencies docs

# Check for required dependencies
check_dependencies:
    @which java > /dev/null || { echo "Java is required"; exit 1; }
    @which $(XSLTPROC) > /dev/null || { echo "xsltproc is required"; exit 1; }

# Fetch tools
.archive/%:
    mkdir -p $(dir $@)
    curl -sSL -o $@ $(1)

# Setup targets
setup: $(XSDVIPATH) $(XERCESPATH) $(XS3PPATH)

$(XSDVIPATH): .archive/xsdvi-1.0.jar
    mkdir -p $(dir $@)
    cp $< $@

$(XERCESPATH): .archive/Xerces-J-bin.2.12.2.tar.gz
    mkdir -p $(dir $@)
    tar -zxvf $< -C xsdvi --strip-components=1 xerces-2_12_2/xercesImpl.jar

$(XS3PPATH): .archive/xs3p.tar.gz
    mkdir -p $(dir $@)
    tar -zxvf $< -C xsl --strip-components=2 xs3p-3.0/xsl

# Documentation generation
docs/%/index.html: models/%/*.xsd $(XSDVIPATH) $(XERCESPATH) $(XS3PPATH)
    mkdir -p $(dir $@)diagrams
    java -jar $(XSDVIPATH) $< \
        -rootNodeName all \
        -oneNodeOnly \
        -outputPath $(dir $@)diagrams
    $(XSLTPROC) --nonet \
        --param title "'Schema documentation $(notdir $<)'" \
        --output $@ $(XS3PPATH) $<

# Clean up generated files
clean:
    rm -rf docs diagrams

# Full clean including dependencies
distclean: clean
    rm -rf .archive

.PHONY: all clean setup distclean check_dependencies

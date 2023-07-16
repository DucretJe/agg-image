.PHONY: all build

IMAGE_NAME ?= ghcr.io/ducretje/agg:test

# Colors
GREEN='\033[0;32m'
LGRAY='\033[0;37m'
NC='\033[0m'
ORANGE='\033[1;33m'
RED='\033[0;31m'

all: agg

define test_command
	@echo ${ORANGE}"Testing agg 🔬\n"${LGRAY} && \
	docker run --rm -v `pwd`:/workdir $(IMAGE_NAME) test.cast ; \
	echo && \
	if [ ! -f test.gif ]; then \
		echo ${RED} "test.gif not found"; \
		exit 1; \
	else \
		echo ${GREEN} "test.gif found"; \
	fi && \
	if ! file test.gif | grep -q "GIF image data"; then \
		echo ${RED} "test.gif is not a gif file"; \
		exit 1; \
	else \
		echo ${GREEN} "test.gif is a gif file"; \
	fi
endef

build:
	@cd ../docker && \
	docker buildx create --name multiarchbuilder --use && \
	docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE_NAME) .
	docker buildx rm multiarchbuilder

agg:
	$(call test_command)

check:
	@if [ -f test-fail ]; then \
		rm test-fail; \
		echo ${RED} Some tests failed; \
		exit 1; \
	fi

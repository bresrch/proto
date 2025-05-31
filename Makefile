.PHONY: setup clean v1 v2 generate_proto

# Makefile for generating gRPC code from .proto files
# This Makefile assumes you have protoc, protoc-gen-go, and protoc-gen-go-grpc installed.
# It also assumes you have a working Go environment set up.

all: v1 v2

# Define a generic rule for generating protobuf files
# Usage: make generate_proto VERSION=v1
generate_proto:
	$(eval VERSION_UPPER := $(shell echo $(VERSION) | tr 'a-z' 'A-Z'))
	@echo "Generating protobuf files for $(VERSION)..."
	find . -name '$(VERSION)/*.pb.go' -delete
	mkdir -p $(VERSION)/gen/$(VERSION)
	protoc --proto_path=./$(VERSION) \
		--go_out=./$(VERSION)/gen/$(VERSION) --go_opt=paths=source_relative \
		--go-grpc_out=./$(VERSION)/gen/$(VERSION) --go-grpc_opt=paths=source_relative \
		$(VERSION).proto
	@echo "Running go mod tidy and go mod vendor for $(VERSION)..."
	cd $(VERSION) && go mod tidy && go mod vendor && cd ..

setup:
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-protobuf@latest
	brew install protobuf

clean:
	rm -rf vendor
	rm -rf v1/gen v1/vendor v1/go.sum
	rm -rf v2/gen v2/vendor v2/go.sum

v1: clean
	$(MAKE) generate_proto VERSION=v1

v2: clean
	$(MAKE) generate_proto VERSION=v2



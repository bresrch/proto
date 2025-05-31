.PHONY: setup clean v1 v2

# Makefile for generating gRPC code from .proto files
# This Makefile assumes you have protoc, protoc-gen-go, and protoc-gen-go-grpc installed.
# It also assumes you have a working Go environment set up.
 
all: v1 v2

setup:
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-protobuf@latest
	brew install protobuf

clean:
	find . -name '*.pb.go' -delete
	rm -rf vendor

v1: clean
	protoc --proto_path=. \
		--go_out=./gen/v1 --go_opt=paths=source_relative \
		--go-grpc_out=./gen/v1 --go-grpc_opt=paths=source_relative \
		v1.proto
	go mod tidy
	go mod vendor

v2: clean
	protoc --proto_path=. \
		--go_out=./gen/v2 --go_opt=paths=source_relative \
		--go-grpc_out=./gen/v2 --go-grpc_opt=paths=source_relative \
		v2.proto
	go mod tidy
	go mod vendor

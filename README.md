# Bresrch Proto

This repository contains the Protocol Buffer definitions for the Bresrch platform, a Go-based framework for managing resources through plugins similar to Terraform.

## Overview

Bresrch Proto defines the gRPC service interfaces that providers must implement to integrate with the Bresrch platform. These definitions establish a standardized communication protocol between the core Bresrch service and various data providers.

The main service defined is `Resource`, which includes operations for:
- Version compatibility handshakes
- Configuration management
- Data synchronization
- Database migrations

## Requirements

- Go 1.24+
- Protocol Buffers compiler (protoc)
- gRPC Go plugins

## Setup

Install required tools:

```bash
make setup
```

This will install:
- protoc-gen-go-grpc
- protoc-gen-go-protobuf
- protobuf compiler (via Homebrew)

## Building

Generate Go code from Protocol Buffer definitions:

```bash
make v1
```

This will:
1. Clean any previously generated files
2. Generate Go code from the v1 protocol definitions
3. Update Go modules and create a vendor directory

## Usage

Include this repository as a dependency in your Bresrch provider implementation:

```bash
go get github.com/bresrch/proto
```

Then implement the required gRPC service interfaces defined in the generated Go files.

## Project Structure

```
.
├── Makefile               # Build automation
├── go.mod                 # Go module definition
├── go.sum                 # Go module checksums
├── v1/                    # Protocol buffer definitions (version 1)
│   ├── gen/               # Generated Go code
│   │   ├── resource.pb.go
│   │   └── resource_grpc.pb.go
│   └── resource.proto     # Protocol buffer definition file
└── vendor/                # Vendored dependencies
```

## Contributing

1. Ensure you understand the existing protocol definitions
2. Make your changes to the .proto files
3. Generate the corresponding Go code with `make v1`
4. Test your changes with provider implementations
5. Submit a pull request
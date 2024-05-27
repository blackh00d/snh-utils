#!/bin/bash

# Script to quickly reinitialize a Go module and rebuild from scratch

rm go.*
rm $gomod
go mod init $gomod
go mod tidy
go build -o $gomod
